import 'dart:math';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/DataBase/database.dart';
import 'package:notes_app/DataBase/note.dart';
import 'package:notes_app/helper/widgets/widgets.dart';
import 'package:notes_app/screens/create_note_screen.dart';
import 'package:notes_app/screens/note_details_screen.dart';
import 'package:notes_app/screens/search_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool isTtyDelete = false;

  List<String?>? colors = [
    'FF9E9E',
    '91F48F',
    'FFF599',
    '9EFFFF',
    'B69CFF'
  ];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  MyDataBase myDataBase = MyDataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Notes'),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return const SearchScreen();
                      }
                  )
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding:const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:const Color(0xff3B3B3B),
                  borderRadius: BorderRadius.circular(12)
                ),
                  child:const Icon(Icons.search)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding:const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color:const Color(0xff3B3B3B),
                  borderRadius: BorderRadius.circular(12)
              ),
              child:const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return Future(() => null);
        },
        child: FutureBuilder(
            future: myDataBase.notes(),
            builder: ((context, AsyncSnapshot<List<Note>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Text('Error no connection'),
                  );
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    const Center(
                      child: Text('no data'),
                    );
                  }
                  break;
              }
              return drawNotes(snapshot.data!.cast());
            })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateNoteScreen()));
        },
        child: const Icon(
          Icons.add,
          size: 48,
        ),
      ),
      //  floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget drawNotes(List<Note> notes) {
    return notes.isNotEmpty
        ? ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NoteDetailScreen(
                          title: notes[index].title, body: notes[index].body);
                    }));
                  },
                  child: Slidable(
                    key: const ValueKey(0),
                    endActionPane:  ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_)async{
                            await myDataBase.deleteNote(notes[index]);
                            setState(() {
                            });
                          },
                          backgroundColor:const  Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child:  Container(
                      width: 365,
                      height: 123,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                          color:Color(int.parse('0xFF${colors![Random().nextInt(colors!.length)]}')),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(notes[index].title!,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 25,color: Colors.black),),
                    ),
                  ),
                ),
              );
            })
        :  emptyScreen;
  }
}

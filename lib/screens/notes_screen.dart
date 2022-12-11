import 'package:Notes/DataBase/database.dart';
import 'package:Notes/DataBase/note.dart';
import 'package:Notes/helper/widgets/widgets.dart';
import 'package:Notes/screens/create_note_screen.dart';
import 'package:Notes/screens/note_details_screen.dart';
import 'package:Notes/screens/search_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

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
              child:GestureDetector(
                onTap: (){
                  setState(() {

                  });
                },
                  child: const Icon(Icons.refresh)),
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

                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
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
                          title: notes[index].title, body: notes[index].body,id: notes[index].id,color: notes[index].color,);
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
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                          color:Color(int.parse('0xFF'+notes[index].color!)),
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


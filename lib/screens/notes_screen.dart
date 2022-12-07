import 'package:flutter/material.dart';
import 'package:notes_app/DataBase/database.dart';
import 'package:notes_app/DataBase/note.dart';
import 'package:notes_app/screens/create_note_screen.dart';
import 'package:notes_app/screens/note_details_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool isTtyDelete = false;

  @override
  void initState() {
    setState(() {});
  }

  MyDataBase myDataBase = MyDataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          Icon(Icons.search),
          Icon(Icons.info_outline),
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
                  child: Container(
                    width: 365,
                    height: 123,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(notes[index].title!),
                  ),
                ),
              );
            })
        : const CircularProgressIndicator();
  }
}

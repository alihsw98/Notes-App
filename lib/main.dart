import 'package:flutter/material.dart';
import 'package:notes_app/DataBase/database.dart';
import 'package:notes_app/DataBase/note.dart';
import 'package:sqflite/sqflite.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MyDataBase myDataBase = MyDataBase();
  //Database db = await  myDataBase.initialDataBase();
  myDataBase.insertNote(Note(title: "kj", body: "bla bla bla",id: 3));
  List<Note> notes = await myDataBase.notes();
  for(Note note in notes){
    print(note.title);
  }
  print(notes.length);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NOTES',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:Scaffold(body: Container(),),
    );
  }
}

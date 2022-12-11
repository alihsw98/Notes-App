import 'package:Notes/DataBase/note.dart';
import 'package:Notes/screens/update_note_screen.dart';
import 'package:flutter/material.dart';

import '../DataBase/database.dart';

class NoteDetailScreen extends StatefulWidget {
   final int? id;
   final String? title;
   final String? body;
   final String? color;

   const NoteDetailScreen({super.key, required this.title, required this.body,required this.id,required this.color});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  MyDataBase myDataBase = MyDataBase();
  late String title;
  late String body;

  @override
  void initState() {
    title = widget.title!;
    body = widget.body!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding:const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:const Color(0xff3B3B3B),
                    borderRadius: BorderRadius.circular(12)
                ),
                child:const Center(child: Icon(Icons.arrow_back_ios),)
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: ()  async{
              final Note data = await Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                  return  UpdateNoteScreen(id: widget.id,title: widget.title,body: widget.body!,color: widget.color,);
                }));
              setState(() {
                title = data.title!;
               body = data.body!;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding:const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color:const Color(0xff3B3B3B),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child:const Center(child: Icon(Icons.edit),)
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
              child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
          )),
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Text(body,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 23,
                    fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}

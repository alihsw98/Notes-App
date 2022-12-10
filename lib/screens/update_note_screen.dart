import 'package:flutter/material.dart';
import 'package:notes_app/DataBase/database.dart';
import 'package:lottie/lottie.dart';

import '../DataBase/note.dart';


class UpdateNoteScreen extends StatefulWidget {
  final int? id;
  final String? title;
  final String? body;

  const UpdateNoteScreen({required this.id, required this.title,required this.body,Key? key}) : super(key: key);

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  MyDataBase myDataBase = MyDataBase();
  @override
  void initState() {
    titleController.text = widget.title!;
    bodyController.text = widget.body!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context,Note(id: widget.id,title: titleController.text,body: bodyController.text)),
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
            onTap: () async{
              await myDataBase.updateNote(widget.id!, titleController.text, bodyController.text);
              _showMessage();
            },
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding:const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color:const Color(0xff3B3B3B),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child:const Icon(Icons.save)
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 35,
                      height: 1.5),
                  decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(
                      color: Color(0xff9A9A9A),
                      fontWeight: FontWeight.w400,
                      fontSize: 23,
                    ),
                  ),
                  maxLines: 4,
                  minLines: 1,
                ),
                TextFormField(
                  controller: bodyController,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 23),
                  decoration: const InputDecoration(
                    hintText: "Type something...",
                    hintStyle: TextStyle(
                      color: Color(0xff9A9A9A),
                      fontWeight: FontWeight.w400,
                      fontSize: 23,
                    ),
                  ),
                  maxLines: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showMessage(){
    SnackBar snackBar = SnackBar(
      content:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Updated",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Lottie.asset("assets/animation/success_animate.json",
                width: 80),
          ),

        ],
      ),
        elevation: 0,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.amber
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}

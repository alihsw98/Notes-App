import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/DataBase/database.dart';
import 'package:notes_app/DataBase/note.dart';
import 'package:notes_app/helper/colors.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool discard = false;

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
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding:const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color:const Color(0xff3B3B3B),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child:const Icon(Icons.remove_red_eye_outlined)
            ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showSaveDialog();
            },
            child:
            Padding(
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

  Future<void> _showSaveDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            Icons.info,
            size: 36,
            color: AppColors.grey200,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                    child: Text( 'Save changes ?',
                  style: TextStyle(
                      color: AppColors.grey300,
                      fontSize: 23,
                      fontWeight: FontWeight.w400),
                )),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: ()async{
                      await _showConfirmDialog();
                    },
                    child: Container(
                      width: 112,
                      height: 39,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Discard',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      MyDataBase myDataBase = MyDataBase();
                      await myDataBase.addNote(titleController.text, bodyController.text);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 112,
                      height: 39,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _showConfirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            Icons.info,
            size: 36,
            color: AppColors.grey200,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                    child: Text( 'Are your sure you want discard your changes ?',
                      style: TextStyle(
                          color: AppColors.grey300,
                          fontSize: 23,
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      titleController.clear();
                      bodyController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateNoteScreen()),
                      );
                    },
                    child: Container(
                      width: 112,
                      height: 39,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Discard',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()  {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 112,
                      height: 39,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Keep',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

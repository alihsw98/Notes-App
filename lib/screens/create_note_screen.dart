import 'package:Notes/DataBase/database.dart';
import 'package:Notes/helper/colors.dart';
import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  String color = '';

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
            onTap: ()async {
              await choseColorDialog();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding:const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color:const Color(0xff3B3B3B),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child:const Icon(Icons.color_lens_rounded,color: Colors.purple,)
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
                    onTap: (){
                     Navigator.pop(context);
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
                      await myDataBase.addNote(titleController.text, bodyController.text,color);
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

  Future<void> choseColorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                    child: Text( 'Chose background color',
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

                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = '91F48F';
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration:const BoxDecoration(
                          color: Color(0xFF91F48F),
                          shape: BoxShape.circle,),
                    ),
                  ),
                  const SizedBox(width: 1,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = 'FF9E9E';
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration:const BoxDecoration(
                          color:  Color(0xFFFF9E9E),
                        shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(width: 1,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = 'FFF599';
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration:const BoxDecoration(
                          color:  Color(0xFFFFF599),
                          shape: BoxShape.circle,
                        ),
                    ),
                  ),
                  const SizedBox(width: 1,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = '9EFFFF';
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration:const BoxDecoration(
                          color: Color(0xFF9EFFFF),
                          shape: BoxShape.circle,
                          ),
                    ),
                  ),
                  const SizedBox(width: 1,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        color = 'B69CFF';
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration:const BoxDecoration(
                          color:  Color(0xFFB69CFF),
                          shape: BoxShape.circle,),
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

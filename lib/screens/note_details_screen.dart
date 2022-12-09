import 'package:flutter/material.dart';
import 'package:notes_app/helper/colors.dart';

class NoteDetailScreen extends StatefulWidget {
  final String? title;
  final String? body;

  const NoteDetailScreen({super.key, required this.title, required this.body});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
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
                  child:const Center(child: Icon(Icons.edit),)
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
              child: Text(
            widget.title!,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
          )),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Text(widget.body!,
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

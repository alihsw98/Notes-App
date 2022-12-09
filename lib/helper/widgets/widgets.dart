
import 'package:flutter/material.dart';

Container deleteNoteCard = Container(
  width: 365,
  height: 123,
  decoration: (
  BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(16)
  )
  ),
);


Column emptyScreen = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset("assets/images/empty.png"),
    const Text("Create your first note !",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)
  ],
);
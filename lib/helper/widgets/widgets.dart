
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

Column noResult = Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Image.asset("assets/images/no_result.png"),
    const Text("Note not found. Try searching again.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)
  ],
);
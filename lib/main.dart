import 'package:flutter/material.dart';
import 'package:notes_app/screens/notes_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NOTES',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        floatingActionButtonTheme:const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff252525),
          foregroundColor: Colors.white
        ),
        textTheme:const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 43.0, fontWeight: FontWeight.w600),
          bodyText2: TextStyle(fontSize: 25, fontFamily: 'Nunito',fontWeight: FontWeight.w400,color: Colors.white),
        ),
        inputDecorationTheme:const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        ),
        useMaterial3: true,
        appBarTheme:const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home:const NotesScreen()
    );
  }

}

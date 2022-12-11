import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notes_app/DataBase/database.dart';
import 'package:notes_app/DataBase/note.dart';
import 'package:notes_app/helper/widgets/widgets.dart';
import 'package:notes_app/screens/note_details_screen.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Note> searchResult = [];
  List<Note> notes = [];
  MyDataBase myDataBase = MyDataBase();


  List<String?>? colors = [
    'FF9E9E',
    '91F48F',
    'FFF599',
    '9EFFFF',
    'B69CFF'
  ];

  @override
  void initState() {
    getNotes();
    notes.forEach((element) {print(element.title);});
    super.initState();
  }
  Future<void> getNotes()async{
    notes = await myDataBase.notes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
                hintText: "Search by the keyword...",
                hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Color(0xFFCCCCCC)),
                filled: true,
                suffixIcon: GestureDetector(
                  onTap: ()=>Navigator.pop(context),
                    child: const Icon(Icons.close,color: Colors.white,))
              ),
              maxLines: 1,
              onChanged: (_) {
                setState(() {
                  searchResult = notes
                      .where((element) =>
                      element.title!.contains(_searchController.text))
                      .toList();
                });
              },
            ),
          ),
        ),
      ),
      body: searchResult.isNotEmpty ?
      ListView.builder(
          itemCount: searchResult.length,
          itemBuilder: (context,index){
            return
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return NoteDetailScreen(title: searchResult[index].title, body: searchResult[index].body, id: searchResult[index].id);
                            }
                        )
                    );
                  },
                  child: Container(
                    width: 365,
                    height: 123,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                        color:Color(int.parse('0xFF${colors![Random().nextInt(colors!.length)]}')),
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(searchResult[index].title!,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 25,color: Colors.black),),
                  ),
                ),
              );
          }):SingleChildScrollView(child: noResult)
    );
  }
}

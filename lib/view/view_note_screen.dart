import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_storage_sqlite/db/db_hepler.dart';
import 'package:local_storage_sqlite/view/add_note_screen.dart';
class ViewNoteScreen extends StatefulWidget {
   ViewNoteScreen({super.key});

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}
class _ViewNoteScreenState extends State<ViewNoteScreen> {
  List<Map<String,dynamic>> listNote =[];

  Future<void> getData() async{
    listNote = await DbHepler.getNote();
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading:false  ,
        backgroundColor: Colors.white,
        title: Text("Keep Note",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: listNote.length,
        itemBuilder: (context, index) {
          final note = listNote[index];
          int id = listNote[index]['id'];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Dismissible(
              key: Key(index.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
              ) ,
              onDismissed: (direction) {
                DbHepler.deleteNote(id);
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${note['position']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Text("${note['skill']}"),
                          Spacer(),
                          Text("${note['date']}")
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text("${note['category']}",style: TextStyle(fontSize: 18),),
                          Spacer(),
                          // Button Update
                          IconButton(
                            onPressed: () {
                               // show dialog
                               showDialog(
                                context: context, 
                                builder: (context) {
                                  TextEditingController oldPosition = TextEditingController();
                                  TextEditingController oldSkill = TextEditingController();
                                  String selectedCat = note['category'];
                                  oldPosition.text = note['position'];
                                  oldSkill.text = note['skill'];
                                  return StatefulBuilder(
                                    builder: (context, setState) =>  AlertDialog(
                                      title: Container(
                                        width: 400,
                                        height: 400,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Update"),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text("Position",style: TextStyle(fontSize: 16),),
                                            TextField(
                                              controller: oldPosition,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12)
                                                ),
                                               
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("Skill",style: TextStyle(fontSize: 16),),
                                            TextField(
                                              controller: oldSkill,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12)
                                                ),
                                                      
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text("Category",style: TextStyle(fontSize: 16),),
                                                Spacer(),
                                                IconButton(onPressed: (){
                                                  setState(() {
                                                    selectedCat="Personal";
                                                  });
                                                }, icon:(selectedCat=="Personal")?Icon(Icons.radio_button_checked): Icon(Icons.radio_button_off)),
                                                Text("Personal",style: TextStyle(fontSize: 16),),
                                                IconButton(onPressed: (){
                                                  setState(() {
                                                    selectedCat="Work";
                                                  });
                                    
                                                }, icon:(selectedCat=="Work")?Icon(Icons.radio_button_checked): Icon(Icons.radio_button_off)),
                                                Text("Work",style: TextStyle(fontSize: 16),)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("Cancel")),
                                         TextButton(onPressed: (){
                                          DbHepler.updateNote(id, oldPosition.text, oldSkill.text, selectedCat, DateTime.now().toString());
                                          Navigator.pop(context);
                                         }, child: Text("Update")),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }, 
                            icon: Icon(Icons.edit,color: Colors.blue,)
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNoteScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
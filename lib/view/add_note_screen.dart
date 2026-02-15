import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_storage_sqlite/db/db_hepler.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController position = TextEditingController();

  TextEditingController skill = TextEditingController();

  String selectedCat = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {}, child: Text("Cancel")),
            Text("Add Note", style: TextStyle(fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                DbHepler.insertNote(position.text, skill.text, selectedCat, DateTime.now().toString());
                // clear textField
                position.clear();
                skill.clear();
                // 
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextField(
                  controller: position,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.title),
                    hintText: "Enter Positoin",
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextField(
                  controller: skill,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.title),
                    hintText: "Enter Skill",
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text("Category", style: TextStyle(fontSize: 20)),
                Spacer(),

                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedCat = "Personal";
                    });
                    log("${selectedCat}");
                  },
                  icon: (selectedCat == "Personal")
                      ? Icon(Icons.radio_button_checked)
                      : Icon(Icons.radio_button_off),
                ),
                Text("Personal"),
                SizedBox(width: 20),

                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedCat = "Work";
                    });
                    log("$selectedCat");
                  },
                  icon: (selectedCat == "Work")
                      ? Icon(Icons.radio_button_checked)
                      : Icon(Icons.radio_button_off),
                ),
                Text("Work"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ocrupdate/pages/attendance_page.dart';
import 'package:ocrupdate/pages/mark_page.dart';

import 'homepage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home_Page")),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0,),
          GestureDetector(
          onTap: () {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MarkPage()),
      );
      },
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12)
            ),
            margin: EdgeInsets.symmetric(vertical:6,horizontal: 25),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.adf_scanner_outlined),
                SizedBox(width: 25,),
                Text("Answer Sheet Mark Extraction"),
              ],
            ),
          ),
        ) ,
            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)
                ),
                margin: EdgeInsets.symmetric(vertical:6,horizontal: 25),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.document_scanner_outlined),
                    SizedBox(width: 25,),
                    Text("Optical Character Recognition"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendancePage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)
                ),
                margin: EdgeInsets.symmetric(vertical:6,horizontal: 25),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 25,),
                    Text("Student Attendance calculation using OCR"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

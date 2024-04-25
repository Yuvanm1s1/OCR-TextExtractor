import 'package:flutter/material.dart';
class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key, required this.text_recognized});
  final String text_recognized;
  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recognized Text"),),
      body: Center(
        child: Container(
          child: Text(
            widget.text_recognized,
          ),
        ),
      ),
    );
  }
}

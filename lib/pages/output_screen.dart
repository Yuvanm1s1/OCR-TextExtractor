import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  final List<dynamic> output;

  const OutputScreen({Key? key, required this.output}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Output Screen'),
      ),
      body: ListView.builder(
        itemCount: output.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Student ${index + 1} is present for ${output[index]} days'),
          );
        },
      ),
    );
  }
}

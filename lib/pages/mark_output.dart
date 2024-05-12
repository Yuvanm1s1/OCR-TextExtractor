import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  final List<dynamic> output;

  const OutputScreen({Key? key, required this.output}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, int> marks = {};
    int index = 1;

    for (int i = 0; i < output.length; i++) {
      for (int j = 0; j < output[i].length; j++) {
        if (j % 2 != 0 && i == 2) {
          continue;
        }
        if (i == 2 && j % 2 == 0) {
          marks[index] = int.parse('${output[i][j]}${output[i][j + 1]}');
        } else {
          marks[index] = output[i][j];
        }
        index++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Output Screen'),
      ),
      body: ListView.builder(
        itemCount: marks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                'Mark for question no ${index + 1} is ${marks[index + 1]}'),
          );
        },
      ),
    );
  }
}
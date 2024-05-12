import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'output_screen.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late File _image = File('');
  List<dynamic> _output = [];

  final picker = ImagePicker();

  Future<void> _uploadImage(File imageFile) async {
    final url = 'https://4c32-122-174-248-232.ngrok-free.app/process_image';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    var fileStream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile(
      'file',
      fileStream,
      length,
      filename: imageFile.path.split('/').last,
    );
    request.files.add(multipartFile);
    request.headers['Content-Type'] = 'multipart/form-data';

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var responseData = json.decode(responseBody);
      setState(() {
        _output = responseData['output'];
      });

      // Navigate to the output screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OutputScreen(output: _output)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image: ${response.reasonPhrase}'),
        ),
      );
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _uploadImage(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Calculator"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: _image == null || _image.path.isEmpty
                ? Icon(
              Icons.image,
              size: 150,
              color: Colors.grey,
            )
                : Image.file(
              _image,
              height: 300,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => pickImage(ImageSource.camera),
            icon: Icon(Icons.camera),
            label: Text('Camera'),
          ),
          ElevatedButton.icon(
            onPressed: () => pickImage(ImageSource.gallery),
            icon: Icon(Icons.photo_library),
            label: Text('Gallery'),
          ),
        ],
      ),
    );
  }
}

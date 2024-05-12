// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'display.dart';
// import 'output_screen.dart';
// class AttendancePage extends StatefulWidget {
//   const AttendancePage({super.key});
//
//   @override
//   State<AttendancePage> createState() => _AttendancePageState();
// }
//
// class _AttendancePageState extends State<AttendancePage> {
//
// bool _loading = true;
// late File _image;
// List _output = [];
// final picker = ImagePicker();
// Future<void> _uploadImage(File imageFile) async {
//   final url = 'https://234a-122-174-248-232.ngrok-free.app/process_image';
//
//   // Create a multipart request
//   var request = http.MultipartRequest('POST', Uri.parse(url));
//
//   // Add the image file to the request
//   var fileStream = http.ByteStream(imageFile.openRead());
//   var length = await imageFile.length();
//   var multipartFile = http.MultipartFile(
//     'file',
//     fileStream,
//     length,
//     filename: imageFile.path.split('/').last,
//   );
//   request.files.add(multipartFile);
//
//   // Set headers
//   request.headers['Content-Type'] = 'multipart/form-data';
//
//   // Send the request
//   var response = await request.send();
//
//   // Check the response status code
//   if (response.statusCode == 200) {
//     // Read and parse the response body
//     var responseBody = await response.stream.bytesToString();
//     var responseData = json.decode(responseBody);
//
//     // Assuming your response contains a key named 'output'
//     final List<dynamic> output = responseData['output'];
//
//     // Navigate to the output screen and pass the output data as arguments
//     Navigator.push(
//       context as BuildContext,
//       MaterialPageRoute(builder: (context) => OutputScreen(output: output)),
//     );
//   } else {
//     // If the server returns an error response, throw an exception or handle it accordingly
//     setState(() {
//       _loading = false;
//     });
//     throw Exception('Failed to upload image: ${response.reasonPhrase}');
//   }
// }
//
//
// PickFromCamera() async {
//   var image = await picker.pickImage(
//     source: ImageSource.camera,
//   );
//   if (image == null) return null;
//   setState(() {
//     _image = File(image.path);
//   });
//
// }
//
// PickFromGallery() async {
//   var image = await picker.pickImage(
//     source: ImageSource.gallery,
//   );
//   if (image == null) return null;
//   setState(() {
//     _image = File(image.path);
//     _uploadImage(_image);
//   });
//
// }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(
//         "Attendance Calculator",
//         style: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       backgroundColor: Colors.blue,
//     ),
//     body: Column(
//       children: [
//         SizedBox(height: 20),
//         Container(
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: PickFromCamera,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width - 150,
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 17,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     "Camera",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               GestureDetector(
//                 onTap: PickFromGallery,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width - 150,
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 17,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     "Gallery",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 20),
//         // Display output here
//         _output != null
//             ? Expanded(
//           child: ListView.builder(
//             itemCount: _output.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('Student ${index + 1} is present for ${_output[index]} days and absent for ${10 - _output[index]} days.'),
//               );
//             },
//           ),
//         )
//             : SizedBox.shrink(), // If output is null, hide the ListView
//       ],
//     ),
//   );
// }
//
//
// }










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

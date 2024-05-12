// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'mark_output.dart';
//
//
// class MarkPage extends StatefulWidget {
//   const MarkPage({super.key});
//
//   @override
//   State<MarkPage> createState() => _MarkPageState();
// }
//
// class _MarkPageState extends State<MarkPage> {
//   bool _loading = true;
//   late File _image;
//   List _output = [];
//   final picker = ImagePicker();
//   Future<void> _uploadImage(File imageFile) async {
//     final url = 'https://4c32-122-174-248-232.ngrok-free.app/process_image';
//
//     // Create a multipart request
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//
//     // Add the image file to the request
//     var fileStream = http.ByteStream(imageFile.openRead());
//     var length = await imageFile.length();
//     var multipartFile = http.MultipartFile(
//       'file',
//       fileStream,
//       length,
//       filename: imageFile.path.split('/').last,
//     );
//     request.files.add(multipartFile);
//
//     // Set headers
//     request.headers['Content-Type'] = 'multipart/form-data';
//
//     // Send the request
//     var response = await request.send();
//
//     // Check the response status code
//     if (response.statusCode == 200) {
//       // Read and parse the response body
//       var responseBody = await response.stream.bytesToString();
//       var responseData = json.decode(responseBody);
//
//       // Assuming your response contains a key named 'output'
//       final List<dynamic> output = responseData['output'];
//
//       // Navigate to the output screen and pass the output data as arguments
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => OutputScreen(output: output)),
//       );
//     } else {
//       // If the server returns an error response, throw an exception or handle it accordingly
//       setState(() {
//         _loading = false;
//       });
//       throw Exception('Failed to upload image: ${response.reasonPhrase}');
//     }
//   }
//
//
//   PickFromCamera() async {
//     var image = await picker.pickImage(
//       source: ImageSource.camera,
//     );
//     if (image == null) return null;
//     setState(() {
//       _image = File(image.path);
//     });
//
//   }
//
//   PickFromGallery() async {
//     var image = await picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (image == null) return null;
//     setState(() {
//       _image = File(image.path);
//       _uploadImage(_image);
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "HomePage",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: PickFromCamera,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width - 150,
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 17,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       "Take a photo",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: PickFromGallery,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width - 150,
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 17,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       "Choose image from gallery",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }



import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'mark_output.dart';

class MarkPage extends StatefulWidget {
  const MarkPage({Key? key}) : super(key: key);

  @override
  State<MarkPage> createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  bool _loading = true;
  late File _image;
  late Widget _imageWidget; // Widget to display the image or icon
  List _output = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imageWidget = Icon(Icons.image, size: 100); // Initial image icon
  }

  Future<void> _uploadImage(File imageFile) async {
    final url = 'https://4c32-122-174-248-232.ngrok-free.app/process_image';

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add the image file to the request
    var fileStream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile(
      'file',
      fileStream,
      length,
      filename: imageFile.path.split('/').last,
    );
    request.files.add(multipartFile);

    // Set headers
    request.headers['Content-Type'] = 'multipart/form-data';

    // Send the request
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      // Read and parse the response body
      var responseBody = await response.stream.bytesToString();
      var responseData = json.decode(responseBody);

      // Assuming your response contains a key named 'output'
      final List<dynamic> output = responseData['output'];

      // Navigate to the output screen and pass the output data as arguments
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OutputScreen(output: output)),
      );
    } else {
      // If the server returns an error response, throw an exception or handle it accordingly
      setState(() {
        _loading = false;
      });
      throw Exception('Failed to upload image: ${response.reasonPhrase}');
    }
  }

  PickFromCamera() async {
    var image = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
      _uploadImage(_image); // Send the picked image to the server
      _imageWidget = Image.file(_image, width: 100, height: 100, fit: BoxFit.cover); // Update the image widget to display the picked image
    });
  }

  PickFromGallery() async {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
      _uploadImage(_image); // Send the picked image to the server
      _imageWidget = Image.file(_image, width: 100, height: 100, fit: BoxFit.cover); // Update the image widget to display the picked image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mark Extraction Page",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _imageWidget, // Display the image icon or picked image
                SizedBox(height: 20),
                GestureDetector(
                  onTap: PickFromCamera,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 17,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Take a photo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: PickFromGallery,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 17,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Choose image from gallery",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





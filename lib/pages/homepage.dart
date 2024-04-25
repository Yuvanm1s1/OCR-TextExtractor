// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// bool textScanning = false;
// XFile? imageFile;
// String scannedText = "";
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             centerTitle: true,
//             title: Text("OCR Text Recognition App")
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if(textScanning == true) const CircularProgressIndicator(),
//                   if(!textScanning == true && imageFile ==null) Container(
//                     width: 100,height: 100,color: Colors.grey,
//                   ),
//                   if(imageFile != null) Image.file(File(imageFile!.path)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           padding: const EdgeInsets.only(top: 10),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.grey, backgroundColor: Colors.white,
//                               shadowColor: Colors.grey[400],
//                               elevation: 10,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.0)),
//                             ),
//                             onPressed: () {
//                               getImage();
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 5),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.image,
//                                     size: 30,
//                                   ),
//                                   Text(
//                                     "Gallery",
//                                     style: TextStyle(
//                                         fontSize: 13, color: Colors.grey[600]),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )),
//                       Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           padding: const EdgeInsets.only(top: 10),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.grey, backgroundColor: Colors.white,
//                               shadowColor: Colors.grey[400],
//                               elevation: 10,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.0)),
//                             ),
//                             onPressed: () {
//                               getImageCamera();
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 5),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.camera_alt,
//                                     size: 30,
//                                   ),
//                                   Text(
//                                     "Camera",
//                                     style: TextStyle(
//                                         fontSize: 13, color: Colors.grey[600]),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
//
//
//
// void getImage() async{
//   try{
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if(pickedImage != null) {
//       textScanning = true;
//       imageFile = pickedImage as XFile?;
//     }
//   }
//   catch(e){
//     textScanning=false;
//     imageFile=null;
//   }
// }
//
// void getImageCamera() async{
//   try{
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
//     if(pickedImage != null) {
//       textScanning = true;
//       imageFile = pickedImage as XFile?;
//     }
//   }
//   catch(e){
//     textScanning=false;
//     imageFile=null;
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'display.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State
{
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";

  void getImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          textScanning = true;
          imageFile = pickedImage as XFile?;
          getRecognizedText(imageFile!);
        });
      }
    } catch (e) {
      setState(() {
        textScanning = false;
        imageFile = null;
      });
    }
  }

  void getImageCamera() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          textScanning = true;
          imageFile = pickedImage as XFile?;
        });
      }
    } catch (e) {
      setState(() {
        textScanning = false;
        imageFile = null;
      });
    }
  }

  void getRecognizedText(XFile image) async{
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer();
    final  recognizedText = await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    textScanning = false;

    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(text_recognized: text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("OCR Text Recognition App"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning == true) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          backgroundColor: Colors.white,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          getImage();

                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.image,
                                size: 30,
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          backgroundColor: Colors.white,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          getImageCamera();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 30,
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:ocrupdate/firebase_options.dart';
  import 'package:ocrupdate/pages/homepage.dart';
  import 'package:ocrupdate/pages/login_page.dart';
  import 'package:ocrupdate/services/auth_gate.dart';

  void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
            );
    }
  }
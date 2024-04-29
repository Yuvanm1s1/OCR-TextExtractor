import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ocrupdate/pages/login_page.dart';
import 'package:ocrupdate/pages/main_page.dart';
// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});
// //constantly listening to auth state changes
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream:FirebaseAuth.instance.authStateChanges(),
//         builder: (context , snapshot){
//           // logged in
//           if(snapshot.hasData){
//             return  MainPage();
//           }
//           else{
//             return LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}



// class AuthGate extends StatelessWidget {
//   const AuthGate({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, AsyncSnapshot<User?> snapshot) {
//           print('Connection State: ${snapshot.connectionState}');
//           print('Has Data: ${snapshot.hasData}');
//           print('Data: ${snapshot.data}');
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }
//
//           if (snapshot.hasData && snapshot.data != null) {
//             return MainPage();
//           } else {
//             return LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }


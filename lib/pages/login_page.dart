import 'package:flutter/material.dart';
import 'package:ocrupdate/pages/homepage.dart';

import '../services/auth_service.dart';
import 'main_page.dart';
class LoginPage extends StatefulWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
   LoginPage({super.key});


   Future<void> login(BuildContext context) async {
    //getauth service
    final authService = AuthService();
    try{
      await authService.signInWithEmailPassword(_emailcontroller.text, _passwordcontroller.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }

    catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title:Text(e.toString()),
      ) );
    }
  }
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Zenith_Ocr_Extractor",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold
                ),),
              Text("Login To Your App",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(
                height: 44.0,
              ),
              TextField(
                controller: widget._emailcontroller,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              SizedBox(
                  height: 20.0
              ),
              TextField(
                controller: widget._passwordcontroller,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Pasword",
                  prefixIcon: Icon(Icons.security),
                ),
              ),
              SizedBox(height: 30.0,),
              GestureDetector(
                onTap: (){

                  widget.login(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(),
                  //   ),
                  // );
                },
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration:BoxDecoration(color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(20.0)) ,
                  child: Row(
                    children: [
                      Icon(Icons.login),SizedBox(width: 5.0,),Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

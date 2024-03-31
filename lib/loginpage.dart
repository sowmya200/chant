import 'package:flutter/material.dart';

import 'package:chant/signinpage.dart';
import 'package:chant/appbar.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(  
            padding: EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
              const Text(
                  "Login On Your Account",
                  style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

               DecoratedBox( 
                decoration:const BoxDecoration( 
                  border: Border( 
                    bottom: BorderSide(
                      color: Colors.grey),
                       ),
                     ), 
                child: ElevatedButton( 
                  onPressed: () { }, 
                  child:const Text('Button'),
                   style: ElevatedButton.styleFrom( 
                    elevation: 0,), ), ),



              const Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Phone Number',  
                      hintText: '+43 123-456-7890',  
                    ),  
                  ),  
                ), 
             
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Don't Have Account?"),
                  TextButton(
                    onPressed: () {
                // Navigate to signup page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                  (route) => false, // Remove all routes below the new page
                );
              },
              child: const Text('Sign Up'),),
              ]),
          ],
        ),
      ),
    ]));
  }
}








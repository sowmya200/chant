import 'package:flutter/material.dart';
import 'package:chant/loginpage.dart';
import 'package:chant/appbar.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late MyAppBar myAppBar;
  @override
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //appBar:const MyAppBar(),
       body:
       Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),

    //body:
  );}



  }


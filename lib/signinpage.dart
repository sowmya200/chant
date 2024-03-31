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
  void initState() {
    super.initState();
    // Initialize MyAppBar here
    myAppBar = const MyAppBar();
  }

  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       appBar:const MyAppBar(),

    //body:
  );}



  }


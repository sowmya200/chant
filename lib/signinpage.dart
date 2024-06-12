import 'package:chant/chat_page.dart';
import 'dart:io';
import 'package:chant/imageConnection.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:chant/loginpage.dart';
import 'package:chant/SignInVerification.dart';
import 'package:chant/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:chant/email auth/emailOtp.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  String generateOTP() {
    // Generate a random 6-digit OTP
    Random random = Random();
    int otp = random.nextInt(999999 - 100000) +
        100000; // Generates a random number between 100000 and 999999
    return otp.toString();
  }

  // void sendOtp() async {
  //   EmailAuth.sessionName = "test Session";
  // }

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
   final EmailSender _emailSender = EmailSender();

   Future<String> _sendEmail() async {
    final toEmail = emailController.text;
    final subject = "Otp verification";
    final otp=generateOTP();
    final body = "Your otp is"+otp;

    try {
      await _emailSender.sendEmail(toEmail, subject, body);

      // Show a snackbar to indicate email sent
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email sent successfully to $toEmail')),
      );

    } catch (e) {
      // Handle any errors from sending the email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email: $e')),
      );
    }
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar:const MyAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
              ),
              const Text(
                "SignIn For Account                           ",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 18,
              ),
              Row(children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color.fromARGB(255, 90, 50, 200)),
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        IconData(0xe3b2, fontFamily: 'MaterialIcons'),
                        color: Color.fromARGB(255, 90, 50,
                            200), // Adjust the color of the icon as needed
                      ),
                      label: const Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.verified_user,
                        size: 24, // Adjust the size of the icon as needed
                        color: Colors.black87,
                        //IconData(0xe5ca, fontFamily: 'MaterialIcons'),
                      ),
                      label: const Text(
                        'Verification',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ]),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: nameController,
                  //obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintText: 'Enter full name...',
                    prefixIcon: Icon(
                      Icons.person,
                      color:
                          Colors.grey, // Adjust the color of the icon as needed
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: emailController,
                  keyboardType:
                      TextInputType.emailAddress, // Set keyboard type to email
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                    hintText: 'example@gmail.com',
                    prefixIcon: Icon(
                      Icons.email,
                      color:
                          Colors.grey, // Adjust the color of the icon as needed
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: phoneNumberController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10)
                  ], // Restrict to 10 characters
                  keyboardType:
                      TextInputType.phone, // Set keyboard type to phone
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: '+43 123-456-7890',
                    prefixIcon: Icon(
                      IconData(0xe4a2, fontFamily: 'MaterialIcons'),
                      color:
                          Colors.grey, // Adjust the color of the icon as needed
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: passwordController,
                  //   obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Set a Password',
                    hintText: 'Enter Your Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color:
                          Colors.grey, // Adjust the color of the icon as needed
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                        10), // Set max length of password
                    FilteringTextInputFormatter.allow(RegExp(
                        r'^[a-zA-Z0-9@#$%^&+=]*$')), // Allow only certain characters
                  ],
                  onEditingComplete: () {
                    if (passwordController.text.length < 8) {
                      _showPasswordLengthAlert(context);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  label: const Text('Next Step',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 19)),
                  onPressed: () {
                    String StringOtp=_sendEmail() as String;
                    int otp = int.parse(StringOtp);


                    CollectionReference collRef =
                        FirebaseFirestore.instance.collection('client');
                    String customDocumentId = nameController.text;
                    collRef.doc(customDocumentId).set({
                      'name': nameController.text,
                      'phonenumber': phoneNumberController.text,
                      'password': passwordController.text,
                      'email': emailController.text,
                      'otp':otp,
                    });

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignInVerification(
                                nameController: nameController,
                                phoneNumberController: phoneNumberController,
                                passwordController: passwordController,
                                emailController: emailController,

                              )),
                      (route) => false, // Remove all routes below the new page
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 90, 50, 200)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("You Have Account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) =>
                              false, // Remove all routes below the new page
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ]),
            ],
          ), /* add child content here */
        ),
      ),

      //body:
    );
  }
}

void _showPasswordLengthAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Password Length'),
        content: Text('Password must contain at least 8 characters.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the alert dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

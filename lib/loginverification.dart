import 'package:chant/appbar.dart';
import 'package:chant/loginpage.dart';
import 'package:chant/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chant/SigninVerification.dart';
import 'package:chant/chat_page.dart';
import 'package:chant/chatconnections/fetchingdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginVerification extends StatefulWidget {
  final TextEditingController nameController;
  // final String verificationId;

  LoginVerification({required this.nameController});

  @override
  _LoginVerificationState createState() => _LoginVerificationState();
}

class _LoginVerificationState extends State<LoginVerification> {
  // final TextEditingController OTPController = TextEditingController();
  // FirebaseAuth auth = FirebaseAuth.instance;

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Login On Your Account",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
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
                          BorderSide(color: Color.fromARGB(255, 252, 252, 252)),
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      IconData(0xe3b2, fontFamily: 'MaterialIcons'),
                      color: Color.fromARGB(255, 0, 0,
                          0), // Adjust the color of the icon as needed
                    ),
                    label: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
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
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 90, 50, 200)),
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.verified_user,
                      size: 24, // Adjust the size of the icon as needed
                      color: Color.fromARGB(255, 90, 50, 200),
                      //IconData(0xe5ca, fontFamily: 'MaterialIcons'),
                    ),
                    label: const Text('Verification'),
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
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color:
                        Colors.grey, // Adjust the color of the icon as needed
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
                icon: const Icon(
                  IconData(0xe3b2, fontFamily: 'MaterialIcons'),
                  color: Color.fromARGB(255, 255, 255,
                      255), // Adjust the color of the icon as needed
                ),
                label: const Text('Login',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 19)),
               onPressed: () async {
  // Fetch the document from Firestore
  FirebaseFirestore.instance
      .collection('client')
      .doc(widget.nameController.text) // Use the value of nameController as the document ID
      .get()
      .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    // Check if the document exists
    if (documentSnapshot.exists) {
      // Get the password field from the document
      String? password = documentSnapshot.data()!['password']; // Add the cast operation here

      // Compare the fetched password with the value of passwordController
      if (password == passwordController.text) {
        // If the passwords match, navigate to the next page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentListPage(
              nameController: widget.nameController,
              // passwordController: passwordController,
            ),
          ),
          (route) => false, // Remove all routes below the new page
        );
      } else {
        // If the passwords don't match, show a password error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Incorrect'),
              content: Text('The entered password is incorrect.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // If the document does not exist, show a document not found error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('User Not Found'),
            content: Text('The entered username does not exist.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }).catchError((error) {
    // Handle error if the Firestore query fails
    print("Failed to fetch document: $error");
  });
}
,

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 90, 15, 200)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                )),
            SizedBox(
              height: 30,
            ),

            SizedBox(
              height: 25,
            ),

            // ///////////////////
            // Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            //   const Text("Did Not Receive Code?"),
            //   TextButton(
            //     onPressed: () {
            //       // Navigate to signup page
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (context) => const LoginPage()),
            //         (route) => false, // Remove all routes below the new page
            //       );
            //     },
            //     child: const Text('TryAgain'),
            //   ),
            // ]),
            // SizedBox(
            //   height: 5,
            // ),

            ///////////////////
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Text("Forget password?"),
              TextButton(
                onPressed: () {
                  // Navigate to signup page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginVerification(nameController: widget.nameController)),
                    (route) => false, // Remove all routes below the new page
                  );
                },
                child: const Text('send otp'),
              ),
            ]),
          ]),
    );
  }
}

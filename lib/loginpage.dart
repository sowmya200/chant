import 'package:flutter/material.dart';
import 'package:chant/LoginVerification.dart';
import 'package:chant/signinpage.dart';
import 'package:chant/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String CountryCode = '+91';
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Login On Your Account                   ",
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
                    bottom: BorderSide(color: Color.fromARGB(255, 90, 50, 200)),
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
                    bottom:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
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
          const Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              //controller: mobileController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
                hintText: '+43 123-456-7890',
                prefixIcon: Icon(
                  IconData(0xe4a2, fontFamily: 'MaterialIcons'),
                  color: Colors.grey, // Adjust the color of the icon as needed
                ),
              ),
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
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 19)),
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '${CountryCode + mobileController.text}',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {},
                  codeAutoRetrievalTimeout: (String verificationId) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginVerification(
                                  MobileNumber:'$CountryCode${mobileController.text}', VerificationId: verificationId,
                                )));
                  },
                );
                Navigator.pushAndRemoveUntil(
                  context,

                  MaterialPageRoute(
                      builder: (context) => const LoginVerification()),
                  (route) => false, // Remove all routes below the new page
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 90, 50, 200)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              )),
          SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
              child: const Text('Sign Up'),
            ),
          ]),
        ],
      ),
    );
  }
}

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
  String DefaultCountryCode = '+91';
  //final TextEditingController mobileController = TextEditingController();

   final nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
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
         Padding(
            padding: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                //controller: mobileController,
                controller: nameController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username', // Change label to 'Username'
                  hintText: 'Enter your username', // Change hint text accordingly
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey, // Adjust the color of the icon as needed
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: 15), // Increase vertical padding
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
                // await FirebaseAuth.instance.verifyPhoneNumber(
                //   phoneNumber:
                //       '${DefaultCountryCode + mobileController.text}',
                //   verificationCompleted: (PhoneAuthCredential credential) {},
                //   verificationFailed: (FirebaseAuthException e) {},
                //   codeSent: (String verificationId, int? resendToken) {},
                //   codeAutoRetrievalTimeout: (String verificationId) {
                //     //Navigator.push(
                //     Navigator.pushAndRemoveUntil(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => LoginVerification(
                //                 mobileNumber:"+918220240433",
                //                   //  '$DefaultCountryCode${mobileController.text}',
                //                 verificationId: verificationId,
                //               )),
                //       (route) =>
                //           false, // Predicate that always returns false, removing all routes below the new page
                //     );
                //   },
                // );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginVerification(nameController: nameController,),
                  ),
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
                  MaterialPageRoute(builder: (context) => SignInPage()),
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

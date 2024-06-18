import 'package:chant/appbar.dart';
import 'package:chant/signinpage.dart';
import 'package:flutter/material.dart';
import 'package:chant/addaccountpage.dart';
import 'package:chant/email auth/emailOtp.dart';

class SignInVerification extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  
  int otp;
  //int receivedOtp;

  SignInVerification({
    required this.nameController,
    required this.phoneNumberController,
    required this.passwordController,
    required this.emailController,
    required this.otp,
  });

  @override
  _SignInVerificationState createState() => _SignInVerificationState();
}

class _SignInVerificationState extends State<SignInVerification> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  // Define any variables or methods needed for the login verification process
  void _checkInput(int otp, TextEditingController controller) {
  print(otp + _controller.hashCode);
    setState(() {
      if (otp == _controller) {
        _result = 'Verification successful';
        Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AddContactPage()),
                    (route) => false, // Remove all routes below the new page
                  );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('otp Incorrect'),
              content: Text('The entered OTP is incorrect.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>SignInPage()),
                    (route) => false, // Remove all routes below the new page
                  );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Signin For Account                          ",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 28,
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
                controller: _controller,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Verification',
                  hintText: 'Enter Verification Number',
                  prefixIcon: Icon(
                    IconData(0xe4a2, fontFamily: 'MaterialIcons'),
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
                onPressed: () {
                  
                  _checkInput(widget.otp,_controller);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AddContactPage()),
                  //   (route) => false, // Remove all routes below the new page
                  // );
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

            SizedBox(
              height: 25,
            ),

            ///////////////////
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Text("Did Not Receive Code?"),
              TextButton(
                onPressed: () {
                  // Navigate to signup page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                    (route) => false, // Remove all routes below the new page
                  );
                },
                child: const Text('TryAgain'),
              ),
            ]),
          ]),
    );
  }

}

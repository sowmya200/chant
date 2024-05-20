import 'package:chant/loginpage.dart';
import 'package:chant/logopage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chant/chatconnections/otp_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized before calling Firebase.initializeApp()
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget 
  //is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 43, 9, 102)),
        useMaterial3: true,
      ),
      //home: const LogoPage(),
      navigatorKey: navigatorKey,
      home:const LogoPage()
    );
  }
}

import 'package:chant/loginpage.dart';
import 'package:chant/logopage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chant/chatconnections/otp_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await FirebaseApi().initNotifications(); // Initialize Firebase Messaging

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

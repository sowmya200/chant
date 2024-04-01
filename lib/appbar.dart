import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:simple_shadow/simple_shadow.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(300); // Adjust the preferred height as needed

  @override
  Widget build(BuildContext context) {
    return Center(child:Scaffold(
          appBar:AppBar(
      toolbarHeight: 350, // default is 56
      toolbarOpacity: 0.15,
      backgroundColor: const Color.fromARGB(255,222,207,228),
     // shape: CustomOvalShapeBorder(curveRadius: 0.40),
// Change the background color as needed
      flexibleSpace: ClipPath(
            clipper: WaveClipperTwo(), // Use the WaveClipperTwo custom clipper
            child: Container(
              color:const Color.fromARGB(255,173, 135, 228),
            ),
          ),    
          
    
      title: SimpleShadow(
        color: const Color.fromARGB(255, 0, 0, 0),
        
        sigma: 5,
        offset: const Offset(0, 0),
        child: Image.asset(
          'assets/whitee_logo.png',
          fit: BoxFit.cover, // Replace this with the path to your image
          width:440.0, // Adjust the width as needed
          height:560.0, // Adjust the height as needed
      ))),
      // Add more customization here
    ),);
  }
}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_note/screen/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( textTheme: GoogleFonts.nunitoSansTextTheme( 
        Theme.of(context).textTheme, 
      )), 
      home:  HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

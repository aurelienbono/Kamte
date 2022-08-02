// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold( 
      body: 
      Container(child: Center( 
        child: Text(" Welcome Page"),
      ),
      decoration: BoxDecoration( 
        color: Colors.blue
      ),
     ));
  }
}

class IntroducePage extends StatelessWidget {
  const IntroducePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: 
      Container(child: Center( 
        child: Text(" Introduce Page"),
      ),
      decoration: BoxDecoration( 
        color: Colors.amber
      ),
     ));
  }
}

class GetStarter extends StatelessWidget {
  const GetStarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return Scaffold( 
      body: 
      Container(child: Center( 
        child: Text(" GetStarted Page "),
      ),
      decoration: BoxDecoration( 
        color: Colors.green
      ),
     ));
  }
}
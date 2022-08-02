// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:keep_note/screen/onboard.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  void initState(){ 
    super.initState();
    Timer(Duration(seconds: 4), ()=>  Navigator.push(context, MaterialPageRoute(builder: (context)=>OnboardingPage())));  

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body:  Container( 
      decoration: BoxDecoration( 
        color: Colors.white
      ),
       child: Center(     
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/icons/splash/icon.png",height: 130,width: 130,),
            Text("Kamte",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold , color: Color(0xff00c4d5)))
          ],
        ),
       ),
    )
    ); 
  }
}
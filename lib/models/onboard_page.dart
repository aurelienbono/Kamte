// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  String img ; 
  String title ; 
  String subtitle ; 
  OnBoarding({required this.img , required this.title , required this.subtitle}); 
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: 
       SafeArea(
        child: Column( 
          children: [ 
            Spacer(), 
            Image.asset(img,height: 200,width: 200,) ,
            Text(title,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w700),), 
            SizedBox(height: 16,),
            Text(subtitle, textAlign: TextAlign.center,), 
             Spacer(),  
          ],
        ),
      ) );
  }
}


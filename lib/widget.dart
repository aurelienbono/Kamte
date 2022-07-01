// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final title ; 
  final description; 
  const TaskCardWidget({this.title,this.description}) ; 



  @override
  Widget build(BuildContext context) {

    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical:22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title??("sans nom"), 
              style: TextStyle(
                fontSize: 22,
                color: Color(0xff211551),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10), 
              child: Text(description??("aucune description ajoutée")
                  ,style: TextStyle(fontSize: 16, color: Color(0xff86829d), 
                  height: 1.5),),
            )
          ],
        ));
  }
}

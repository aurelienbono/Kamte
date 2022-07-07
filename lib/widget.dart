// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final title;
  final description;
  const TaskCardWidget({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric( vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(bottom: 18),
        child: ListTile( title:   Text(
              title ?? ("sans nom"),
              style: TextStyle(
                fontSize: 22,
                color: Color(0xff211551),
                fontWeight: FontWeight.bold,
              ),
            ), 
            trailing:    Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                description ?? ("0"),
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff86829d),),
              ),
            ),
            )
        
        );
  }
}

class TodoWidget extends StatelessWidget {
  final String? text;
  final bool isDone;
  const TodoWidget({this.text, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
                color: isDone ? Color(0xff7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: isDone
                    ? null
                    : Border.all(color: Color(0xff82869d), width: 1.4)),
            child: Icon(
              CupertinoIcons.checkmark_alt,
              color: Colors.white,
              size: 18,
            ),
          ),
          Text(
            text ?? ("Tache sans nom"),
            style: TextStyle(
                color: isDone? Color(0xff211551):Color(0xff82869d),
                fontSize:16, 
                fontWeight: isDone? FontWeight.bold:FontWeight.w500),
          )
        ],
      ),
    );
  }
}


class NoGlowBehaviour extends ScrollBehavior{ 
  @override 
  Widget buildViewportchrome( 
    BuildContext context , Widget child , AxisDirection  axisDirection
  ) { 
    return child; 
  }
}
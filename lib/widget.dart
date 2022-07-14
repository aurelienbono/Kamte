// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_note/database_helper.dart';
DataBaseHelper _dbHelper = DataBaseHelper();


class TaskCardWidget extends StatelessWidget {
  final title;
  final total;
  const TaskCardWidget({this.title, this.total});

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
                "$total",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff86829d),),
              ),
            ),
            )
        
        );
  }
}

class TodoWidget extends StatefulWidget {
  final String? text;
  final int etat;
  const TodoWidget({this.text,required this.etat});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {

  Color? getColor(int number){ 
    if(number ==1){ 
      return Color(0xff82869d); 
    }
    if(number ==2){ 
      return Colors.red.shade300; 
    }
    if(number ==3){ 
      return Colors.green.shade300; 
    }
    else{ 
      return Color(0xff82869d); 

    }
  }

  
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
                color:  getColor(widget.etat), 
                borderRadius: BorderRadius.circular(5),
                border:Border.all(
                   color:    Color(0xff82869d  ),
                   width: 1.4)),       
              child: Icon(
                CupertinoIcons.multiply,
               color: 
               getColor(widget.etat), 
        
                size: 20,
              ),
            ),
      
          Flexible(
            child: Text(
              widget.text ?? ("Tache sans nom"),
              style: TextStyle(
                  color:  Color(0xff82869d),
                  fontSize:16, 
                  fontWeight:  FontWeight.bold),
            ),
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

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_note/widget.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
              children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24,bottom: 12),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Icon(
                            Icons.arrow_back_sharp,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            hintText: "  Entrez un titre ...",
                            border: InputBorder.none),
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff86829d)),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12), 
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: " Entrez une description pour ....",
                        border: InputBorder.none , 
                        contentPadding: EdgeInsets.symmetric( 
                          horizontal: 20
                        )),
                        onSubmitted: (value){ 
                          print("validation value");
                        },
                      
                  ),
                ),
          TodoWidget(isDone: false),
          TodoWidget(isDone: true)
          ],
        ),
             Positioned(
              bottom:20, 
              right: 24 , 
                child: GestureDetector(
                  onTap: (){ 
                  Navigator.push(context, MaterialPageRoute(builder: (contex)=>TaskPage())); 
                  },
                  child: Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration( color: Color.fromARGB(255, 176, 36, 80),borderRadius: BorderRadius.circular(20)),
                              child: Center(child: Icon(CupertinoIcons.delete_simple, color: Colors.white,))),
                            ),
                )
              ],
            )),
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_note/screen/taskpage.dart';
import 'package:keep_note/widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        color: Color(0xfff6f6f6),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset('assets/images/image1.png'),
                  margin: EdgeInsets.only(bottom: 32),
                ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoGlowBehaviour( ),
                  child: ListView( 
                    children: [   TaskCardWidget(
                      title: "aurelien",
                      description:
                          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it",
                    ),
                    TaskCardWidget(
                      title: "GICAM",
                      description:
                          " distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it",
                    ),
                    TaskCardWidget(), 
                     TaskCardWidget(), 
                      TaskCardWidget(), 
                       TaskCardWidget(), 
                    ],),
                ),
              )
              ],
            ),
            Positioned(
              bottom:20, 
              right: 0 , 
                child: GestureDetector(
                  onTap: (){ 
                  Navigator.push(context, MaterialPageRoute(builder: (contex)=>TaskPage())); 
                  },
                  child: Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration( color: Color(0xff3F4E4F),borderRadius: BorderRadius.circular(20)),
                              child: Center(child: Icon(CupertinoIcons.add, color: Colors.white,))),
                            ),
                )
          ],
        ),
      ),
    ));
  }
}

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                TaskCardWidget(
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
              ],
            ),
            Positioned(
              bottom:0, 
              right: 0 , 
                child: Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration( color: Color(0xff3F4E4F),borderRadius: BorderRadius.circular(20)),
              child: Center(child: IconButton(onPressed: () {}, icon: Icon(Icons.add,size: 35, color: Colors.white,))),
            ))
          ],
        ),
      ),
    ));
  }
}

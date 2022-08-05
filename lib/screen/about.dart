// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            )),
        title: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Text(
            "A PROPOS",
            style: TextStyle(
                color: Colors.black54, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff00c4d5),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 10),
              child: Center(
                child: Image.asset("assets/images/about_icon.png" ,height: 180,width: 180,)
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Kamte V0.1.0",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Kamte est une idée original de Marius NGADOM ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      "(me@ngatcharius.com)\n +237 699-120192",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      " Dévelopé par Bono Mbelle Aurelien ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "(bonombelleaurelien@outlook.com)\n            +237 697-783493",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

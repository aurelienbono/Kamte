// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_note/database_helper.dart';
import 'package:keep_note/models/task.dart';
import 'package:keep_note/screen/taskpage.dart';
import 'package:keep_note/widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataBaseHelper _dbHelper = DataBaseHelper();
  Task _task = Task();

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
                    child: FutureBuilder(
                        initialData: [],
                        future: _dbHelper.getTask(),
                        builder: (context, AsyncSnapshot snapshot) {
                          return ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contex) => TaskPage(
                                                  task: snapshot.data[index],
                                                ))).then((value) { setState(() {
                                                  
                                                });});
                                  },
                                  child: TaskCardWidget(
                                    title: snapshot.data[index].title,
                                    // ici  je vais mettre la fonction pour afficher le prix total de chaque task 
                                    // totalSomme: snapshot.data[index].totalSomme,
                                  ),
                                );
                              },
                            ),
                          );
                        }))
              ],
            ),
                    Positioned(
              bottom: 20,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => TaskPage(task: null ))).then((value) { setState(() {
                        
                      });});
                },
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xff3F4E4F),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Icon(
                      CupertinoIcons.add,
                      color: Colors.white,
                    ))),
              ),
            )
          ],
        ),
      ),
    ));
  }


}

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_note/database_helper.dart';
import 'package:keep_note/models/task.dart';
import 'package:keep_note/widget.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  TaskPage({required this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String? _taskTitle = '';

  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task?.title;
    }
    super.initState();
  }

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
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
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
                        onSubmitted: (value) async {
                          print("La valeur du champs est : $value");

                          if (value != '') {
                            if (widget.task == null) {
                              DataBaseHelper _dbHelper = DataBaseHelper();

                              Task _newTask = Task(title: value);

                              await _dbHelper.insertTask(_newTask);

                              print(
                                  "Un nouveau task a eté crée : ${_newTask.title}");
                            } else {
                              print('mise a jour de l existant');
                            }
                          }
                        },
                        controller: TextEditingController()..text = _taskTitle!,
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
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                    onSubmitted: (value) {
                      print("validation value");
                    },
                  ),
                ),
                // TodoWidget(isDone: false),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric( 
                        horizontal: 24
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color(0xff82869d), width: 1.4)),
                                  child: Icon(
                                    CupertinoIcons.checkmark_alt,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: TextField( 
                                onSubmitted: (val){ 
                                  
                                },
                            decoration: InputDecoration(
                                hintText: " Entrez un nouveau objectif",
                                border: InputBorder.none),
                          ))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              bottom: 20,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (contex)=>TaskPage())) ;
                },
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 176, 36, 80),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Icon(
                      CupertinoIcons.delete_simple,
                      color: Colors.white,
                    ))),
              ),
            )
          ],
        )),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_note/database_helper.dart';
import 'package:keep_note/models/task.dart';
import 'package:keep_note/models/todo.dart';
import 'package:keep_note/widget.dart';
import 'dart:math'; 

class TaskPage extends StatefulWidget {
  final Task? task;
  TaskPage({required this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String? _taskTitle = '';
  int? _taskId = 0 ; 



  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task?.title;
      _taskId = widget.task?.id; 
    }


    super.initState();
  }


  bool _contentVisile = false; 
  int _totalSum = 0 ; 


  DataBaseHelper _dbHelper = DataBaseHelper();


  

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
                              Task _newTask = Task(title: value);

                              await _dbHelper.insertTask(_newTask);
                        //       var 
                        // await _dbHelper.updateTaskPriceTotal(_taskId!, _totalSum);
                        
                              print(
                                  "Un nouveau task a eté crée : ${_newTask.title}");
                            } else {
                            await  _dbHelper.updateTaskTitle(_taskId!, value); 
                            print("TASK UPDATE"); 
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
                  // child: Center( 
                  //   child: Text("${_newTask.title}"),
                  // ),
                  child: TextField(
                   
                    
                    decoration: InputDecoration(
                        hintText: " Entrez une description pour ....",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                    onSubmitted: (value) {
                    },
                  ),
                ),
                // TodoWidget(isDone: false),
                FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodo(_taskId!),
                    builder: (context, AsyncSnapshot snapshot) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async{ 

                         await  _dbHelper.deleteTodo(snapshot.data[index].id);  
                         await  _dbHelper.updateTaskRetrait(_taskId!,snapshot.data[index].price);  

                         print(snapshot.data[index].price);
                         setState(() {
                           
                         });
   
                                },
                                child: TodoWidget(
                                  // price: snapshot.data[index].price! == 0
                                     
                                  text: snapshot.data[index].title,
                                ),
                              );
                            }),
                      );
                    }),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                                          color: Color(0xff82869d),
                                          width: 1.4)),
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
                                controller: TextEditingController()..text = '',
                            onSubmitted: (val) async {
                              print("La valeur du champs est : $val;");
                              var res = recoverPrice(val); 
                              print("la valeur recolter ici est : $res "); 


                              if (val != '') {
                                if (widget.task != null) {
                                  DataBaseHelper _dbHelper = DataBaseHelper();

                                  Todo _newTodo = Todo(
                                      title: val,
                                      price: res,
                                      taskId: widget.task!.id);
                                 
                                    // await _dbHelper.updateTaskPriceTotal(_taskId!, _totalSum);
                                      await _dbHelper.updateTaskPriceTotal(_taskId!, res);                           
                                  await _dbHelper.insertTodo(_newTodo);
                                  setState(() { });

                                  // print(
                                  //     "Un nouveau todo a eté crée : ${_newTodo.title}");
                                }
                              }
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
                     onTap: () async{ 

                      if(_taskId !=0){ 
                          await  _dbHelper.deleteTask(_taskId!);  
                          print("task supprimé"); 
                          Navigator.of(context).pop(); 
                          
                      }   },
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff0078AA),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Icon(
                        CupertinoIcons.share,
                        color: Colors.white,
                      ))),
                ),
       
            )
          ],
        )),
      ),
    );
  }


  int recoverPrice(String chaine){ 
      // String text = "Hello , world 2000 "; 

      // String deux = " 1 voiture 2000 4000 100" ; 

    final intInStr = RegExp(r'\d+');
    var recherche = intInStr.allMatches(chaine).map((m) => m.group(0)); 
    var theTrans = recherche.toList(); 
    List<int> new_arary =[]; 


    for (var number  in theTrans) {
    var lestNumber = int.parse(number!); 
      new_arary.add(lestNumber);  
    }
    // print(new_arary.runtimeType);
    // print(new_arary);

    //   print(new_arary.reduce(max)); 
    //   print(new_arary.reduce(min));
   int monRes = new_arary.reduce(max); 
    return monRes; 
  
}

  }



/******** le show modal pour ajouter un portefeuille actuellement  */
// void showMadal() {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(25.0),
//           ),
//         ), 
//         backgroundColor: Color(0xfff6f6f6),
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//               child:  Expanded(
//                           child: TextField(
//                             focusNode: _titleFocus,
//                         onSubmitted: (value) async {
//                           print("La valeur du champs est : $value");

//                           if (value != '') {
//                             if (widget.task == null) {
//                               Task _newTask = Task(title: value);

//                               await _dbHelper.insertTask(_newTask);

//                               print(
//                                   "Un nouveau task a eté crée : ${_newTask.title}");
//                             } else {
//                               print('mise a jour de l existant');
//                             }
//                           } 
//                         },
//                         controller: TextEditingController()..text = _taskTitle!,
//                         decoration: InputDecoration(
//                             hintText: "  Entrez un titre ...",
//                             border: InputBorder.none),
//                         style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff86829d)),
//                       )));
//         });
//   }



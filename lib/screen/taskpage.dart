// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:keep_note/database_helper.dart';
import 'package:keep_note/models/task.dart';
import 'package:keep_note/models/todo.dart';
import 'package:keep_note/widget.dart';
import 'dart:math';

import 'package:share_plus/share_plus.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  TaskPage({required this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String? _taskTitle = '';
  int? _taskId = 0;

  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task?.title;
      _taskId = widget.task?.id;
    }

    super.initState();
  }

  bool _contentVisile = false;
  int _totalSum = 0;
  int _permet = 0 ; 

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
                          if (value != '') {
                            if (widget.task == null) {
                              Task _newTask = Task(title: value, total: 0,status: 0);
                              await _dbHelper.insertTask(_newTask);
                         
                                  if(_newTask.status ==0){ 
                                  }
                                  else { 
                                  }
                            } else {
                              await _dbHelper.updateTaskTitle(_taskId!, value);
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
                
                ),
                FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodo(_taskId!),
                    builder: (context, AsyncSnapshot snapshot) {
                      return Expanded(
                        child:   snapshot.data.length ==0 ?  Image.asset("assets/images/image3.png") : 
                        
                        ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                
                                },
                                child: Slidable(
                                  startActionPane:  ActionPane(motion: DrawerMotion(), 
                                                                     dragDismissible: false,

                                    children: [ 
                                       SlidableAction(
                          autoClose: true,
                          flex: 1,
                          onPressed: (value) async{
                      int _etat =  await _dbHelper.getEtatTodo(snapshot.data[index].id); 
                       if(_etat==0){ 
                             _permet = 2;
                                   int _res =  await _dbHelper.getTemp(snapshot.data[index].id); 
                                    await _dbHelper.updateTaskPriceTotal(
                                      _taskId!, _res);
                                            await _dbHelper.updateTodoPrice( snapshot.data[index].id, _res);     
                            await _dbHelper.updateTodoEtat(snapshot.data[index].id,_permet).then((value) { 
                              setState(() {
                                
                              });
                            }); 
                    }
                      else { 
                            int _etat =  await _dbHelper.getEtatTodo(snapshot.data[index].id); 


                              if(_etat==2){ 
                                print("on ne fais rien "); 
                              }
                              else { 
                                print("Vous venez de changer d'etat :${_etat} "); 
                                  // _permet = 2;
                                  // int _res =  await _dbHelper.getTemp(snapshot.data[index].id); 
                                  //   await _dbHelper.updateTodoPrice(
                                  //     _taskId!, _res); 
                                  //     await _dbHelper.updateTodoEtat(snapshot.data[index].id,_permet).then((value) { 
                                  //       setState(() {
                                          
                                  //       });
                                  //     }); 
                              }
                              
                              
                            }
                          },
                          backgroundColor: Colors.green.shade200,
                          foregroundColor: Colors.white,
                          // icon: Icons.delete,
                          label: 'Credit',
                        ),
                                    ],
                                  ), 
                                  endActionPane: 
                                   ActionPane(motion: DrawerMotion(), 
                                   dragDismissible: false,
                                    children: [ 
                           SlidableAction(
                          autoClose: true,
                          flex: 1,
                          onPressed: (value) async{
                            int _etat =  await _dbHelper.getEtatTodo(snapshot.data[index].id); 
                            if(_etat==0){ 
                                _permet = 1;
                                  int _res =  await _dbHelper.getTemp(snapshot.data[index].id); 
                                    await _dbHelper.updateTaskRetrait(
                                      _taskId!,snapshot.data[index].id , _res); 
                                      await _dbHelper.updateTodoEtat(snapshot.data[index].id,_permet).then((value) { 
                                        setState(() {
                                          
                                        });
                                      }); 
                            }
                            else { 
                          int _etat =  await _dbHelper.getEtatTodo(snapshot.data[index].id); 

                              if(_etat==1){ 
                                print("on ne fais rien "); 
                              }
                              else { 
                                print("Vous venez de changer d'etat :${_etat} "); 
                                  _permet = 2;
                                  int _res =  await _dbHelper.getPrice(snapshot.data[index].id); 
                                  print(_res) ; 
                                  //   await _dbHelper.updateTodoPrice(
                                  //     _taskId!, _res); 
                                  //     await _dbHelper.updateTodoEtat(snapshot.data[index].id,_permet).then((value) { 
                                  //       setState(() {
                                          
                                  //       });
                                  //     }); 
                              }
                              
                              
                            }
                             
                     
                          },
                          backgroundColor: Colors.red.shade200,
                          foregroundColor: Colors.white,
                          // icon: Icons.delete,
                          label: 'Debit',
                        ),
                                    ],
                                  ),
                                  child: TodoWidget(
                                    text: snapshot.data[index].title,
                                    id: snapshot.data[index].id,
                                    etat: snapshot.data[index].etat ,
                                  ),
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
                                      color: Color(0xff82869d),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color(0xff82869d),
                                          width: 1.4)),
                                  child: Icon(
                                    CupertinoIcons.checkmark_alt,
                                    color: Colors.transparent,
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
                              var res = recoverPrice(val);

                              if (val != '') {
                                if (widget.task != null) {
                                  DataBaseHelper _dbHelper = DataBaseHelper();

                                 if(res!=0){ 
                                   Todo _newTodo = Todo(
                                      title: val,
                                      price: 0,
                                      taskId: widget.task!.id ,  
                                      etat: 0, 
                                      temp: res, 
                                      );

                                  await _dbHelper.updateTaskPriceTotal(
                                      _taskId!, 0);
                                 await _dbHelper.insertTodo(_newTodo);
                                  setState(() {});
                                 }
                                 else { 
                                  Todo _newTodo = Todo(
                                      title: val,
                                      price: 0,
                                      taskId: widget.task!.id ,  
                                      etat: 0, 
                                      temp: 0, 
                                      );

                                  await _dbHelper.updateTaskPriceTotal(
                                      _taskId!, 0);
                                 await _dbHelper.insertTodo(_newTodo);
                                  setState(() {});
                                 }

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
                onTap: () async {
                  int index ; 
               print(await _dbHelper.getTodoShare(_taskId!)); 

               List valueShare =    
               await _dbHelper.getTodoShare(_taskId!);         
                print(valueShare.runtimeType); 
              var _message = getMsgShare(_taskId! ,valueShare); 
               print(_message); 
                    await Share.share(_message); 

                },
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

  String getMsgShare(int id,  List _list){ 
    //  _dbHelper.getTodoShare(id);
      // List _name = ['Aurelien', 'clovis','amour', 'vie']; 
        var _value =''; 
      for( var i in _list){ 

       _value =_value + ' \n' +"[ ] "+ i; 

  }

       String message = "\t MyMix01 \n\n\n  ---------------------------------------------- \n PorteFeuille NameUser-$id \n Du 20/03/2022 08:56 \n Client : 69x xxx xxx \n ---------------------------------------------- \n  $_value \n ----------------------------------------------\n Total HT 300 \n ----------------------------------------------";
       return message;  
       
  }

  int recoverPrice(String chaine) {
    final intInStr = RegExp(r'\d+');
    var recherche = intInStr.allMatches(chaine).map((m) => m.group(0));
    var theTrans = recherche.toList();
     int monRes ; 
    
  
  if(theTrans.isNotEmpty) { 
  List<int> new_arary = [];
    for (var number in theTrans) {
      var lestNumber = int.parse(number!);
      new_arary.add(lestNumber);
    }

    monRes = new_arary.reduce(max);
  

  }
  else { 
   monRes = 0; 
  }
 
  return monRes;

  }
}

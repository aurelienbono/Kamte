// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unused_element

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
  int _credit = 0;
  int _debit = 0;

  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task?.title;
      _taskId = widget.task?.id;
    }

    super.initState();
  }

  int _permet = 0;
  DataBaseHelper _dbHelper = DataBaseHelper();

  void getcredit(int _price) {
    _credit = 0;
    setState(() {
      _credit = _price;
    });
  }

  void getdebit(int _price) {
    _debit = 0;
    setState(() {
      _debit = _price;
    });
  }

  TextEditingController nameController = TextEditingController();

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
                Container(
                  color: Color(0xff00c4d5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Text(_taskTitle!,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 23,
                                fontWeight: FontWeight.bold)),
                      ),
                      GestureDetector(
                          onTap: () {
                           
showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 450,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      "Modifier le titre de  votre portefeuille".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      controller:nameController ,
                                      decoration: InputDecoration(
                                          hintText:
                                              _taskTitle,
                                          icon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.shopping_basket,
                                              size: 29,
                                              color: Color(0xff00c4d5),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                        if (nameController.text != '') {
                                         await _dbHelper.updateTaskTitle(_taskId!, nameController.text).then((value) { setState(() {
                                           
                                         }); }); 
                                          nameController.clear();

                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                        }
                                        nameController.clear();
                                      }, 
                                    child: Container(
                                        width: 200,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff00c4d5),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Center(
                                            child: Text(
                                          "Modifier".toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ))),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(
                                        " Créez un portefeuille (Ex: Marche Noel) ici vous permettra d'y mettre toutes vos depenses  en :  Debit(Gain ) , Credit(Perte), prevision (Surement une promesse d'argent ) , "),
                                  ),
                                ],
                              ),
                            );
                     
                          });

                           
                          },
                          child: Icon(Icons.edit))
                    ],
                  ),
                ),
                TopCard(
                  id: _taskId,
                  title: _taskTitle!,
                  debit: _debit,
                  credit: _credit,
                  total: widget.task!.total!,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                ),
                FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodo(_taskId!),
                    builder: (context, AsyncSnapshot snapshot) {
                      return Expanded(
                        child: snapshot.data.length == 0
                            ? Image.asset("assets/images/image3.png")
                            : ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {},
                                    child: Slidable(
                                      startActionPane: ActionPane(
                                        motion: DrawerMotion(),
                                        dragDismissible: false,
                                        children: [
                                          SlidableAction(
                                              onPressed: (val) async {
                                                int _tempEtat = await _dbHelper
                                                    .getEtatTodo(snapshot
                                                        .data[index].id);
                                                if (_tempEtat == 1) {
                                                  int nbr = snapshot
                                                      .data[index].price;

                                                  nbr = nbr * (-1);
                                                  await _dbHelper.deleteTodo(
                                                      _taskId!,
                                                      snapshot.data[index].id,
                                                      nbr);
                                                }
                                                // sinon
                                                await _dbHelper.deleteTodo(
                                                    _taskId!,
                                                    snapshot.data[index].id,
                                                    snapshot.data[index].price);
                                                setState(() {});

                                                getdebit(await _dbHelper
                                                    .debitTotal(_taskId!));
                                                getcredit(await _dbHelper
                                                    .creditTotal(_taskId!));
                                              },
                                              icon: Icons.delete,
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white)
                                        ],
                                      ),
                                      endActionPane: ActionPane(
                                        motion: DrawerMotion(),
                                        dragDismissible: false,
                                        children: [
                                          SlidableAction(
                                            autoClose: true,
                                            flex: 1,
                                            onPressed: (value) async {
                                              int _etat =
                                                  await _dbHelper.getEtatTodo(
                                                      snapshot.data[index].id);

                                              if (_etat == 0) {
                                                _permet = 1;
                                                int _res = await _dbHelper
                                                    .getTemp(snapshot
                                                        .data[index].id);
                                                await _dbHelper
                                                    .updateTaskRetrait(
                                                        _taskId!,
                                                        snapshot.data[index].id,
                                                        _res);

                                                await _dbHelper
                                                    .updateTodoEtat(
                                                        snapshot.data[index].id,
                                                        _permet)
                                                    .then((value) {
                                                  setState(() {});
                                                });
                                                getcredit(await _dbHelper
                                                    .creditTotal(_taskId!));
                                              } else {
                                                int _etat = await _dbHelper
                                                    .getEtatTodo(snapshot
                                                        .data[index].id);

                                                if (_etat == 1) {
                                                  // aucune action
                                                } else {
                                                  int etat_todo = 1;
                                                  int _res = await _dbHelper
                                                      .getPrice(snapshot
                                                          .data[index].id);
                                                  await _dbHelper
                                                      .getFinalTotalDebit(
                                                          _taskId!, _res);
                                                  await _dbHelper
                                                      .updateTodoEtat(
                                                          snapshot
                                                              .data[index].id,
                                                          etat_todo)
                                                      .then((value) {
                                                    setState(() {});
                                                  });

                                                  getdebit(await _dbHelper
                                                      .debitTotal(_taskId!));
                                                  getcredit(await _dbHelper
                                                      .creditTotal(_taskId!));
                                                }
                                              }
                                            },
                                            backgroundColor:
                                                Colors.red.shade200,
                                            foregroundColor: Colors.white,
                                            icon: CupertinoIcons
                                                .cart_fill_badge_minus,
                                          ),
                                          SlidableAction(
                                            autoClose: true,
                                            flex: 1,
                                            onPressed: (value) async {
                                              int _etat =
                                                  await _dbHelper.getEtatTodo(
                                                      snapshot.data[index].id);
                                              if (_etat == 0) {
                                                _permet = 2;
                                                int _res = await _dbHelper
                                                    .getTemp(snapshot
                                                        .data[index].id);
                                                await _dbHelper
                                                    .updateTaskCredit(
                                                        _taskId!,
                                                        snapshot.data[index].id,
                                                        _res);
                                                await _dbHelper
                                                    .updateTodoEtat(
                                                        snapshot.data[index].id,
                                                        _permet)
                                                    .then((value) {
                                                  setState(() {});
                                                });

                                                getdebit(await _dbHelper
                                                    .debitTotal(_taskId!));
                                              } else {
                                                int _etat = await _dbHelper
                                                    .getEtatTodo(snapshot
                                                        .data[index].id);

                                                if (_etat == 2) {
                                                  // aucune action
                                                } else {
                                                  int etat_todo1 = 2;
                                                  int _res = await _dbHelper
                                                      .getPrice(snapshot
                                                          .data[index].id);
                                                  await _dbHelper
                                                      .getFinalTotalCredit(
                                                          _taskId!, _res);
                                                  await _dbHelper
                                                      .updateTodoEtat(
                                                          snapshot
                                                              .data[index].id,
                                                          etat_todo1)
                                                      .then((value) {
                                                    setState(() {});
                                                  });

                                                  getcredit(await _dbHelper
                                                      .creditTotal(_taskId!));
                                                  getdebit(await _dbHelper
                                                      .debitTotal(_taskId!));
                                                }
                                              }
                                            },
                                            backgroundColor:
                                                Colors.green.shade200,
                                            foregroundColor: Colors.white,
                                            icon:
                                                CupertinoIcons.cart_badge_plus,
                                          ),
                                        ],
                                      ),
                                      child: TodoWidget(
                                        text: snapshot.data[index].title,
                                        id: snapshot.data[index].id,
                                        etat: snapshot.data[index].etat,
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
                                      borderRadius: BorderRadius.circular(7),
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

                                  if (res != 0) {
                                    Todo _newTodo = Todo(
                                      title: val,
                                      price: 0,
                                      taskId: widget.task!.id,
                                      etat: 0,
                                      temp: res,
                                    );
                                    await _dbHelper.updateTaskPriceTotal(
                                        _taskId!, 0);
                                    await _dbHelper.insertTodo(_newTodo);
                                    setState(() {});
                                  } else {
                                    Todo _newTodo = Todo(
                                      title: val,
                                      price: 0,
                                      taskId: widget.task!.id,
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
                                hintText: " Entrez une nouvelle  depense",
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
                  int index;
                  List valueShare = await _dbHelper.getTodoShare(_taskId!);
                  var _message = getMsgShare(_taskTitle!, valueShare);
                  await Share.share(_message);
                },
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xff00c4d5),
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

  String getMsgShare(String title, List _list) {
    var _value = '';
    String arraySel = '';
    for (var i in _list) {
      arraySel = i;
      i = i.toString().replaceAll("(", '').replaceAll(")", "");
      List _tempList = [];
      int _tempValue;
      _tempList = i.split(',');
      i = _tempList[0];
      _tempValue = int.parse(_tempList[1]);
      if (_tempValue == 0) {
        _value = _value +
            ' \n' +
            "[ ] " +
            i.toString().replaceAll("(", '').replaceAll(")", "");
      }
      if (_tempValue == 1) {
        _value = _value +
            ' \n' +
            "[-] " +
            i.toString().replaceAll("(", '').replaceAll(")", "");
      }
      if (_tempValue == 2) {
        _value = _value +
            ' \n' +
            "[+] " +
            i.toString().replaceAll("(", '').replaceAll(")", "");
      }
    }
    String message =
        "\t KAMTE :  $title   \n ----------------------------------------------  $_value \n ----------------------------------------------";
    return message;
  }

  int recoverPrice(String chaine) {
    final intInStr = RegExp(r'\d+');
    var recherche = intInStr.allMatches(chaine).map((m) => m.group(0));
    var theTrans = recherche.toList();
    int monRes;

    if (theTrans.isNotEmpty) {
      List<int> new_arary = [];
      for (var number in theTrans) {
        var lestNumber = int.parse(number!);
        new_arary.add(lestNumber);
      }

      monRes = new_arary.reduce(max);
    } else {
      monRes = 0;
    }

    return monRes;
  }
}

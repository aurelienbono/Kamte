// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:keep_note/database_helper.dart';
import 'package:keep_note/models/task.dart';
import 'package:keep_note/screen/archive_task.dart';
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
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
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
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return ArchivePage();
                                })));
                              },
                              child: Image.asset('assets/images/image1.png')),
                        ],
                      ),
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
                                                      task:
                                                          snapshot.data[index],
                                                    ))).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Slidable(
                                        endActionPane: ActionPane(
                                          motion: DrawerMotion(),
                                          children: [
                                            SlidableAction(
                                              autoClose: true,
                                              onPressed: (value) async {
                                                int res = await _dbHelper
                                                    .getCount(snapshot
                                                        .data[index].id);
                                                if (res == 0) {
                                                  if (snapshot.data[index].id !=
                                                      0) {
                                                    //  il va permettre de partager les tasks
                                                    await _dbHelper
                                                        .deleteTask(snapshot
                                                            .data[index].id!)
                                                        .then((value) {
                                                      setState(() {});
                                                    });

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                            " Votre portefeuille ${snapshot.data[index].title} est supprimé"),
                                                      ],
                                                    )));
                                                  }
                                                } else {
                                                  _alert(snapshot.data[index].title,res);
                                                  print(
                                                      "Impossible de supprimer");
                                                }
                                              },
                                              backgroundColor: Colors.red,
                                              icon: CupertinoIcons.delete,
                                            )
                                          ],
                                        ),
                                        startActionPane: ActionPane(
                                          motion: DrawerMotion(),
                                          children: [
                                            SlidableAction(
                                              flex: 1,
                                              autoClose: true,
                                              onPressed: (value) async {
                                                int _permet = 1;

                                                await _dbHelper
                                                    .updateTastStatus(
                                                        snapshot.data[index].id,
                                                        _permet)
                                                    .then((value) {
                                                  setState(() {});
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                        " Votre porte feuille viens d'etre archivé "),
                                                    TextButton(
                                                        onPressed: () {
                                                          print(
                                                              "Annulation d'archivage de ton porte feuille");
                                                        },
                                                        child: Text("Annuler"))
                                                  ],
                                                )));
                                              },
                                              backgroundColor: Colors.blue,
                                              icon: CupertinoIcons
                                                  .archivebox_fill,
                                            )
                                          ],
                                        ),
                                        child: TaskCardWidget(
                                          title: snapshot.data[index].title,
                                          // ici  je vais mettre la fonction pour afficher le prix total de chaque task
                                          total: snapshot.data[index].total,
                                        ),
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
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => TaskPage(task: null)))
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xff0078AA),
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

  void _alert(String title , int nbr) {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.dangerous,color: Colors.red,) , 
                  Text("Impossible de Supprimer".toUpperCase(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                ],
              ),
              content: Column(
                children: [
                  Text(" Impossible de Supprimer le portefeuille "),
               Text(" $title ".toUpperCase(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
               Text("car il contient $nbr elements ")

                ],
              ),
              actions: [ 
                TextButton(onPressed: (){ 
                  Navigator.pop(context); 
                }, child: Text("OK"))
              ],
            ));
  }
}

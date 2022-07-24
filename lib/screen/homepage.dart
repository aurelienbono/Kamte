// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously

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
  String? _taskTitle = '';
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Color(0xff0078AA),
          title: Text("PorteFeuille personnel".toUpperCase()),
          centerTitle: true,
          leading: Builder(
            builder: (context) => GestureDetector(
              child: Icon(Icons.short_text),
              onTap: () {
                return Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: [
            GestureDetector(
              child: Icon(Icons.person_outline),
              onTap: () async {
              },
            ),
          ],
          elevation: 0,
        ),
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
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Expanded(
                        child: FutureBuilder(
                            initialData: [],
                            future: _dbHelper.getTask(),
                            builder: (context, AsyncSnapshot snapshot) {
                              return ScrollConfiguration(
                                behavior: NoGlowBehaviour(),
                                child:  snapshot.data.length ==0 ?    Image.asset("assets/images/image2.png") :                                
                                ListView.builder(
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
                                                        Flexible(
                                                          child: Text(
                                                              " Votre portefeuille ${snapshot.data[index].title} est supprimé"),
                                                        ),
                                                      ],
                                                    )));
                                                  }
                                                } else {
                                                  _alert(
                                                      snapshot
                                                          .data[index].title,
                                                      res);
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
                                                    Flexible(
                                                      child: Text(
                                                          " Votre porte feuille viens d'etre archivé "),
                                                    ),
                                                    TextButton(
                                                        onPressed: () async {
                                                          int _temp = 0;
                                                          await _dbHelper
                                                              .updateTastStatus(
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .id,
                                                                  _temp)
                                                              .then((value) {
                                                            setState(() {});
                                                          });
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
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title:
                                    Text("Creer Un PorteFeuille".toUpperCase()),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      CupertinoTextField(
                                        placeholder: "Ex:Marche Noel",
                                        controller: nameController,
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Annuler".toUpperCase(),
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  CupertinoButton(
                                      child: Text("Valider".toUpperCase()),
                                      onPressed: () async {
                                        if (nameController.text != '') {
                                          Task _newTask = Task(
                                              title: nameController.text,
                                              total: 0,
                                              status: 0);
                                          await _dbHelper
                                              .insertTask(_newTask)
                                              .then((value) {
                                            setState(() {});
                                          });
                                          nameController.clear();

                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                        }
                                        nameController.clear();
                                      })
                                ],
                              ));
                    },
                    child: Container(
                        width: 55,
                        height: 55,
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

  void _alert(String title, int nbr) {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.dangerous,color: Colors.red,) ,
                  Text(
                    "Impossible de Supprimer".toUpperCase(),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              content: Column(
                children: [
                  Text(" Impossible de Supprimer le portefeuille "),
                  Text(
                    " $title ".toUpperCase(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Text("car il contient $nbr elements ")
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ));
  }

// /******** le show modal pour ajouter un portefeuille actuellement  */
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



}

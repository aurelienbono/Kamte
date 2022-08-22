// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:keep_note/database_helper.dart';
import 'package:keep_note/models/task.dart';
import 'package:keep_note/screen/about.dart';
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
  GlobalKey<NavigatorState> _mykey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text("John Doe "),
                  decoration: BoxDecoration(
                    color: Color(0xff00c4d5),
                  ),
                  accountEmail: Text("johndoe@example.com"),
                  currentAccountPicture: CircleAvatar(
                      child: Icon(
                    Icons.person,
                    size: 50,
                  ))),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArchivePage()));
                },
                child: ListTile(
                  title: Text(
                    "Archives",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.archive,
                    size: 22,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
                child: ListTile(
                  title: Text(
                    "A propos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.help_center, size: 22),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff00c4d5),
          title: Text("Kamte".toUpperCase()),
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
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(CupertinoIcons.search),
              ),
              onTap: () async {},
            ),
          ],
          elevation: 0,
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (_mykey.currentState!.canPop()) {
              _mykey.currentState!.pop();
              return false;
            }
            return true;
          },
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
                                child: snapshot.data.length == 0
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/image2.png",
                                              width: 300,
                                              height: 300,
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Text(
                                              "Appuyer sur + pour créer un portefeuille",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (contex) =>
                                                          TaskPage(
                                                            task: snapshot
                                                                .data[index],
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
                                                        if (snapshot.data[index]
                                                                .id !=
                                                            0) {
                                                          //  il va permettre de partager les tasks
                                                          await _dbHelper
                                                              .deleteTask(
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .id!)
                                                              .then((value) {
                                                            setState(() {});
                                                          });

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      content:
                                                                          Row(
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
                                                            snapshot.data[index]
                                                                .title,
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
                                                              snapshot
                                                                  .data[index]
                                                                  .id,
                                                              _permet)
                                                          .then((value) {
                                                        setState(() {});
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                                " Portefeuille archivé "),
                                                          ),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                int _temp = 0;
                                                                await _dbHelper
                                                                    .updateTastStatus(
                                                                        snapshot
                                                                            .data[
                                                                                index]
                                                                            .id,
                                                                        _temp)
                                                                    .then(
                                                                        (value) {
                                                                  setState(
                                                                      () {});
                                                                });
                                                              },
                                                              child: Text(
                                                                  "Annuler"))
                                                        ],
                                                      )));
                                                    },
                                                    backgroundColor:
                                                        Colors.blue,
                                                    icon: CupertinoIcons
                                                        .archivebox_fill,
                                                  )
                                                ],
                                              ),
                                              child: TaskCardWidget(
                                                title:
                                                    snapshot.data[index].title,
                                                // ici  je vais mettre la fonction pour afficher le prix total de chaque task
                                                total:
                                                    snapshot.data[index].total,
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
                                      "Créez votre portefeuille".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18,
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
                                              " Ex: Marche Noel".toUpperCase(),
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
                                          "Valider".toUpperCase(),
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
                                        " Créer un portefeuille (Ex: Christmas Walk) ici vous permettra de mettre toutes vos dépenses dans: Débit(Gain), Crédit(Perte), Prévision (sûrement une promesse d'argent.) "),
                                  ),
                                ],
                              ),
                            );
                     
                          });
                      // showCupertinoDialog(
                      //     context: context,
                      //     builder: (context) => CupertinoAlertDialog(
                      //           title:
                      //               Text("Creer Un PorteFeuille".toUpperCase()),
                      //           content: Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //               vertical: 10,
                      //             ),
                      //             child: Column(
                      //               children: [
                      //                 CupertinoTextField(
                      //                   placeholder: "Ex:Marche Noel",
                      //                   controller: nameController,
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //           actions: [
                      //             TextButton(
                      //                 onPressed: () {
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: Text(
                      //                   "Annuler".toUpperCase(),
                      //                   style: TextStyle(color: Colors.red),
                      //                 )),
                      //             CupertinoButton(
                      //                 child: Text("Valider".toUpperCase()),
                      //                 onPressed: () async {
                      //                   if (nameController.text != '') {
                      //                     Task _newTask = Task(
                      //                         title: nameController.text,
                      //                         total: 0,
                      //                         status: 0);
                      //                     await _dbHelper
                      //                         .insertTask(_newTask)
                      //                         .then((value) {
                      //                       setState(() {});
                      //                     });
                      //                     nameController.clear();

                      //                     Navigator.pop(context);
                      //                   } else {
                      //                     Navigator.pop(context);
                      //                   }
                      //                   nameController.clear();
                      //                 } )
                      //           ],
                      //         ));
                    },
                    child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            color: Color(0xff00c4d5),
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
}

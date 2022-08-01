// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:keep_note/database_helper.dart';
import 'package:keep_note/models/task.dart';
import 'package:keep_note/screen/homepage.dart';
import 'package:keep_note/screen/taskpage.dart';
import 'package:keep_note/widget.dart';

class ArchivePage extends StatefulWidget {
  ArchivePage({Key? key}) : super(key: key);

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  DataBaseHelper _dbHelper = DataBaseHelper();
  Task _task = Task();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Text(
              "ARCHIVES",
              style: TextStyle(color: Color(0xff86829d), fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xfff6f6f6),
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
                    Container(
                      child: Text(""),
                      margin: EdgeInsets.only(bottom: 32),
                    ),
                    Expanded(
                        child: FutureBuilder(
                            initialData: [],
                            future: _dbHelper.getTaskArchive(),
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
                                              flex: 1,
                                              autoClose: true,
                                              onPressed: (value) async {
                                                int _permet = 0;

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
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        " Votre portefeuille ${snapshot.data[index].title} viens d'etre désarchivé "),
                                                 
                                                  ],
                                                )));
                                                Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (contex) =>
                                                                HomePage()))
                                                    .then((value) {
                                                  setState(() {});
                                                });
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
              ],
            ),
          ),
        ));
  }
}

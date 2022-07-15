// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
                                                ))).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                      motion: DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (value) {},
                                          backgroundColor: Colors.red,
                                          icon: CupertinoIcons.delete,
                                        )
                                      ],
                                    ),
                                    
                                    startActionPane:  
                                        ActionPane(
                                      motion: DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          flex: 1,
                                          onPressed: (value) {},
                                          backgroundColor: Colors.blue,
                                          icon: CupertinoIcons.archivebox_fill,
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

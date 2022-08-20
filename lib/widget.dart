// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keep_note/database_helper.dart';

DataBaseHelper _dbHelper = DataBaseHelper();

class TaskCardWidget extends StatelessWidget {
  final title;
  final total;
  final status;
  const TaskCardWidget({this.title, this.total, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffcaf1f5),
        ),
        margin: EdgeInsets.only(bottom: 18),
        child: ListTile(
          title: Text(
            title ?? ("sans nom"),
            style: TextStyle(
              fontSize: 17,
              color: Color(0xff211551),
              fontWeight: FontWeight.bold,
            ),
          ),
          // trailing:    Padding(
          //   padding: EdgeInsets.only(top: 10),
          //   child: Text(
          //     "$total",
          //     style: TextStyle(
          //         fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff86829d),),
          //   ),
          // ),
        ));
  }
}

class TodoWidget extends StatefulWidget {
  final String? text;
  final int etat;
  final int? id;
  const TodoWidget({this.text, required this.etat, required this.id});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  Color? getColor(int number) {
    if (number == 0) {
      return Color(0xff82869d);
    }
    if (number == 1) {
      return Colors.red.shade300;
    }
    if (number == 2) {
      return Colors.green.shade300;
    } else {
      return Color(0xff82869d);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
                color: getColor(widget.etat),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.white, width: 1.4)),
            child: GestureDetector(
              onTap: () async {},
            ),
          ),
          Flexible(
            child: Text(
              widget.text ?? ("Tache sans nom"),
              style: TextStyle(
                  color: Color(0xff82869d),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportchrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class TopCard extends StatefulWidget {
  final String title;
  final int? debit;
  final int? credit;
  final int total;
  final int? id; 
  TopCard(
      {required this.title,
      required this.credit,
      required this.debit,
      this.id,
      required this.total});

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Debit',
                              style: TextStyle(color: Colors.black45)),
                          SizedBox(
                            height: 5,
                          ),
                            Text("${  widget.debit  }",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          // Text("${  widget.debit  }",
                          //     style: TextStyle(
                          //         color: Colors.black,
                          //         fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  // Text(
                  //   "${widget.total}",
                  //   style: TextStyle(color: Colors.grey[800], fontSize: 22),
                  // ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Credit',
                              style: TextStyle(color: Colors.black45)),
                          SizedBox(
                            height: 5,
                          ),
                          Text("${widget.credit}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(color: Color(0xff00c4d5)),
    );
  }
}

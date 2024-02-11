import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';




class MyHomePage extends StatefulWidget {

  MyHomePage({Key ? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List listToSearch=[
    {
      'name': 'Amir',
      'class': 12
    },
    {
      'name': 'Raza',
      'class': 11
    },
    {
      'name': 'Praksh',
      'class': 10
    },
    {
      'name': 'Nikhil',
      'class': 9
    },
    {
      'name': 'Sandeep',
      'class': 8
    },
    {
      'name': 'Tazeem',
      'class': 7
    },
    {
      'name': 'Najaf',
      'class': 6
    },
    {
      'name': 'Izhar',
      'class': 5
    },
  ];

  var selected;
  late List selectedList;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20,),

              Text('Multi Select as Widget',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),

            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
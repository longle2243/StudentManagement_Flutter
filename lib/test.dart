import 'package:clonevue/studentadd.dart';
import 'package:flutter/material.dart';
import 'widget/drawer.dart';
class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        backgroundColor: Colors.teal,
      ),
      drawer: drawermenu(),
      body: Studentadd(),
    );
  }
}

import 'package:flutter/material.dart';
import 'widget/drawer.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        backgroundColor: Colors.teal,
      ),
      drawer: drawermenu(),
      body: Container(
        child: Column(
          children: [
            TextField(decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'New Task')),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:clonevue/AssignTeam.dart';
import 'package:clonevue/Tasks.dart';
import 'package:clonevue/about.dart';
import 'package:clonevue/calendart.dart';
import 'package:clonevue/studentadd.dart';
import 'package:clonevue/studentlist.dart';
import 'package:flutter/material.dart';
import '../account/login.dart';
import '../test.dart';
final List<String> listname = [
  "Calendar",
  "Tasks",
  "Student List",
  "Add a Student",
  "Assign Teams",
  "About",
  "Logout"
];
final List<IconData> listicon = [
  Icons.calendar_today,
  Icons.checklist,
  Icons.person,
  Icons.person_add,
  Icons.person_pin_rounded,
  Icons.question_mark,
  Icons.logout,
];

final List<Widget> listclass=[
  Calendar(),
  Tasks(),
  Studentlist(),
  Studentadd1(),
  AssignTeam(),
  About(),
  Login(),
];

class Listnav extends StatelessWidget {
  final String namenav;
  final IconData iconnav;
  final Widget widgetnav;
  Listnav({required this.namenav, required this.iconnav, required this.widgetnav});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconnav, size: 20, color: Colors.black),
      title: Text(namenav, style: TextStyle(color: Colors.black, fontSize: 12)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=> widgetnav),
        );
      },
    );
  }
}

class drawermenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student Management',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Dashboard',
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ],
              )),
            ),
          ),
          for (int i = 0; i < listname.length; i++)
            Listnav(namenav: listname[i], iconnav: listicon[i], widgetnav: listclass[i]),
        ],
      ),
    );
  }
}

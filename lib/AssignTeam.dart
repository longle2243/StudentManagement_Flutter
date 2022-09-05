import 'package:clonevue/account/student.dart';
import 'package:clonevue/widget/drawer.dart';
import 'package:clonevue/widget/dropdown.dart';
import 'package:clonevue/widget/radiolist2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()

class AssignTeam extends StatelessWidget {
  const AssignTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        backgroundColor: Colors.teal,
      ),
      drawer: drawermenu(),
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  String dropdownvalue = 'Team 1';
  var items = [
    'Team 1',
    'Team 2',
    'Team 3',
    'Team 4',
    'Team 5',
  ];
  List _loadeddata = [];
  Future<void> _fetchData() async {
    const apiUrl = 'http://10.32.61.1:8081/api/students';
    final response = await http.get(Uri.parse(apiUrl), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
    });
    final data = json.decode(response.body);
    setState(() {
      _loadeddata = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text("  Student List",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height/3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                            columns: [
                              DataColumn(label: Text("Student\nNo.")),
                              DataColumn(label: Text("Name")),
                              DataColumn(label: Text("Email")),
                              DataColumn(label: Text("Genders")),
                              DataColumn(label: Text("Team")),
                            ],
                            rows: List.generate(_loadeddata.length, (index) {
                              return DataRow(cells: [
                                DataCell(Text(_loadeddata[index]['id'].toString())),
                                DataCell(Text(_loadeddata[index]['name'])),
                                DataCell(Text(_loadeddata[index]['email'])),
                                DataCell(Text(_loadeddata[index]['gender'])),
                                DataCell(Text(_loadeddata[index]['teams'])),
                              ]);
                            })),
                      ),
                    ),
                  ),
                  Text("  Reassign a team for an existing student",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Container(
                    margin:  EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                            decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'Enter your username',)),
                        SizedBox(
                          child: InputDecorator(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Enter name",
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: dropdownvalue,
                                icon: Icon(Icons.arrow_drop_down_sharp),
                                items: items.map((String items) {
                                  return DropdownMenuItem(value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newvalue) {
                                  setState(() {
                                    dropdownvalue = newvalue!;
                                    //_listFilter=_loadeddata.where((element) => element['teams'].toLowerCase().contains(dropdownvalue.toLowerCase())).toList();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}

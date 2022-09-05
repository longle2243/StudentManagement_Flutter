import 'package:clonevue/widget/drawer.dart';
import 'package:clonevue/widget/dropdown.dart';
import 'package:clonevue/widget/radiolist2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()

class Studentlist extends StatelessWidget {
  const Studentlist({Key? key}) : super(key: key);

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

  List _loadeddata = [];
  List _listFilter = [];
  final searchname= TextEditingController ();
  final searchemail= TextEditingController ();
  String _result="all";
  String dropdownvalue = 'Team 1';
  var items = [
    'Team 1',
    'Team 2',
    'Team 3',
    'Team 4',
    'Team 5',
  ];
  Future<void> _fetchData() async {
    const apiUrl = 'http://10.32.61.1:8081/api/students';
    final response = await http.get(Uri.parse(apiUrl), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
    });
    final data = json.decode(response.body);
    setState(() {
      _loadeddata = data;
      _listFilter = data;
    });
  }
  Future<void> _deletestudent(String id) async {
    var apiUrl = 'http://10.32.61.1:8081/api/deletestudent/'+id;
    final response = await http.delete(Uri.parse(apiUrl), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
    });
    final data = json.decode(response.body);
    setState(() {
      _loadeddata = data;
      _listFilter = data;
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
        SizedBox(height: 5),
        Text("  Student List",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        SizedBox(height: 5),
        Container(
          height: MediaQuery.of(context).size.height/2,
          margin:  EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Search by Name"),
                TextField(
                  controller: searchname,
                    onChanged: (value){
                      setState(() {
                        _listFilter=_loadeddata.where((element) => element['name'].toLowerCase().contains(value.toLowerCase())).toList();
                      });
                    },
                    style: TextStyle(height: 0.5, color: Colors.black),
                    decoration: InputDecoration(border: OutlineInputBorder())),
                Text("Search by Name"),
                TextField(
                    controller: searchemail,
                    onChanged: (value){
                      setState(() {
                        _listFilter=_loadeddata.where((element) => element['email'].toLowerCase().contains(value.toLowerCase())).toList();
                      });
                    },
                    style: TextStyle(height: 0.5, color: Colors.black),
                    decoration: InputDecoration(border: OutlineInputBorder())),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gender:"),
              Container(
                height: 30,
                child: ListTile(
                  title: Text("Male"),
                  leading: Radio(
                    value: "M",
                    groupValue: _result,
                    onChanged: (String? value){
                      setState(() {
                        _result=value!;
                        _listFilter=_loadeddata.where((element) => element['gender'].toLowerCase().contains(_result.toLowerCase())).toList();
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: Text("Female"),
                  leading: Radio(
                    value: "F",
                    groupValue: _result,
                    onChanged: (String? value){
                      setState(() {
                        _result=value!;
                        _listFilter=_loadeddata.where((element) => element['gender'].toLowerCase().contains(_result.toLowerCase())).toList();
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: Text("All"),
                  leading: Radio(
                    value: "all",
                    groupValue: _result,
                    onChanged: (String? value){
                      setState(() {
                        _result=value!;
                        _listFilter=_loadeddata;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
                InputDecorator(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "pick a team",
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
                          _listFilter=_loadeddata.where((element) => element['teams'].toLowerCase().contains(dropdownvalue.toLowerCase())).toList();
                        });
                      },
                    ),
                  ),
                ),
              ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height/4,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    columns: [
                      DataColumn(label: Text("Student\nNo.")),
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Email")),
                      DataColumn(label: Text("Genders")),
                      DataColumn(label: Text("Team")),
                      DataColumn(label: Text("Action")),
                    ],
                    rows: List.generate(_listFilter.length,(index){
                      return DataRow(cells: [
                        DataCell(Text(_listFilter[index]['id'].toString())),
                        DataCell(Text(_listFilter[index]['name'])),
                        DataCell(Text(_listFilter[index]['email'])),
                        DataCell(Text(_listFilter[index]['gender'])),
                        DataCell(Text(_listFilter[index]['teams'])),
                        DataCell(IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              _deletestudent(_listFilter[index]['id'].toString());
                              _fetchData();
                            });
                          },
                        ),),
                      ]);
                    })
        ),
              ),
          )
        )
      ],
    ),
            )));
  }
}

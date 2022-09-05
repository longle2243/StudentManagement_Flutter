
import 'package:clonevue/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'widget/dropdown.dart';
import 'widget/checkboxgender.dart';
import 'account/student.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Student> createStudent(String name,String email,String team,String gender) async {
  final response = await http.post(
    Uri.parse('http://10.32.61.1:8081/api/createstudent'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'gender': gender,
      'teams': team,
    }),
  );
print(Student.fromJson(jsonDecode(response.body)));
  if (response.statusCode == 201) {
    return Student.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Student.');
  }
}
class Studentadd1 extends StatelessWidget {
  const Studentadd1({Key? key}) : super(key: key);

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
class Studentadd extends StatefulWidget {
  const Studentadd({Key? key}) : super(key: key);

  @override
  State<Studentadd> createState() => _StudentaddState();
}

class _StudentaddState extends State<Studentadd> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  String dropdownvalue = 'Team 1';
  var items = [
    'Team 1',
    'Team 2',
    'Team 3',
    'Team 4',
    'Team 5',
  ];
  String _result="M";
  Future<Student>? _futureStudent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("Add a Student",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Student Name",
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Email",
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: InputDecorator(
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
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/2.5,
                  child: Column(
                    children: [
                      Text("Choose a gender:"),
                      ListTile(
                        title: Text("Male"),
                        leading: Radio(
                          value: "M",
                          groupValue: _result,
                          onChanged: (String? value){
                            setState(() {
                              _result=value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("Female"),
                        leading: Radio(
                          value: "F",
                          groupValue: _result,
                          onChanged: (String? value){
                            setState(() {
                              _result=value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureStudent = createStudent(_name.text,_email.text,dropdownvalue,_result);
                  print(_name.text+_email.text+dropdownvalue+_result);
                });
              },
              child: const Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}

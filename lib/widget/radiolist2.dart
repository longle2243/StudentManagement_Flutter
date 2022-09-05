import 'package:flutter/material.dart';

class radiolist2 extends StatefulWidget {
  const radiolist2({Key? key}) : super(key: key);

  @override
  State<radiolist2> createState() => _radiolist2State();
}
enum gender { male, female, all }
class _radiolist2State extends State<radiolist2> {
  gender? _result=gender.all;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender:"),
        Container(
          height: 20,
          child: ListTile(
            title: Text("Male"),
            leading: Radio(
              value: gender.male,
              groupValue: _result,
              onChanged: (gender? value){
                setState(() {
                  _result=value;
                });
              },
            ),
          ),
        ),
        Container(
          height: 20,
          child: ListTile(
            title: Text("Female"),
            leading: Radio(
              value: gender.female,
              groupValue: _result,
              onChanged: (gender? value){
                setState(() {
                  _result=value;
                });
              },
            ),
          ),
        ),
        Container(
          height: 20,
          child: ListTile(
            title: Text("All"),
            leading: Radio(
              value: gender.all,
              groupValue: _result,
              onChanged: (gender? value){
                setState(() {
                  _result=value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

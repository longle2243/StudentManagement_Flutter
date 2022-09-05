import 'package:flutter/material.dart';

class checkboxgender extends StatefulWidget {
  const checkboxgender({Key? key}) : super(key: key);

  @override
  State<checkboxgender> createState() => _checkboxgenderState();
}
enum gender { male, female }
class _checkboxgenderState extends State<checkboxgender> {
  gender? _result=gender.male;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Choose a gender:"),
        ListTile(
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
        ListTile(
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
      ],
    );
  }
}

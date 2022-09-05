import 'package:flutter/material.dart';

class dropdownmenu extends StatefulWidget {
  const dropdownmenu({Key? key}) : super(key: key);

  @override
  State<dropdownmenu> createState() => _dropdownmenuState();
}

class _dropdownmenuState extends State<dropdownmenu> {
  String dropdownvalue = 'Team 1';
  var items = [
    'Team 1',
    'Team 2',
    'Team 3',
    'Team 4',
    'Team 5',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
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
    );
  }
}

import 'package:clonevue/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task Manager"),
          backgroundColor: Colors.teal,
        ),
        drawer: drawermenu(),
        body: Container(
          child: SfCalendar(
            view: CalendarView.month,
          ),
        ));
  }
}

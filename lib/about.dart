import 'package:flutter/material.dart';
import 'widget/drawer.dart';
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        backgroundColor: Colors.teal,
      ),
      drawer: drawermenu(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text("About Student Management App",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
              Text("I think Vue CLI is wonderful. It builds the whole package for your application which saves you time and also minimizes mistakes you would have made creating the structure of your application. It reminds me of express cli that we used last semester in mobile development. I have also seen a lot of Vue projects and they were build like these which I was confused at first but makes sense now. When I first started working on this project, I had a lot of difficulties, thanks to the help of friends and open-source sources I was able to complete it. I've also seen a lot of Vue projects and they were built like these which I was confused at first but made sense now.",
                style: TextStyle(fontSize: 12),),
            ],
          ),
        ),
      ),
      );
  }
}

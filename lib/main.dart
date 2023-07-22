import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_assignment/Screens/AllExcercise.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'New Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllExcerciseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}




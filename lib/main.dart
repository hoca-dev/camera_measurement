// import 'dart:html';



import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:test1/mainpage.dart';

void main() async {
     WidgetsFlutterBinding.ensureInitialized();
  await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruler Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyWidget(),
    );
  }
}

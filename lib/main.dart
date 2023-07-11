
import 'package:flutter/material.dart';
import 'package:test1/cameraPage.dart';

void main() async {
     WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  CameraPage(),
    );
  }
}

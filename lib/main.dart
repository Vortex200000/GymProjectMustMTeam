import 'package:flutter/material.dart';
import 'package:mgym/home/home.dart';
import 'package:mgym/init_main.dart';

void main() {
  initMain();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

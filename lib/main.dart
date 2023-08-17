import 'package:flutter/material.dart';
// import 'package:physical/homepage.dart';
import 'package:physical/login.dart';
import 'package:physical/popup.dart';
import 'package:physical/test.dart';

import 'grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const Test(),
      initialRoute: '/',
      routes: {
        '/login': (context) => const Login(),
      },
    );
  }
}

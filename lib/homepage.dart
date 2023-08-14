import 'package:flutter/material.dart';
import 'package:physical/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Object;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(args.toString()),
      ),
    );
  }
}

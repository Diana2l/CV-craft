// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Creative extends StatefulWidget {
  const Creative({super.key});

  @override
  State<Creative> createState() => _CreativeState();
}

class _CreativeState extends State<Creative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creative'),
        backgroundColor: Colors.brown,
        ),
      
    );
  }
}

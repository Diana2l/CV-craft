// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        ),
        body: Center(
          child: Text('This is the help page'),

          
          ),
          
    );
  }
}
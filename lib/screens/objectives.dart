// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

TextEditingController _controller = TextEditingController();

class Objectives extends StatefulWidget {
  const Objectives({super.key});

  @override
  State<Objectives> createState() => _ObjectivesState();
}

class _ObjectivesState extends State<Objectives> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Objectives'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            maxLines :null,
            onChanged: (value) {
              print(value);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Enter your objective',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
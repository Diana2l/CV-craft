// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final TextEditingController _controller = TextEditingController();

  String _educationBackground = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Education'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            maxLines: null,
            onChanged: (value) {
              setState(() {
                _educationBackground = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Enter your education background',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_educationBackground);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}


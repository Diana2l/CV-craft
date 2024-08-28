// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editable Resume',
      home: Modern(),
    );
  }
}

class Modern extends StatefulWidget {
  @override
  _ModernState createState() => _ModernState();
}

class _ModernState extends State<Modern> {
  TextEditingController nameController = TextEditingController(text: 'Frederik Trujillo');
  TextEditingController jobTitleController = TextEditingController(text: 'Landscape Architect');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Resume'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextField(
            controller: jobTitleController,
            decoration: InputDecoration(labelText: 'Job Title'),
            style: TextStyle(fontSize: 18, color: Colors.green[800]),
          ),
          

          
        ],
     ),
);
}
}
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:cv_craft/screens/Build.dart';

class CompiledCVScreen extends StatelessWidget {
  final CVData cvData;
  
  var body;

  CompiledCVScreen({required this.cvData, required String objectives});
  
  get _displayController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compiled CV')),
      body: ListView(
        children: [
          _buildSection('Name', cvData.name),
          _buildSection('Summary', cvData.summary),
          _buildSection('Experience', cvData.experience.join('\n')),
          _buildSection('Education', cvData.education.join('\n')),
          _buildSection('Skills', cvData.skills.join(', ')),
        
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _displayController,
          maxLines: null,
          readOnly: true, 
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Your objectives',
          ),
        ),
      ),
        ]
      ),
      
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(content),
        ],
      ),
    );
  }
}
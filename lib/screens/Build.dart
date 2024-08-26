// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cv_craft/screens/compiled_cv.dart';

class CVData {
  String name = '';
  String summary = '';
  String email = '';
  String phone = '';
  String linkedin = '';
  List<String> experience =[];
  List<String> education = [];
  List<String> skills = [];
  List<String> projects = [];
  List<String> achievements = [];
  List<String> references = [];
}

class Build extends StatefulWidget {
  @override
  _BuildState createState() => _BuildState();
}

class _BuildState extends State<Build> {
  final _cvData = CVData();
  final _nameController = TextEditingController();
  final _summaryController = TextEditingController();
  final _experienceController = TextEditingController();
  final _educationController = TextEditingController();
  final _skillsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => _cvData.name = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _summaryController,
                decoration: InputDecoration(labelText: 'Summary'),
                onChanged: (value) => _cvData.summary = value,
              ),
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(labelText: 'Experience'),
                onChanged: (value) => _cvData.experience = value.split('\n'),
              ),
              TextFormField(
                controller: _educationController,
                decoration: InputDecoration(labelText: 'Education'),
                onChanged: (value) => _cvData.education = value.split('\n'),
              ),
              TextFormField(
                controller: _skillsController,
                decoration: InputDecoration(labelText: 'Skills'),
                onChanged: (value) => _cvData.skills = value.split(', '),
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompiledCVScreen(cvData: _cvData, objectives: '',)),
                  );
                },
                child: Text('Compile CV'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
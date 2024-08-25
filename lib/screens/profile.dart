// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, unused_field, unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobs_link/main.dart';
import 'package:jobs_link/models/ProfileModel.dart';
import 'package:jobs_link/screens/Build.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _avatar;
  final ImagePicker _picker = ImagePicker();
  bool _editMode = false; 
  String _welcomeMessage = 'Welcome, John Doe';

  @override
  void initState() {
    super.initState();
    _usernameController.text = 'John Doe'; 
    _emailController.text = 'john.doe@example.com'; 
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
     
      print('Username: ${_usernameController.text}');
      print('Email: ${_emailController.text}');
    
      await Future.delayed(const Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _editMode = false; 
        _welcomeMessage = 'Welcome, ${_usernameController.text}'; 
      });
    }
  }

  void _changeAvatar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _avatar = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileModel>(
      builder: (context, profile, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_welcomeMessage),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    _editMode = !_editMode;
                  });
                },
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _changeAvatar,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _avatar != null ? Image.file(_avatar!).image : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    enabled: _editMode, 
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    enabled: _editMode, 
                  ),
                  const SizedBox(height: 20),
                  _editMode
                      ? ElevatedButton(
                          onPressed: _saveChanges,
                          child: const Text('Save Changes'),
                        )
                      : Container(), 
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
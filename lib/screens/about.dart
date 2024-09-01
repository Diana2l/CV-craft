import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('About Us'),
        ),  
        backgroundColor: Colors.teal, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to CV Craft, where we believe that every job seeker deserves a powerful first impression. Crafting the perfect CV can seem difficult, but with our app, we make it simple, intuitive, and even enjoyable. Whether you’re just starting your career journey or are a seasoned professional, our goal is to help you present your unique story in a way that stands out.\n\n'
              'At CV Craft, we’ve combined smart technology with thoughtful design to give you all the tools you need to create a polished, professional CV in minutes. But it’s more than just about templates and fonts. We’re here to guide you through every step, offering tips and insights to ensure your CV truly reflects your skills, experience, and personality.\n\n'
              'We’re passionate about helping you land your dream job by making sure your CV is as impressive as your potential. Let’s craft something great together!',
              style: TextStyle(fontSize: 16.0, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: About(),
  ));
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cv_craft/models/ClassicPage.dart';
import 'package:cv_craft/models/creative.dart';
import 'package:cv_craft/models/minimalist.dart';
import 'package:cv_craft/models/modern.dart';
import 'package:cv_craft/models/technical.dart';

class Templates extends StatelessWidget {
  final List<String> templates = [
    'Modern Professional',
    'Creative Design',
    'Minimalist',
    'Classic',
    'Technical'
  ];

  final List<String> templateImages = [
    'assets/Modern.png', // Example image paths
    'assets/creative.png',
    'assets/minimalist.png',
    'assets/classic.png',
    'assets/technical.png'
  ];
  
  get debugShowCheckedModeBanner => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Templates'),
      ),
      body: ListView.builder(
        itemCount: templates.length,
        itemBuilder: (context, index) {
          return TemplateCard(
            templateName: templates[index],
            templateImage: templateImages[index],
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('debugShowCheckedModeBanner', debugShowCheckedModeBanner));
  }
}

class TemplateCard extends StatelessWidget {
  final String templateName;
  final String templateImage;

  TemplateCard({required this.templateName, required this.templateImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemplateDetailPage(templateName: templateName),
            ),
          );
        },
        child: Row(
          children: [
            Image.asset(
              templateImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    templateName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tap to edit your resume with this template.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}

class TemplateDetailPage extends StatelessWidget {
  final String templateName;

  TemplateDetailPage({required this.templateName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(templateName),
      ),
      body: ResumeEditor(templateName: templateName),
    );
  }
}

class ResumeEditor extends StatelessWidget {
  final String templateName;

  ResumeEditor({required this.templateName});

  @override
  Widget build(BuildContext context) {
    // This would be replaced by specific form fields according to the template selected
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            'Edit Your $templateName Resume',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          // Add more fields as necessary
          // Save or Export button can be added at the bottom
        ],
      ),
    );
  }
}

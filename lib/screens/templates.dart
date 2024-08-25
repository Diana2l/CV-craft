// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable, unused_field, unused_import

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

  var debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: templates.length,
        itemBuilder: (context, index) {
          return TemplateCard(templateName: templates[index]);
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

  TemplateCard({required this.templateName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(15.0),
        title: Text(
          templateName,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemplateDetailPage(templateName: templateName),
            ),
          );
        },
      ),
    );
  }
}

class TemplateDetailPage extends StatelessWidget {
  final String templateName;

  TemplateDetailPage({required this.templateName});

  @override
  Widget build(BuildContext context) {
    switch (templateName) {
      case 'Modern Professional':
        return Modern();
      case 'Creative Design':
        return Creative();
      case 'Minimalist':
        return Minimalist();
      case 'Classic':
        return ClassicPage();
      case 'Technical':
        return Technical();
      default:
        return Scaffold(
          appBar: AppBar(
            title: Text(templateName),
          ),
          body: Center(
            child: Text(
              'Details for $templateName template.',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        );
    }
  }
}


  
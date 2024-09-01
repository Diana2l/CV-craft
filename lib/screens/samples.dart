// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, unused_local_variable, depend_on_referenced_packages, unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Samples extends StatefulWidget {
  @override
  _SamplesState createState() => _SamplesState();
}

class _SamplesState extends State<Samples> {
  String? _cvPath;
  final TextEditingController _coverLetterController = TextEditingController();

  Future<void> _pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        _cvPath = result.files.single.path;
      });
    }
  }

  Future<void> _generatePDF() async {
   if (_cvPath == null || _coverLetterController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(content: Text('Please provide a cover letter and select a CV.')),
      );
      return;
    }

    final pdf = pw.Document();
    final pdfImage = pw.MemoryImage(await File(_cvPath!).readAsBytes());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Cover Letter', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text(_coverLetterController.text),
            pw.SizedBox(height: 40),
            pw.Image(pdfImage),
          ],
        ),
      ),
    );

   
    final outputFile = await Printing.sharePdf(
     bytes: await pdf.save(),
     filename: 'application.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compiler'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickCV,
              child: Text('Select CV'),
            ),
            if (_cvPath != null) Text('Selected CV: $_cvPath'),
            SizedBox(height: 20),
            TextField(
              controller: _coverLetterController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Cover Letter',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generatePDF,
              child: Text('Generate PDF'),
            ),
          ],
        ),
      ),
    );
  }
}

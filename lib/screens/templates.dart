import 'package:cv_craft/screens/cv_editor_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


final List<String> templates = [
  'assets/images/Modern.png',
  'assets/images/creative.png',
  'assets/images/minimalist.png',
  'assets/images/classic.png',
  'assets/images/technical.png',
];

class Templates extends StatefulWidget {
  @override
  _Templates createState() => _Templates();
}

class _Templates extends State<Templates> {
  int currentIndex = 0;

  Future<void> _selectTemplate(String templatePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_template', templatePath);
    
    // Extract template name from path (e.g., 'Modern' from 'assets/images/Modern.png')
    final templateName = templatePath
        .split('/')
        .last
        .split('.')
        .first
        .toLowerCase();

    // Navigate to CV Editor with selected template
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CVEditorScreen(
          fontSize: 16,
          headerFontSize: 24,
          fontFamily: 'OpenSans',
          color: Colors.teal,
          objective: '',
          template: templateName,
          templateImage: templatePath,
        ),
      ),
    );
  }

  void _nextTemplate() {
    setState(() {
      currentIndex = (currentIndex + 1) % templates.length;
    });
  }

  void _previousTemplate() {
    setState(() {
      currentIndex = (currentIndex - 1 + templates.length) % templates.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String template = templates[currentIndex];
    final String templateName = template.split('/').last.split('.').first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Template'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _previousTemplate,
                  icon: const Icon(Icons.arrow_left, size: 40),
                ),
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                      maxHeight: 350,
                    ),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(template, fit: BoxFit.contain),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _nextTemplate,
                  icon: const Icon(Icons.arrow_right, size: 40),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              templateName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${currentIndex + 1} of ${templates.length}',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectTemplate(template),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Use This Template',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

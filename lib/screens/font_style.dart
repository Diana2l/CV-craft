// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_link/screens/Build.dart';

class FontStylePage extends StatefulWidget {
  final void Function(String fontSize, String headerFontSize, String fontFamily, Color selectedColor) onApply;
  FontStylePage({required this.onApply});

  @override
  _FontStylePageState createState() => _FontStylePageState();
}

class _FontStylePageState extends State<FontStylePage> {
  static const _fontSizeOptions = ['16 px', '24 px', '32 px'];
  static const _fontFamilyOptions = ['OpenSans', 'Times New Roman', 'Courier New',];

  String _fontSize = '16 px';
  String _headerFontSize = '24 px';
  String _fontFamily = 'OpenSans'; 
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Font Style'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDropdown(
              label: 'Font Size',
              value: _fontSize,
              options: _fontSizeOptions,
              onChanged: (newValue) {
                setState(() {
                  _fontSize = newValue!;
                });
              },
            ),
            _buildDropdown(
              label: 'Header Font Size',
              value: _headerFontSize,
              options: _fontSizeOptions,
              onChanged: (newValue) {
                setState(() {
                  _headerFontSize = newValue!;
                });
              },
            ),
            _buildDropdown(
              label: 'Font Family',
              value: _fontFamily,
              options: _fontFamilyOptions,
              onChanged: (newValue) {
                setState(() {
                  _fontFamily = newValue!;
                });
              },
            ),
            SizedBox(height: 16),
            Text('Color', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildColorCircle(Colors.red),
                buildColorCircle(Colors.green),
                buildColorCircle(Colors.blue),
                buildColorCircle(Colors.brown),
                buildColorCircle(Colors.teal),
                buildColorCircle(Colors.orange),
                buildColorCircle(Colors.grey),
                buildColorCircle(Colors.pink),
              ],
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _fontSize = '16 px';
                      _headerFontSize = '24 px';
                      _fontFamily = 'OpenSans';
                      _selectedColor = Colors.red;
                    });
                  },
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () {
                     print('Font Size: $_fontSize');
    print('Header Font Size: $_headerFontSize');
    print('Font Family: $_fontFamily');
    print('Selected Color: $_selectedColor');
     widget.onApply(_fontSize, _headerFontSize, _fontFamily, _selectedColor);
    Navigator.push(
         context,
     MaterialPageRoute(builder: (context) => Build()),
       ); },

     child: Text('Apply', style: TextStyle(fontFamily: _fontFamily)),
      
       style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 18)),
          DropdownButton<String>(
            value: value,
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget buildColorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: CircleAvatar(
          backgroundColor: color,
          radius: 16,
          child: _selectedColor == color ? Icon(Icons.check, color: Colors.white) : null,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextEditingController _controller = TextEditingController();
int selectedIndex = 0; 
class Experience extends StatefulWidget {
  const Experience({super.key});

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Experience'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                    _controller.clear();
                  });
                },
                child: Text(
                  'Experience',
                  style: TextStyle(
                    fontWeight: selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                    color: selectedIndex == 0 ? Colors.blue : Colors.black,
                  ),
                ),
              ),
             
            ],
          ),
          SizedBox(height: 10),
          TextField(
            controller: _controller,
            maxLines: null,
            onChanged: (value) {
              print(value);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: selectedIndex == 0 ? 'Experience' : 'Example',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: _controller.text)); 
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Copied to clipboard')),
            );
          },
          child: Text('Copy'),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Save', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

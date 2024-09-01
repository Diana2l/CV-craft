import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title:  Text('FAQ Page'),
        ),
        body: const FAQ(),
      ),
    );
  }
}

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExpansionTile(
              title: const Text('Q:Should a resume have references and hobbies?  '),
              leading: Icon(_isExpanded1 ? Icons.arrow_drop_down : Icons.arrow_drop_up),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded1 = expanded;
                });
              },
              children: [
                ListTile(
                  title: const Text('Not really but its good to have them in case they are needed'),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Q: Can I save my CV?'),
              leading: Icon(_isExpanded2 ? Icons.arrow_drop_down : Icons.arrow_drop_up),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded2 = expanded;
                });
              },
              children: [
                ListTile(
                  title: const Text('To edit your CV, navigate to the CV editing page and make the necessary changes. Be sure to save your changes after editing.'),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Q: How do I create a CV?'),
              leading: Icon(_isExpanded3 ? Icons.arrow_drop_down : Icons.arrow_drop_up),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded3 = expanded;
                });
              },
              children: [
                ListTile(
                  title: const Text('To create a CV, go to the CV creation page and fill in your details in the required fields. You can also customize the layout and format of your CV.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
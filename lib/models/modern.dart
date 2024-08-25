import 'package:flutter/material.dart';

class Modern extends StatefulWidget {
  const Modern({super.key});

  @override
  State<Modern> createState() => _ModernState();
}

class _ModernState extends State<Modern> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern UI'),
        backgroundColor: Colors.brown,
        ),
    );
  }
}
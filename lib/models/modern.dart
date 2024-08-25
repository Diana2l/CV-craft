import 'package:flutter/material.dart';

class Modern extends StatefulWidget {

  _ModernState createState() => _ModernState();
}

class _ModernState extends State<Modern> {
  // Controllers for text fields
  final nameController = TextEditingController(text: 'FREDERICK TRUJILLO');
  final titleController = TextEditingController(text: 'Landscape Architect');
  final objectiveController = TextEditingController(
      text:
          'Highly driven and passionate landscape architect combining hands-on experience as a gardener with top-ranking landscape design skills. My innate communication skills coupled with my ability to visualize efficient outdoor spaces allow me to offer unexpected and unique solutions.');
  final experienceController = TextEditingController(text: '''
2019 - Present | Landscape Architect
Freelance
Designing efficient and beautiful outdoor garden spaces for clients. Altered designs in accordance with client needs and requirements. Overseeing the development of garden design projects. Coordinating with contractors and relevant parties on projects.

2017 - 2019 | Head Gardener
Hawknester House & Gardens, Hamptons, NY
Overseeing a team of 4 gardeners and volunteers. Designing planting arrangements for the year. Maintaining the grounds and lawns. Planting flowers, shrubs, and trees. Managing the general upkeep of paths. Assessing soil condition.

2015 - 2017 | Gardener
Bloomsbury Botanic Gardens, Rochester, NY
Maintaining the grounds and lawns. Planting flowers, shrubs, and trees. Managing the general upkeep of paths. Assessing soil condition. Building structures: decking area, new flower beds, bird habitats.
''');
  final educationController = TextEditingController(text: '''
2015 | Higher Diploma
in Landscape Gardening
Brimbury Community College
Rochester, NY

2019 | B.A.
in Landscape Architecture
Brimbury Community College
New Haven, CT
''');
  final skillsController = TextEditingController(text: '''
Project Management
Creative Mindset
Attention to Detail
Time Management
Problem-Solving
''');
  final referencesController = TextEditingController(text: 'Available upon request');
  final contactController = TextEditingController(text: '''
fredtru@email.site.com
Fredtrujillolandscapes.site.com
311 555 0123
Hamptons, NY
''');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          TextField(
            controller: titleController,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle('OBJECTIVE'),
          TextField(
            controller: objectiveController,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle('EXPERIENCE'),
          TextField(
            controller: experienceController,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle('EDUCATION'),
          TextField(
            controller: educationController,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle('SKILLS'),
          TextField(
            controller: skillsController,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle('REFERENCES'),
          TextField(
            controller: referencesController,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle('CONTACT'),
          TextField(
            controller: contactController,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
    );
  }
}

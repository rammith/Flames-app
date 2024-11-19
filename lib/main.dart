import 'package:flutter/material.dart';

void main() {
  runApp(FlamesApp());
}

class FlamesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLAMES Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlamesHomePage(),
    );
  }
}

class FlamesHomePage extends StatefulWidget {
  @override
  _FlamesHomePageState createState() => _FlamesHomePageState();
}

class _FlamesHomePageState extends State<FlamesHomePage> {
  final _name1Controller = TextEditingController();
  final _name2Controller = TextEditingController();
  String _result = '';
  IconData _resultIcon = Icons.help_outline;

  void _calculateFLAMES() {
    String name1 = _name1Controller.text.toLowerCase();
    String name2 = _name2Controller.text.toLowerCase();

    List<int> nameCounts = List<int>.filled(26, 0);

    for (int i = 0; i < name1.length; i++) {
      if (name1[i] != ' ') {
        nameCounts[name1.codeUnitAt(i) - 97]++;
      }
    }

    for (int i = 0; i < name2.length; i++) {
      if (name2[i] != ' ') {
        nameCounts[name2.codeUnitAt(i) - 97]--;
      }
    }

    int total = 0;
    for (int i = 0; i < nameCounts.length; i++) {
      total += nameCounts[i].abs();
    }

    List<String> flames = ['Friends', 'Lovers', 'Affectionate', 'Marriage', 'Enemies', 'Siblings'];
    int flamesIndex = total % flames.length;

    setState(() {
      _result = flames[flamesIndex];
      _resultIcon = _getIconForResult(_result);
    });
  }

  IconData _getIconForResult(String result) {
    switch (result) {
      case 'Friends':
        return Icons.people;
      case 'Lovers':
        return Icons.favorite;
      case 'Affectionate':
        return Icons.favorite_border;
      case 'Marriage':
        return Icons.ring_volume;
      case 'Enemies':
        return Icons.report_problem;
      case 'Siblings':
        return Icons.family_restroom;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLAMES Calculator'),
      ),
      body: Container(
        color: Colors.grey[200], // Set the background color to a light shade of gray
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _name1Controller,
              decoration: InputDecoration(
                labelText: 'Enter first name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _name2Controller,
              decoration: InputDecoration(
                labelText: 'Enter second name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateFLAMES,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            if (_result.isNotEmpty)
              Column(
                children: [
                  Icon(
                    _resultIcon,
                    size: 100,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

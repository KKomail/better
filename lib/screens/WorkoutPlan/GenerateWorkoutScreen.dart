import 'package:flutter/material.dart';

class GenerateWorkoutScreen extends StatefulWidget {
  const GenerateWorkoutScreen({super.key});

  @override
  _GenerateWorkoutScreenState createState() => _GenerateWorkoutScreenState();
}

class _GenerateWorkoutScreenState extends State<GenerateWorkoutScreen> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _equipmentController = TextEditingController();

  Future<String> _generateWorkoutPlan() async {
    await Future.delayed(const Duration(seconds: 3)); 
    // example of return? 
    return '''
      Workout Plan:
      - Warm-up: 5 minutes of jumping jacks
      - Exercise 1: Push-ups (3 sets of 10 reps)
      - Exercise 2: Squats (3 sets of 15 reps)
      - Exercise 3: Raises (3 x 20)
      - Cool-down: 5 minutes of stretching
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Workout Plan'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalController,
              decoration: const InputDecoration(labelText: 'Fitness Goal'),
            ),
            TextField(
              controller: _levelController,
              decoration: const InputDecoration(labelText: 'Experience Level'),
            ),
            TextField(
              controller: _equipmentController,
              decoration: const InputDecoration(labelText: 'Available Equipment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final plan = await _generateWorkoutPlan();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(plan)),
                );
              },
              child: const Text('Generate Plan'),
            ),
          ],
        ),
      ),
    );
  }
}

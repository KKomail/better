import 'package:flutter/material.dart';
import 'dart:async';

// TODO: Store in back end (dbs) 

class Set {
  int reps;
  double weight;
  Set({required this.reps, required this.weight});
}

class Exercise {
  final String name;
  List<Set> sets;

  Exercise(this.name, {required this.sets});
}

class Workout {
  final String name;
  final List<Exercise> exercises;
  final int duration; // in seconds
  final DateTime date;

  Workout(this.name, this.exercises, this.duration) : date = DateTime.now();
}

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  List<Workout> workouts = [];

  void _addWorkout(Workout workout) {
    setState(() {
      workouts.add(workout);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Workouts'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: ListTile(
                title: Text(workouts[index].name, 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ${workouts[index].date.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Exercises',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...workouts[index].exercises.map((exercise) {
                      double bestWeight = exercise.sets.isNotEmpty
                          ? exercise.sets.map((s) => s.weight).reduce((a, b) => a > b ? a : b)
                          : 0.0;

                      return Text('${exercise.name}: Best Set @ ${bestWeight} kg');
                    }),
                    Text('Total Duration: ${workouts[index].duration ~/ 60} min ${workouts[index].duration % 60} sec'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newWorkout = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddWorkoutScreen()),
          );
          if (newWorkout != null) {
            _addWorkout(newWorkout);
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final TextEditingController _workoutNameController = TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  final List<Exercise> _exercises = [];
  final List<Set> _currentSets = [];
  late Timer _timer;
  int _elapsedTime = 0; // Time in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _elapsedTime = 0; // Reset elapsed time
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _addSet() {
    if (_repsController.text.isNotEmpty && _weightController.text.isNotEmpty) {
      setState(() {
        final set = Set(
          reps: int.parse(_repsController.text),
          weight: double.parse(_weightController.text),
        );
        _currentSets.add(set);
        _repsController.clear();
        _weightController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter reps and weight.'),
      ));
    }
  }

  void _saveExercise() {
    if (_exerciseNameController.text.isNotEmpty && _currentSets.isNotEmpty) {
      setState(() {
        final exercise = Exercise(
          _exerciseNameController.text,
          sets: List.from(_currentSets),
        );
        _exercises.add(exercise);
        _currentSets.clear();
        _exerciseNameController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter an exercise name and at least one set.'),
      ));
    }
  }

  void _saveWorkout() {
    if (_workoutNameController.text.isNotEmpty && _exercises.isNotEmpty) {
      _stopTimer();
      Navigator.pop(context, Workout(_workoutNameController.text, _exercises, _elapsedTime));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a workout name and at least one exercise.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Workout'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _workoutNameController,
              decoration: const InputDecoration(labelText: 'Workout Name'),
            ),
            const SizedBox(height: 10),
            Text('Elapsed Time: ${_elapsedTime ~/ 60}:${(_elapsedTime % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(
              controller: _exerciseNameController,
              decoration: const InputDecoration(labelText: 'Exercise Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _repsController,
              decoration: const InputDecoration(labelText: 'Reps'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addSet,
              child: const Text('Add Set'),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.teal),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _currentSets.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text('Set ${index + 1}: ${_currentSets[index].reps} reps @ ${_currentSets[index].weight} kg'),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _saveExercise,
              child: const Text('Save Exercise'),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.teal),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveWorkout,
              child: const Text('Finish Workout'),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}

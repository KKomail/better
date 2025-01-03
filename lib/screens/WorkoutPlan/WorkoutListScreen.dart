import 'package:flutter/material.dart';
import 'dart:async';

// TODO: 
// Change the structure of adding exercises, sets, reps, and weight (add sets individually instead of all in one.) 
// Add a Exercise List (try using API so that users can see which exercises to add)  
//
// Create an exercise library 

// Model class for Exercise
class Exercise {
  final String name;
  int sets;
  int reps;
  double weight;

  Exercise(this.name, {this.sets = 1, this.reps = 1, this.weight = 0.0});
}

// Model class for Workout
class Workout {
  final String name;
  final List<Exercise> exercises;
  final int duration; // Duration in seconds

  Workout(this.name, this.exercises, this.duration);
}

// Main screen to display workouts and add new ones
class WorkoutListScreen extends StatefulWidget {
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
        title: Text('My Workouts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(workouts[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...workouts[index].exercises.map((exercise) {
                          return Text('${exercise.name}: ${exercise.sets} sets x ${exercise.reps} reps @ ${exercise.weight} kg');
                        }).toList(),
                        Text('Total Duration: ${workouts[index].duration ~/ 60} min ${workouts[index].duration % 60} sec'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final newWorkout = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddWorkoutScreen()),
              );
              if (newWorkout != null) {
                _addWorkout(newWorkout);
              }
            },
            child: Text('+ Start New Workout'),
          ),
        ],
      ),
    );
  }
}

// Screen to add a new workout
class AddWorkoutScreen extends StatefulWidget {
  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final TextEditingController _workoutNameController = TextEditingController();
  final List<Exercise> _exercises = [];
  
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  late Timer _timer;
  int _elapsedTime = 0; // Time in seconds
  bool _isRunning = false;

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _elapsedTime = 0; // Reset elapsed time
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer.cancel();
  }

  void _addExercise() {
    if (_exerciseNameController.text.isNotEmpty &&
        _setsController.text.isNotEmpty &&
        _repsController.text.isNotEmpty &&
        _weightController.text.isNotEmpty) {

      setState(() {
        final exercise = Exercise(
          _exerciseNameController.text,
          sets: int.parse(_setsController.text),
          reps: int.parse(_repsController.text),
          weight: double.parse(_weightController.text),
        );
        _exercises.add(exercise);
        // Clear the input fields after adding an exercise
        _exerciseNameController.clear();
        _setsController.clear();
        _repsController.clear();
        _weightController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields.'),
      ));
    }
  }

  void _saveWorkout() {
    if (_workoutNameController.text.isNotEmpty && _exercises.isNotEmpty) {
      // Stop the timer before saving the workout
      if (_isRunning) {
        _stopTimer();
      }
      
      Navigator.pop(context, Workout(_workoutNameController.text, _exercises, _elapsedTime));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a workout name and at least one exercise.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _workoutNameController,
              decoration: InputDecoration(labelText: 'Workout Name'),
            ),
            SizedBox(height: 10),
            if (_isRunning)
              Text('Elapsed Time: ${_elapsedTime ~/ 60}:${(_elapsedTime % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 20)),
            SizedBox(height:10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _exerciseNameController,
                    decoration:
                        InputDecoration(labelText: 'Exercise Name'),
                  ),
                ),
                SizedBox(width:10),
                Expanded(
                  child: TextField(
                    controller:_setsController,
                    decoration:
                        InputDecoration(labelText:'Sets', hintText:'e.g.3'), // This should display the previous set record
                    keyboardType:
                        TextInputType.numberWithOptions(decimal:false),
                  ),
                ),
                SizedBox(width:10),
                Expanded(
                  child: TextField(
                    controller:_repsController,
                    decoration:
                        InputDecoration(labelText:'Reps', hintText:'e.g.10'), // This should display the previous rep record
                    keyboardType:
                        TextInputType.numberWithOptions(decimal:false),
                  ),
                ),
                SizedBox(width:10),
                Expanded(
                  child: TextField(
                    controller:_weightController,
                    decoration:
                        InputDecoration(labelText:'Weight (kg)', hintText:'e.g.20'), // This should display the previous weight PR 
                    keyboardType:
                        TextInputType.numberWithOptions(decimal:true),
                  ),
                ),
              ],
            ),
            SizedBox(height :10),
            ElevatedButton(
              onPressed:_addExercise,
              child :Text('Add Exercise')
            ),
            Expanded(
              child : ListView.builder(
                itemCount:_exercises.length,
                itemBuilder:(context,index){
                  return Card(child:
                  ListTile(title:
                  Text('${_exercises[index].name}: ${_exercises[index].sets} sets x ${_exercises[index].reps} reps @ ${_exercises[index].weight} kg')));
                },
              )
            ),
            ElevatedButton(
              onPressed:_saveWorkout,
              child :Text('Finish Workout')
            )
          ],
        ),
      ),
      floatingActionButton:_isRunning ? FloatingActionButton.extended(onPressed:_stopTimer,label :Text('Stop Timer')) :
       FloatingActionButton.extended(onPressed:_startTimer,label :Text('Start Timer')),
    );
  }
}

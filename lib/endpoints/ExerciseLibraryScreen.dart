import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// TODO: Try make this work?? 

class ExerciseLibraryScreen extends StatefulWidget {
  @override
  _ExerciseLibraryScreenState createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  final String _apiEndpointUrl = "https://wger.de/api/v2";
  List _exercises = [];

  Future<void> _loadExercises() async {
    final url = Uri.parse('$_apiEndpointUrl/exercise/?limit=1000'); // This returns literally all exercises of the API 
    final response = await http.get(url);
    print(response.body);  

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _exercises = jsonData['results'];
      });
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Library'),
      ),
      body: _exercises.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_exercises[index]['name']),
                  //subtitle: Text(_exercises[index]['description']),
                );
              },
            ),
    );
  }
}

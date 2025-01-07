import 'package:flutter/material.dart';

class MacronutrientTrackerPage extends StatefulWidget {
  @override
  _MacronutrientTrackerPageState createState() => _MacronutrientTrackerPageState(); }

class _MacronutrientTrackerPageState extends State<MacronutrientTrackerPage> {
  final _formKey = GlobalKey<FormState>();

  String _protein = '';
  String _carbohydrates = '';
  String _fat = '';

  List<Meal> _meals = [];

  void _saveMacronutrients() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the macronutrients to a database or storage
      print('Macronutrients saved:');
      print('Protein: $_protein');
      print('Carbohydrates: $_carbohydrates');
      print('Fat: $_fat');
    }
  }

  void _addMeal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _mealFormKey = GlobalKey<FormState>();
        String _mealName = '';
        String _mealProtein = '';
        String _mealCarbohydrates = '';
        String _mealFat = '';

        return AlertDialog(
          title: Text('Add Meal'),
          content: Form(
            key: _mealFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Meal Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a meal name';
                    }
                    return null;
                  },
                  onSaved: (value) => _mealName = value!,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Protein (g)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) => _mealProtein = value!,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Carbohydrates (g)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) => _mealCarbohydrates = value!,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Fat (g)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) => _mealFat = value!,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_mealFormKey.currentState!.validate()) {
                  _mealFormKey.currentState!.save();
                  _meals.add(Meal(
                    name: _mealName,
                    protein: int.parse(_mealProtein),
                    carbohydrates: int.parse(_mealCarbohydrates),
                    fat: int.parse(_mealFat),
                  ));
                  Navigator.of(context).pop();
                  setState(() {});
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Macronutrient Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_meals[index].name),
                    subtitle: Text(
                      'Protein: ${_meals[index].protein}g, Carbohydrates: ${_meals[index].carbohydrates}g, Fat: ${_meals[index].fat}g',
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addMeal,
              child: Text('Add Meal'),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Protein (g)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    onSaved: (value) => _protein = value!,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Carbohydrates (g)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    onSaved: (value) => _carbohydrates = value!,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Fat (g)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    onSaved: (value) => _fat = value!,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveMacronutrients,
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Meal {
  String name;
  int protein;
  int carbohydrates;
  int fat;

  Meal({required this.name, required this.protein, required this.carbohydrates, required this.fat});
}

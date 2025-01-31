import 'package:better/screens/WorkoutPlan/GenerateWorkoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'routes/app_routes.dart'; // Import your routes
import 'screens/WorkoutPlan/WorkoutListScreen.dart'; 
import 'screens/MacroTrackerScreen/MacroTrackerScreen.dart'; 
import 'endpoints/ExerciseLibraryScreen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onboarding, // Set initial route to OnBoardScreen
      //home: MainApp(), 
      routes: { 
        ...AppRoutes.getRoutes(), 
        '/main': (context) => MainApp(), 
      }

    );
  }
}


// BottomNavigationBar
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    WorkoutListScreen(),   
    ExerciseLibraryScreen(),
    MacronutrientTrackerPage(),
    //add more screens here 
    // Profile Screen 
    // AI Workout Screen 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Exercise Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Macro Tracker',
          ),
          BottomNavigationBarItem(
            //Have not created a profile screen yet 
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

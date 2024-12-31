import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'routes/app_routes.dart'; 

void main() {
  //WidgetsFlutterBinding.ensureInitialized(); //Do I need this?  
  //await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // TODO: Create a NavBar that allows easy routing 

  //Root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black, 
      debugShowCheckedModeBanner: false,
      //title or what not 
      //test for workout screen
      initialRoute: AppRoutes.workoutListScreen, 
      //initialRoute: AppRoutes.onboarding, 
      routes: AppRoutes.getRoutes(), 
    );
  }
}


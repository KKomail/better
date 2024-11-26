import 'package:flutter/material.dart';
import '../screens/OnBoardScreen/OnBoardScreen.dart'; 
import 'routes/app_routes.dart'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black, 
      debugShowCheckedModeBanner: false,
      //title or what not 
      initialRoute: AppRoutes.onboarding, 
      routes: AppRoutes.getRoutes(), 
    );
  }
}

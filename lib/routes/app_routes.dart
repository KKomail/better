import 'package:flutter/material.dart'; 
import '../screens/GenderScreen/GenderScreen.dart'; 
import '../screens/OnBoardScreen/OnBoardScreen.dart'; 

//TODO: 
//Define More Routes 

class AppRoutes { 
  static const String onboarding = '/'; 
  static const String genderScreen = '/GenderScreen'; 

  static Map<String, WidgetBuilder> getRoutes() { 
      return { 
          onboarding: (context) => OnBoardScreen(), 
          genderScreen: (context) => GenderScreen(), 
        }; 
    }
} 

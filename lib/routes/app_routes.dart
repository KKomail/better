import 'package:flutter/material.dart'; 
import '../screens/GenderScreen/GenderScreen.dart'; 
import '../screens/OnBoardScreen/OnBoardScreen.dart'; 
import '../screens/SignUpScreen/SignUpScreen.dart'; 

//TODO: 
//Define More Routes 

class AppRoutes { 
  static const String onboarding = '/'; 
  static const String genderScreen = '/GenderScreen'; 
  static const String signUpScreen = '/SignUpScreen'; 

  static Map<String, WidgetBuilder> getRoutes() { 
      return { 
          onboarding: (context) => OnBoardScreen(), 
          genderScreen: (context) => GenderScreen(), 
          signUpScreen: (context) => SignUpScreen(), 
        }; 
    }
} 

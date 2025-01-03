import 'package:flutter/material.dart'; 
import '../screens/GenderScreen/GenderScreen.dart'; 
import '../screens/OnBoardScreen/OnBoardScreen.dart'; 
import '../screens/SignUpScreen/SignUpScreen.dart'; 
import '../screens/WorkoutPlan/WorkoutListScreen.dart'; 

//TODO: Define More Routes  

class AppRoutes { 
  //This goes to the home page(onboarding screen) 
  static const String onboarding = '/'; 
  //This goes to gender Select screen (for set up profile) 
  static const String genderScreen = '/GenderScreen'; // Do I need this? Wldnt it be better to just create a profile customization page?  
  //This goes to Google Sign in 
  static const String signUpScreen = '/SignUpScreen'; 
  //WorkoutListScreen
  static const String workoutListScreen = '/WorkoutListScreen'; 

  static Map<String, WidgetBuilder> getRoutes() { 
      return { 
          onboarding: (context) => const OnBoardScreen(), 
          genderScreen: (context) => const GenderScreen(), 
          //signUpScreen: (context) => const SignUpScreen(), 
          workoutListScreen: (context) => WorkoutListScreen(), 
        }; 
    }
} 

import 'package:flutter/material.dart'; 
import '../screens/GenderScreen/GenderScreen.dart'; 
import '../screens/OnBoardScreen/OnBoardScreen.dart'; 
import '../screens/WorkoutPlan/WorkoutListScreen.dart'; 
import '../endpoints/ExerciseLibraryScreen.dart'; 
import '../screens/MacroTrackerScreen/MacroTrackerScreen.dart'; 

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
  //Exercise Library Screen (RESTAPI) 
  static const String exerciseLibrary = '/ExerciseLibraryScreen'; 
  //MacroNutrientTracker Screen 
  static const String macroTracker = '/MacroTrackerScreen'; 

  static Map<String, WidgetBuilder> getRoutes() { 
      return { 
          onboarding: (context) => const OnBoardScreen(), 
          genderScreen: (context) => const GenderScreen(), 
          //signUpScreen: (context) => const SignUpScreen(), 
          workoutListScreen: (context) => WorkoutListScreen(), 
          exerciseLibrary: (context) => ExerciseLibraryScreen(), 
          macroTracker: (context) => MacronutrientTrackerPage(), 
        }; 
    }
} 

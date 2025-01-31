import 'package:flutter/material.dart'; 
import '../screens/GenderScreen/GenderScreen.dart'; 
import '../screens/OnBoardScreen/OnBoardScreen.dart'; 
import '../screens/WorkoutPlan/WorkoutListScreen.dart'; 
import '../endpoints/ExerciseLibraryScreen.dart'; 
import '../screens/MacroTrackerScreen/MacroTrackerScreen.dart'; 
import '../screens/WorkoutPlan/GenerateWorkoutScreen.dart'; // AI screen 

class AppRoutes { 
  // Only the initial route if user is not logged in? 
  static const String onboarding = '/onboarding';  

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

  static const String generateWorkout = '/GenerateWorkoutScreen'; 

  static Map<String, WidgetBuilder> getRoutes() { 
      return { 
          onboarding: (context) => const OnBoardScreen(), 
          genderScreen: (context) => const GenderScreen(), 
          //signUpScreen: (context) => const SignUpScreen(), 
          workoutListScreen: (context) => WorkoutListScreen(), 
          exerciseLibrary: (context) => ExerciseLibraryScreen(), 
          macroTracker: (context) => MacronutrientTrackerPage(), 
          generateWorkout: (context) => GenerateWorkoutScreen(), 
        }; 
    }
} 

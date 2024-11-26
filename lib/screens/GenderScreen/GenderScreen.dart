import "package:flutter/material.dart"; 

class GenderScreen extends StatefulWidget { 
  const GenderScreen({super.key}); 

  @override 
  State<GenderScreen> createState() => _GenderScreenState(); 
}

class _GenderScreenState extends State<GenderScreen> { 
  String? selectedGender; // Variable to hold the selected gender

  @override 
  Widget build(BuildContext context) { 
    var size = MediaQuery.of(context).size; 
    return Scaffold( 
      backgroundColor: Colors.black, 
      body: Container( 
        width: size.width, 
        height: size.height, 
        padding: const EdgeInsets.all(20.0), 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
            Text( 
              'Select Your Gender', 
              style: TextStyle( 
                color: Colors.white, 
                fontSize: 24, 
                fontWeight: FontWeight.bold 
              ), 
            ), 
            SizedBox(height: 20), 
            RadioListTile<String>( 
              title: const Text('Male', style: TextStyle(color: Colors.white)), 
              value: 'Male', 
              groupValue: selectedGender, 
              onChanged: (value) { 
                setState(() { 
                  selectedGender = value; 
                }); 
              }, 
              activeColor: Colors.blue, 
            ), 
            RadioListTile<String>( 
              title: const Text('Female', style: TextStyle(color: Colors.white)), 
              value: 'Female', 
              groupValue: selectedGender, 
              onChanged: (value) { 
                setState(() { 
                  selectedGender = value; 
                }); 
              }, 
              activeColor: Colors.blue, 
            ), 
            RadioListTile<String>( 
              title: const Text('Other', style: TextStyle(color: Colors.white)), 
              value: 'Other', 
              groupValue: selectedGender, 
              onChanged: (value) { 
                setState(() { 
                  selectedGender = value; 
                }); 
              }, 
              activeColor: Colors.blue, 
            ), 
            SizedBox(height: 40), 
            ElevatedButton( 
              onPressed: () { 
                // Handle the next action, e.g., save the selected gender
                print('Selected Gender: $selectedGender'); 
              }, 
              child: const Text('Continue'), 
              style: ElevatedButton.styleFrom( 
                backgroundColor: Colors.blue, 
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), 
              ), 
            ), 
          ], 
        ), 
      ), 
    ); 
  }
}

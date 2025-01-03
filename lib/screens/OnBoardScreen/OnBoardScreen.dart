import "package:flutter/material.dart";
import 'package:better/routes/app_routes.dart'; 


class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/fypImages/arnold.jpg',
      'title': 'Welcome to Better!',
      'description':
          'Discover a healthier, happier you. Our app is designed to guide you on your fitness journey.'
    },
    {
      'image': 'assets/fypImages/fua.jpg',
      'title': 'Personalized Workouts',
      'description':
          'Get tailored workout plans that fit your goals and lifestyle.'
    },
    {
      'image': 'assets/fypImages/22.jpg',
      'title': 'Track Your Progress',
      'description':
          'Stay motivated by tracking your workouts, nutrition, and achievements.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _pageIndicator(
                imageAsset: _pages[index]['image']!,
                title: _pages[index]['title']!,
                description: _pages[index]['description']!,
              );
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pages.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                // Get Started Button only on the last page
                if (_currentPage == _pages.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the main app or home screen
                      // TODO: define routes before creating a navigator 
                      // TODO: Create a page in the routes folder that creates certain routes 
                      // for navigation 
                      Navigator.pushReplacementNamed(context, AppRoutes.workoutListScreen); 
                    },  
                    child: const Text('Get Started'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageIndicator(
      {required String imageAsset,
      required String title,
      required String description}) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(imageAsset,
            height: size.height, width: size.width, fit: BoxFit.cover),
        Positioned(
          bottom: size.height * 0.2,
          left: size.width * 0.1,
          right: size.width * 0.1, // Added to limit width
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  Colors.black.withOpacity(0.7), // Semi-transparent black box
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with Outline Effect
                Stack(
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                // Description with Constraints
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  maxLines: 3, // Limit lines to avoid overflow
                  overflow:
                      TextOverflow.ellipsis, // Add ellipsis if text overflows
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

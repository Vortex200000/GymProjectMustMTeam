import 'package:flutter/material.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
part './screens/moplile_screen.dart';

class TrainingLayout extends StatelessWidget {
  const TrainingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xff232323);
    final Color primaryColor = Color(0xffb3a0ff);
    final Color accentColor = Color(0xffd6e45f);
    return Scaffold(
      backgroundColor: bgColor,
      body: const AdaptivLayoutWidget(
        mobileScreem: _MopileScreen(),
        tabletScreen: _MopileScreen(),
        desktopScreen: _MopileScreen(),
      ),
    );
  }
}

class WorkoutScreen extends StatelessWidget {
  final String userGoal;

  WorkoutScreen({required this.userGoal});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xff232323);
    final Color primaryColor = Color(0xffb3a0ff);
    final Color accentColor = Color(0xffd6e45f);

    // Example workouts based on goal
    final List<Map<String, String>> workouts = getWorkoutsForGoal(userGoal);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          'Your Workouts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Goal Tag
            Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Goal: $userGoal',
                style:
                    TextStyle(color: accentColor, fontWeight: FontWeight.w600),
              ),
            ),

            // Workout List
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primaryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        // Icon or image
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.fitness_center,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: 16),
                        // Text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workout['title']!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              workout['subtitle']!,
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> getWorkoutsForGoal(String goal) {
    switch (goal.toLowerCase()) {
      case 'weight loss':
        return [
          {'title': 'HIIT Cardio', 'subtitle': '30 mins high intensity'},
          {'title': 'Jump Rope', 'subtitle': '15 mins fat burner'},
          {'title': 'Mountain Climbers', 'subtitle': '3 sets x 1 min'},
        ];
      case 'muscle gain':
        return [
          {'title': 'Push Day', 'subtitle': 'Chest, Shoulders, Triceps'},
          {'title': 'Pull Day', 'subtitle': 'Back, Biceps'},
          {'title': 'Leg Day', 'subtitle': 'Squats, Deadlifts'},
        ];
      default:
        return [
          {'title': 'Full Body Circuit', 'subtitle': 'Balance and strength'},
          {'title': 'Yoga', 'subtitle': 'Flexibility and recovery'},
        ];
    }
  }
}

// import 'package:flutter/material.dart';
// import 'ui/screens/ride_pref/ride_prefs_screen.dart';
// import 'ui/theme/theme.dart';

// void main() {
//   runApp(const BlaBlaApp());
// }

// class BlaBlaApp extends StatelessWidget {
//   const BlaBlaApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: blaTheme,
//       home: Scaffold(body: RidePrefsScreen()),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // --- SERVICES (Models/Logic) ---
// class StudentsService {
//   String getStudents() => "Students loaded";
// }

// class CourseService {
//   String getCourses() => "Courses loaded";
// }

// class GradesService {
//   String getGrades() => "Grades loaded";
// }

// // --- MAIN ---

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         Provider<StudentsService>(create: (_) => StudentsService()),
//         Provider<CourseService>(create: (_) => CourseService()),
//         Provider<GradesService>(create: (_) => GradesService()),
//       ],
//       child: const MaterialApp(home: App()),
//     ),
//   );
// }

// // --- UI ---

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("School App - MultiProvider")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             StudentsScreen(),
//             CoursesScreen(),
//             GradesScreen(),
//             SettingsScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StudentsScreen extends StatelessWidget {
//   const StudentsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final data = context.read<StudentsService>().getStudents();

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text("StudentsScreen → $data"),
//     );
//   }
// }

// class CoursesScreen extends StatelessWidget {
//   const CoursesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final data = context.read<CourseService>().getCourses();

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text("CoursesScreen → $data"),
//     );
//   }
// }

// class GradesScreen extends StatelessWidget {
//   const GradesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final grades = context.read<GradesService>().getGrades();
//     final students = context.read<StudentsService>().getStudents();
//     final courses = context.read<CourseService>().getCourses();

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         "GradesScreen → $grades\n(Context: $students & $courses)",
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Text("Settings Screen (No services needed)"),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ColorType {
  red(color: Colors.red),
  blue(color: Colors.blue);

  final Color color;
  const ColorType({required this.color});
}

// NOTIFIER
class ColorTapsNotifier extends ChangeNotifier {
  int _redTapCount = 0;
  int _blueTapCount = 0;

  int get redTapCount => _redTapCount;
  int get blueTapCount => _blueTapCount;

  void increment(ColorType type) {
    if (type == ColorType.red) {
      _redTapCount++;
    } else {
      _blueTapCount++;
    }
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ColorTapsNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? const ColorTapsScreen()
          : const StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.touch_app), label: 'Taps'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tapNotifer = context.watch<ColorTapsNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(
            type: ColorType.red,
            tapCount: tapNotifer.redTapCount,
            onTap: () =>
                context.read<ColorTapsNotifier>().increment(ColorType.red),
          ),
          ColorTap(
            type: ColorType.blue,
            tapCount: tapNotifer.blueTapCount,
            onTap: () =>
                context.read<ColorTapsNotifier>().increment(ColorType.blue),
          ),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final ColorType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: type.color,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tapNotifier = context.read<ColorTapsNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Red Taps: ${tapNotifier.redTapCount}',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              'Blue Taps: ${tapNotifier.blueTapCount}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

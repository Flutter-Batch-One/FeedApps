import 'package:flutter/material.dart';
import 'package:mini_project_one/views/screens/detail_screen.dart';
import 'package:mini_project_one/views/screens/home_screen.dart';

void main() {
  runApp(const MiniSocailApp());
}

class MiniSocailApp extends StatelessWidget {
  const MiniSocailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/details":
            return MaterialPageRoute(
                builder: (context) => const DetailScreen());

          default:
            return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mini_project_one/views/screens/detail_screen.dart';
import 'package:mini_project_one/views/screens/home_screen.dart';
import 'package:mini_project_one/views/screens/not_found_screen.dart';
import 'package:mini_project_one/views/screens/photo_view_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        print(settings.name);
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
              settings: settings,
            );
          case "/details":
            return MaterialPageRoute(
              builder: (context) => const DetailScreen(),
              settings: settings,
            );
          case "/view":
            return MaterialPageRoute(
              builder: (_) => PhotoViewScreen(),
              settings: settings,
            );
          default:
            return MaterialPageRoute(
              builder: (_) => NotFoundScreen(),
              settings: settings,
            );
        }
      },
    );
  }
}

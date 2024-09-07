import 'package:app/features/camera_screen.dart';
import 'package:app/features/homepage_screen.dart';
import 'package:app/features/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set up GoRouter configuration
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => UVIndexScreen()),
        GoRoute(path: '/camera', builder: (context, state) => CameraScreen()),
        GoRoute(path: '/report', builder: (context, state) => ReportScreen()),
      ],
    );

    return MaterialApp.router(
      routerConfig: _router, // Use routerConfig instead of initialRoute
      title: 'UV Index App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

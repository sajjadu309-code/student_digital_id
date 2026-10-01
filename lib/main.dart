import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

void main() {
  runApp(const StudentIdApp());
}

class StudentIdApp extends StatelessWidget {
  const StudentIdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Digital ID',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF3949AB),
      ),
      home: const DashboardScreen(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/screens/getAll_priorities.dart';
import 'package:firebase_practice/screens/getall_Task.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetallPriorities(),
    );
  }
}

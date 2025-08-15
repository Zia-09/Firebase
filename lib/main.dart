import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/providers/userProviders.dart';
import 'package:firebase_practice/screens/getall_Task.dart';
import 'package:firebase_practice/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Userproviders())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SigninScreen());
  }
}

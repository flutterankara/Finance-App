import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/screens/login.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

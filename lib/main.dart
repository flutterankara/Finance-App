import 'package:app/core/app/controllers/app_controller.dart';
import 'package:app/coreWidgets/main_layout.dart';
import 'package:app/screens/accounts/accounts_page.dart';
import 'package:app/screens/home.dart';
import 'package:app/firebase_options.dart';
import 'package:app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/savings.dart';
import 'package:app/screens/reporst.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return MainLayout();
            } else {
              return const LoginScreen();
            }
          }),
        ),
      ),
    );
  }
}

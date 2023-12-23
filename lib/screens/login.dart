import 'package:app/forms/login_form.dart';
import 'package:app/forms/signup_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool _isLogin = true;

  void _changeForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget form = (_isLogin)
        ? LoginForm(changeForm: _changeForm)
        : SignupForm(changeForm: _changeForm);
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                width: 200,
                child: Icon(
                  Icons.exit_to_app,
                  size: 200,
                  color: Colors.blue.withOpacity(0.4),
                ),
              ),
              Card(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: form,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

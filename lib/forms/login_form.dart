import 'package:app/core/app/controllers/app_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.changeForm});
  final void Function() changeForm;

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  bool _isAuthenticating = false;
  String _enteredEmail = "";
  String _enteredPassword = "";

  void _databaseFailMsg(String errText) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errText)),
    );
  }

  void _onSubmit() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    setState(() {
      _isAuthenticating = true;
    });
    formKey.currentState!.save();

    await context
        .read<AppController>()
        .login(email: _enteredEmail, password: _enteredPassword);

    setState(() {
      _isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Email"),
            ),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            validator: (value) {
              if (value == null ||
                  !value.contains("@") ||
                  value.split("@")[0].trim().isEmpty ||
                  value.split("@")[1].trim().isEmpty) {
                return "Enter a valid mail address";
              }
              return null;
            },
            onSaved: (newValue) {
              _enteredEmail = newValue!.trim();
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Password"),
            ),
            obscureText: true,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.trim().length < 6) {
                return "Enter at least 6 character";
              }
              return null;
            },
            onSaved: (newValue) {
              _enteredPassword = newValue!;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          if (_isAuthenticating) const CircularProgressIndicator(),
          if (!_isAuthenticating)
            ElevatedButton(
              onPressed: _onSubmit,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  backgroundColor: Theme.of(context).colorScheme.secondary),
              child: const Text("Login"),
            ),
          if (!_isAuthenticating)
            TextButton(
              onPressed: widget.changeForm,
              child: Text(
                "Create an account",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

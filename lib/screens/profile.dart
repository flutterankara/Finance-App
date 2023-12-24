import 'package:app/core/app/controllers/app_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppController>().user!;
    final mediaSize = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        children: [
          const SizedBox(
            height: 128,
          ),
          ProfileField(title: 'İsim', value: user.name ?? ''),
          ProfileField(title: 'Email', value: user.email),
          ProfileField(
            title: 'Yaş',
            value: user.age.toString(),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text(
              'Çıkış',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
          const SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  const ProfileField({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
        ),
      ],
    );
  }
}

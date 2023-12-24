import 'dart:ffi';

import 'package:app/screens/home.dart';
import 'package:app/screens/profile/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late var id;
  late final info;

  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    id = FirebaseAuth.instance.currentUser!.uid;
    getValue();
  }

  Future<void> getValue() async {
    info = await FirebaseFirestore.instance.doc("Users/" + id).get();
    setState(() {});
  }

  // Firebase'den gelecek
  // String name = info["name"];
  // String surname = "Deniz";
  // String email = "ahmetdeniz@hotmail.com";

  // Şifre güncelleme için yeni bir metot
  void _changePassword() {
    // Burada şifre güncelleme işlemleri gerçekleştirilebilir.
    // Örnek:
    // AuthService().changePassword();
    // Şifre güncelleme işlemleri burada yapılacak
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen()), // HomeScreen'e gitmek için
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 50,
              // backgroundImage: AssetImage(""), // Firebase'den gelecek
            ),
            const SizedBox(height: 15),
            Text(
              "Welcome ${info["email"]}", // firebaseden gelecek
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileInfo(Icons.person, 'Name', info["email"]),
            // _buildProfileInfo(Icons.person, 'Surname', info["username"]),
            _buildProfileInfo(Icons.email, 'E-mail', info["username"]),
            _buildProfileAction(Icons.lock, 'Change Password', _changePassword),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditProfileScreen()), // HomeScreen'e gitmek için
                  );
                  // );
                },
                child: Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAction(
      IconData icon, String label, Function() onPressed) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onPressed,
    );
  }
}

ListTile _buildProfileInfo(IconData icon, String label, String value) {
  return ListTile(
    leading: Icon(icon),
    title: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(value),
  );
}

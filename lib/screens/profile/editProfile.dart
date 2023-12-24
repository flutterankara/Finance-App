import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late var id;
  late var info;
  late TextEditingController txt1;
  late TextEditingController txt2;
  @override
  void initState() {
    super.initState();
    id = FirebaseAuth.instance.currentUser?.uid;
    txt1 = TextEditingController();
    txt2 = TextEditingController();
    getValue();
  }

  Future<void> getValue() async {
    info = await FirebaseFirestore.instance.doc("Users/" + id).get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // controller: txt1,
              initialValue: info["email"],
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              // controller: txt2,

              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.doc("Users/" + id).set({
                  "name": txt1.text,
                  "email": txt2.text,
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

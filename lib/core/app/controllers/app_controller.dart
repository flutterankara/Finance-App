import 'package:app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  UserModel? _user;
  UserModel? get user => _user;

  Future<void> getUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final db = FirebaseFirestore.instance;
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await db.collection('Users').doc(uid).get();
      _user = UserModel.fromMap(userDoc.data()!);
      print('User fetched..');
      print(user!.accounts);
      notifyListeners();
    }
  }

  void setUser({required UserModel userModel}) {
    _user = userModel;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final db = FirebaseFirestore.instance;
      final querySnapshot =
          await db.collection('Users').where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        throw FirebaseAuthException(code: '403');
      }
      final user = querySnapshot.docs.first.data();
      _user = UserModel(
        name: user['name'],
        age: user['age'] ?? 18,
        email: email,
      );

      _isLoggedIn = true;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      print("Signin Fail: $error");
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userInfo = <String, dynamic>{
      "username": email,
      "email": password,
      "debt":[],
      "income":[]
    };

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.user!.uid)
        .set(userInfo);

    final db = FirebaseFirestore.instance;
    final querySnapshot =
        await db.collection('Users').where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isEmpty) {
      throw FirebaseAuthException(code: '403');
    }
    final userResponse = querySnapshot.docs.first;
    if (querySnapshot.docs.isEmpty) {
      throw FirebaseAuthException(code: '403');
    }
    final userData = querySnapshot.docs.first.data();
    _user = UserModel(
      name: userData['username'],
      age: userData['age'] ?? 18,
      email: email,
    );
    _isLoggedIn = true;
    notifyListeners();
  }
}

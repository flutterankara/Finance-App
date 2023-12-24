import 'package:app/models/account_model.dart';
import 'package:app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPageController extends ChangeNotifier {
  AccountPageController({required this.accounts});
  List<AccountModel> accounts = [];

  Future<UserModel> addAccount({
    required AccountModel model,
    required UserModel userModel,
  }) async {
    accounts.add(model);
    final newUserModel = userModel.copyWith(
      accounts: [...userModel.accounts, model],
    );
    final db = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await db.collection('Users').doc(uid).set(newUserModel.toMap());
    notifyListeners();
    return newUserModel;
  }
}

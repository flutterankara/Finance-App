import 'package:app/models/account_model.dart';
import 'package:app/models/user_model.dart';
import 'package:flutter/material.dart';

class AccountPageController extends ChangeNotifier {
  List<AccountModel> accounts = [];

  void addAccount({
    required AccountModel model,
    required UserModel userModel,
  }) {
    accounts.add(model);
    userModel.accounts.add(model);
    notifyListeners();
  }
}

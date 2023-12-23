import 'package:app/models/account_model.dart';
import 'package:flutter/material.dart';

class AccountPageController extends ChangeNotifier {
  List<AccountModel> accounts = [];

  void addAccount({
    required AccountModel model,
  }) {
    accounts.add(model);
    notifyListeners();
  }
}

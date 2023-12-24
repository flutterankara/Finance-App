import 'dart:convert';

import 'package:app/models/account_model.dart';

class UserModel {
  final String name;
  final int age;
  final List<int> incomeList;
  final List<int> debtList;
  final List<AccountModel> accounts;
  UserModel({
    required this.name,
    required this.age,
    this.incomeList = const [],
    this.debtList = const [],
    this.accounts = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'incomeList': incomeList,
      'debtList': debtList,
      'accounts': accounts.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      incomeList: List<int>.from(map['incomeList']),
      debtList: List<int>.from(map['debtList']),
      accounts: List<AccountModel>.from(
          map['accounts']?.map((x) => AccountModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

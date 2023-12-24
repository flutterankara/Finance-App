import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:app/models/account_model.dart';

class UserModel {
  final String? name;
  final String email;
  final int age;
  final List<int> incomeList;
  final List<int> debtList;
  final List<AccountModel> accounts;
  UserModel({
    required this.name,
    required this.email,
    required this.age,
    this.incomeList = const [],
    this.debtList = const [],
    this.accounts = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'incomeList': incomeList,
      'debtList': debtList,
      'accounts': accounts?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'] ?? '',
      age: map['age']?.toInt() ?? 0,
      incomeList:
          map['incomeList'] != null ? List<int>.from(map['incomeList']) : [],
      debtList: map['debtList'] != null ? List<int>.from(map['debtList']) : [],
      accounts: map['accounts'] != null
          ? List<AccountModel>.from(
              map['accounts']?.map((x) => AccountModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    ValueGetter<String?>? name,
    String? email,
    int? age,
    List<int>? incomeList,
    List<int>? debtList,
    List<AccountModel>? accounts,
  }) {
    return UserModel(
      name: name?.call() ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      incomeList: incomeList ?? this.incomeList,
      debtList: debtList ?? this.debtList,
      accounts: accounts ?? this.accounts,
    );
  }
}

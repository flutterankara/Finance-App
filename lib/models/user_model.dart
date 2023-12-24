import 'dart:convert';

import 'package:app/models/account_model.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    this.accounts = const [],
  });

  final int id;
  final String name;
  final String surname;
  final int age;
  final List<AccountModel> accounts;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'age': age,
      'accounts': accounts.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      age: map['age']?.toInt() ?? 0,
      accounts: List<AccountModel>.from(
          map['accounts']?.map((x) => AccountModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

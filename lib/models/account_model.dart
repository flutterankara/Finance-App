import 'dart:convert';

class AccountModel {
  final String title;

  AccountModel({
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source));
}

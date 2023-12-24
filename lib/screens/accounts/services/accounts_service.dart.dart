import 'package:app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountsService {
  Future addAccount({
    required String title,
    required UserModel userModel,
  }) async {
    final db = FirebaseFirestore.instance;
  }
}

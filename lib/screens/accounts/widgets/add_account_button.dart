import 'package:app/core/app/controllers/app_controller.dart';
import 'package:app/models/account_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/accounts/controllers/accounts_page_controller.dart';
import 'package:app/screens/accounts/widgets/add_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAccountButton extends StatelessWidget {
  const AddAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.greenAccent,
      onPressed: () async {
        final result = await showDialog<String?>(
          context: context,
          builder: (context) {
            return const AddAccountDialog();
          },
        );

        if (result != null && context.mounted) {
          final user = context.read<AppController>().user!;
          final newUser =
              await context.read<AccountPageController>().addAccount(
                    model: AccountModel(title: result),
                    userModel: user,
                  );
          if (context.mounted) {
            context.read<AppController>().setUser(userModel: newUser);
          }
        }
      },
      child: const Icon(Icons.add),
    );
  }
}

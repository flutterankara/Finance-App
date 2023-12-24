import 'dart:math';

import 'package:app/core/app/controllers/app_controller.dart';
import 'package:app/screens/accounts/controllers/accounts_page_controller.dart';
import 'package:app/screens/accounts/widgets/account_dashboard_card.dart';
import 'package:app/screens/accounts/widgets/add_account_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AccountPageController(
              accounts: context.read<AppController>().user!.accounts,
            ),
        builder: (context, _) {
          return Builder(builder: (context) {
            final controller = context.watch<AccountPageController>();
            return Scaffold(
              appBar: AppBar(
                title: const Text('Hesaplar'),
                centerTitle: true,
              ),
              floatingActionButton: const AddAccountButton(),
              body: ListView(
                padding: const EdgeInsets.all(12),
                children: List.generate(
                  controller.accounts.length,
                  (index) => Column(
                    children: [
                      AccountDashboardCard(
                        title: controller.accounts[index].title,
                        color: Colors.grey.shade100,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}

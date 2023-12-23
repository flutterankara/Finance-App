import 'package:flutter/material.dart';

/// Account page'indeki dashboard cardları
class AccountDashboardCard extends StatelessWidget {
  const AccountDashboardCard({
    super.key,
    required this.title,
    this.color = Colors.grey,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width,
      height: mediaSize.width / 2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
        ],
      ),
    );
  }
}

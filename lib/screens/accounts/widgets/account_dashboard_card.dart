import 'dart:math';

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
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _DashboardField(
                  title: 'Gelir',
                  value: Random().nextInt(9999),
                  color: Colors.greenAccent,
                ),
                _DashboardField(
                  title: 'Gider',
                  value: Random().nextInt(9999),
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardField extends StatelessWidget {
  const _DashboardField({
    super.key,
    required this.title,
    required this.value,
    this.color = Colors.black,
  });

  final String title;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}

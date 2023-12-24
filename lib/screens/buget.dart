import 'package:app/coreWidgets/reportAndMain.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _Budget();
}

List _elements = [
  {'name': 'income', 'group': 'Income'},
  {'name': 'income', 'group': 'Income'},
  {'name': 'expense', 'group': 'Expense'},
  {'name': 'expense', 'group': 'Expense'},
];

class _Budget extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 200, // Set this height
          flexibleSpace: Container(
            color: Colors.deepPurple,
            child: const Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Budget",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Left Budget",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Para",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        body: GroupedListView<dynamic, String>(
            elements: _elements,
            groupBy: (element) => element['group'],
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1['name'].compareTo(item2['name']),
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
            itemBuilder: (c, element) {
              return test(element['name']);
            }));
  }
}

Column test(String element) {
  if (element == "income") {
    return Column(
      children: [
        ReportAndMain(
            amount: 45.00,
            type: " TL",
            date: DateTime(2023, 11, 11),
            InOrOut: true),
      ],
    );
  } else {
    return Column(
      children: [
        ReportAndMain(
            amount: 45.00,
            type: " TL",
            date: DateTime(2023, 11, 11),
            InOrOut: false),
      ],
    );
  }
}

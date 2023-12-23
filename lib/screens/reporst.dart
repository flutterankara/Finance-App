import 'package:app/coreWidgets/reportAndMain.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Map<String,dynamic> deneme = {}; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.chevron_left,size: 35,)),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height/3,
            child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              sections: [
                PieChartSectionData(value: 12,color: Colors.green),
                PieChartSectionData(value: 70,color: Colors.red),
              ]
            ),swapAnimationDuration: Duration(milliseconds: 10),swapAnimationCurve: Curves.bounceOut,),
          ),
          Expanded(
            child: ListView(
              children: [
                ReportAndMain(InOrOut: true,amount: 50,date: DateTime(2002,12,31),type: "\$"),
                ReportAndMain(InOrOut: true,amount: 100,date: DateTime(2002,12,31),type: "\$"),
                ReportAndMain(InOrOut: false,amount: 100,date: DateTime(2002,12,31),type: "\$"),
                ReportAndMain(InOrOut: true,amount: 500,date: DateTime(2002,12,31),type: "\$"),
                ReportAndMain(InOrOut: true,amount: 400,date: DateTime(2002,12,31),type: "\$"),
                ReportAndMain(InOrOut: false,amount: 100,date: DateTime(2002,12,31),type: "\$"),
                ReportAndMain(InOrOut: true,amount: 100,date: DateTime(2002,12,31),type: "\$"),
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
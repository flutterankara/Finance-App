import 'package:app/coreWidgets/reportAndMain.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        centerTitle: true,
        leading: Icon(Icons.chevron_left,size: 35,),
      ),
      body: Center(
        child: ReportAndMain(amount: 100,type:"\$",date: DateTime(2002,04,12),InOrOut: true ),
      ),
    );
  }
}
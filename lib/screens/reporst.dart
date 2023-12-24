import 'package:app/coreWidgets/reportAndMain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late final info;
  var id;
  late FirebaseFirestore firestorage;

  @override
  void initState() {
    super.initState();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    id = firebaseAuth.currentUser!.uid;
    firestorage = FirebaseFirestore.instance;
    getValue();
  }

  Future<void> getValue() async {
    info = await firestorage.doc("Users/"+id).get();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> income = info["income"];
    List<dynamic> debt = info["debt"];
    double total = 0;
    double total2 = 0;
    for(int i in income){
      total+=i;
    }
    for(int j in debt){
      total2+=j;
    }
    income.addAll(debt);
    int toplam = income.length;
    int gelen = income.length;
    int gider = debt.length;
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Rapor"),
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
                PieChartSectionData(value: total2,color: Colors.green),
                PieChartSectionData(value: total,color: Colors.red),
              ]
            ),swapAnimationDuration: Duration(milliseconds: 10),swapAnimationCurve: Curves.bounceOut,),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:toplam,
              itemBuilder: (BuildContext context, int index) {
                return ReportAndMain(amount: income[index], type: "\$", date: DateTime(2002), InOrOut: true);
              },
              
                

                // ReportAndMain(InOrOut: true,amount: 50,date: DateTime(2002,12,31),type: "\$"),
                // ReportAndMain(InOrOut: true,amount: 100,date: DateTime(2002,12,31),type: "\$"),
                // ReportAndMain(InOrOut: false,amount: 100,date: DateTime(2002,12,31),type: "\$"),
                // ReportAndMain(InOrOut: true,amount: 500,date: DateTime(2002,12,31),type: "\$"),
                // ReportAndMain(InOrOut: true,amount: 400,date: DateTime(2002,12,31),type: "\$"),
                // ReportAndMain(InOrOut: false,amount: 100,date: DateTime(2002,12,31),type: "\$"),
              
            ),
          )
          
        ],
      ),
    );
  }
}
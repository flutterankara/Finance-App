import 'package:flutter/material.dart';

class ReportAndMain extends StatelessWidget {
  final amount;
  final String type;
  final DateTime date;
  final bool InOrOut;

  const ReportAndMain({super.key,required this.amount, required this.type, required this.date, required this.InOrOut});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.pink.shade100
        ),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Row(
          children: [
            Container(
              child: Center(
                child: InOrOut ? Icon(Icons.attach_money_outlined,size: 40,color: Colors.green,) : Icon(Icons.money_off,size: 40,color: Colors.red,) 
              ),
              margin: EdgeInsets.only(right: 10),
              height: 100,
              width: 100,
              decoration:BoxDecoration(
                color: InOrOut ? Colors.green.shade100:Colors.red.shade200,
                borderRadius: BorderRadius.circular(11)
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Salary"),
                  Text(date.day.toString()+"-"+date.month.toString()+"-"+date.year.toString()),
                ],
              ),
            ),
            Text(amount.toString()+type,style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            )),
            SizedBox(
              width: 10,
            )
          ],
        )
      ),
    );
  }
}
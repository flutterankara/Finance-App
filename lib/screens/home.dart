import 'package:flutter/material.dart';
import 'package:app/coreWidgets/reportAndMain.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finans App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Finans App '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: _getDrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTotalBalanceBlock(
              totalBalance:
                  '15,000 TL', // Buraya gerçek toplam hesap miktarınızı ekleyin
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _buildFinanceBlock(
                    title: 'Toplam Borç',
                    amount:
                        '56,000 TL', // Buraya gerçek borç miktarınızı ekleyin
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: _buildFinanceBlock(
                    title: 'Toplam Alacak',
                    amount:
                        '10,000 TL', // Buraya gerçek alacak miktarınızı ekleyin
                    color: Colors.green,
                  ),
                )
              ],
            ),
            ReportAndMain(
                amount: 45.00,
                type: " TL",
                date: DateTime(2023, 11, 11),
                InOrOut: false),
            ReportAndMain(
                amount: 45.00,
                type: " TL",
                date: DateTime(2023, 11, 11),
                InOrOut: true),

            //Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //   _buildTransactionRow(
            //     icon: Icons.arrow_upward,
            //     description: 'Para Girişi',
            //     date: '16 Ocak 2023',
            //     amount: '+1000 TL',
            //   ),
            // ]),
          ],
        ),
      ),
    );
  }
}

Widget _buildTotalBalanceBlock({
  required String totalBalance,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Toplam Varlık',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          totalBalance,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFinanceBlock({
  required String title,
  required String amount,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    //width: double.infinity,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          amount,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTransactionRow({
  required IconData icon,
  required String description,
  required String date,
  required String amount,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon,
            color: icon == Icons.arrow_downward ? Colors.red : Colors.green),
        SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(date),
          ],
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: icon == Icons.arrow_downward ? Colors.red : Colors.green,
          ),
        ),
      ],
    ),
  );
}

Widget _getDrawerMenu() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Menü',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: Text('Ana Sayfa'),
          onTap: () {},
        ),
        ListTile(
          title: Text('İşlem Geçmişi'),
          onTap: () {},
        ),
      ],
    ),
  );
}

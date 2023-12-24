import 'package:app/screens/finance/status_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Masraflar')),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Ekle'),
            Tab(text: 'Listele'),
            Tab(text: 'Borç'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GelirSayfasi(),
          GiderSayfasi(),
          BorcSayfasi(),
        ],
      ),
    );
  }
}

class GelirSayfasi extends StatefulWidget {
  @override
  State<GelirSayfasi> createState() => _GelirSayfasiState();
}

class _GelirSayfasiState extends State<GelirSayfasi> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController _tarihController = TextEditingController();
  TextEditingController _tutarController = TextEditingController();
  TextEditingController _kategoriController = TextEditingController();
  String? _selectedKategori;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _tarihController.text =
            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
      });
  }

  StatusService _statusService = StatusService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => _selectDate(context),
            child: IgnorePointer(
              child: TextFormField(
                controller: _tarihController,
                decoration: InputDecoration(
                  labelText: 'Tarih',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
          TextFormField(
            controller: _tutarController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Tutar (TL)',
              // suffixIcon: Icon(Icons),
            ),
          ),
          DropdownButtonFormField(
            value: _selectedKategori,
            hint: Text('Kategori Seçin'),
            onChanged: (String? value) {
              if (value == null) {
                _selectedKategori = 'ffdof';
              } else {
                setState(() {
                  _selectedKategori = value;
                });
              }
            },
            items: ['Market', 'Eğitim', 'Kira', 'Faturalar']
                .map((kategori) => DropdownMenuItem(
                      value: kategori,
                      child: Text(kategori),
                    ))
                .toList(),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 25),
            child: InkWell(
              onTap: () {
                _statusService
                    .addStatus(_selectedDate, int.parse(_tutarController.text),
                        _selectedKategori ?? '')
                    .then((value) async {
                  var user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    var userDetail = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user.uid);

                    var data = await userDetail.get();
                    (data.data()!['Masraflar'] as List).add(value);
                    await userDetail.set(data.data()!);
                  }
                  showAboutDialog(context: context);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    //color: colorPrimaryShade,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Text(
                    "Ekle",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class GiderSayfasi extends StatefulWidget {
  @override
  State<GiderSayfasi> createState() => _GiderSayfasiState();
}

class _GiderSayfasiState extends State<GiderSayfasi> {
  StatusService _statusService = StatusService();

  ScrollController _scrollController = ScrollController();

  List<Color> color = [
    Color.fromARGB(255, 235, 224, 127),
    const Color.fromARGB(255, 138, 227, 218),
    const Color.fromARGB(255, 147, 196, 236),
    const Color.fromARGB(255, 241, 197, 131),
    const Color.fromARGB(255, 129, 241, 133),
    const Color.fromARGB(255, 216, 212, 212),
    const Color.fromARGB(255, 132, 229, 220),
    const Color.fromARGB(255, 215, 161, 141),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: _statusService.getStatus(),
      builder: (context, snaphot) {
        return !snaphot.hasData
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                body: Scrollbar(
                  thickness: 10,
                  controller: _scrollController,
                  child: ListView.builder(
                      itemCount: snaphot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot mypost = snaphot.data!.docs[index];
                        final year = (mypost['tarih'] as Timestamp).toDate();
                        //veri silmek için
                        Future<void> _showChoiseDialog(BuildContext context) {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text(
                                      "Silmek istediğinize emin misiniz?",
                                      textAlign: TextAlign.center,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    content: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                _statusService
                                                    .removeStatus(mypost.id);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Evet",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Vazgeç",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )));
                              });
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _showChoiseDialog(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 305,
                                decoration: BoxDecoration(
                                    color: //Random().nextInt(color.length)
                                        color[index],
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tarih:\t',
                                                style: TextStyle(
                                                    color: Colors.red.shade900,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${year.day}.${year.month}.${year.year}',
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ]),
                                        SizedBox(height: 5),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tutar:\t',
                                                style: TextStyle(
                                                    color: Colors.red.shade900,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${mypost['tutar']}",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ]),
                                        SizedBox(height: 5),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Kategori:\t',
                                                style: TextStyle(
                                                    color: Colors.red.shade900,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  "${mypost['kategori']}",
                                                  maxLines: null,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
      },
    );
  }
}

class BorcSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Borç Sayfası',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

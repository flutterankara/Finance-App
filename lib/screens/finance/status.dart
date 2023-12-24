import 'package:cloud_firestore/cloud_firestore.dart';

class Masraflar {
  String id;
  DateTime tarih;
  int tutar;
  String kategori;

  Masraflar({
    required this.id,
    required this.tarih,
    required this.tutar,
    required this.kategori,
  });
  factory Masraflar.fromSnopshot(DocumentSnapshot snapshot){
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Masraflar(
      id:snapshot.id,
      tarih: (data['tarih'] as Timestamp).toDate(),
       tutar: data['tutar'] as int,
      kategori: data['kategori'] as String,
    
    );
  }
}

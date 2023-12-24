import 'package:app/service/status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Masraflar> addStatus(
      DateTime tarih, int tutar, String kategori) async {
    var ref = _firestore.collection("Masraflar");

    var documentRef =
        await ref.add({'tarih': tarih, 'tutar': tutar, 'kategori': kategori});
    return Masraflar(
        id: documentRef.id, tarih: tarih, tutar: tutar, kategori: kategori);

  }
  //proje göstermek için
 Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Masraflar").snapshots();

    return ref;
  }

  // proje silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Masraflar").doc(docId).delete();

    return ref;
  }
}
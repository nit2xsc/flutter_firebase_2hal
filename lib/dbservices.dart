
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dataclass.dart';

CollectionReference tblCatatan = FirebaseFirestore.instance.collection("tabelCatatan");

class Database {
  static Stream<QuerySnapshot> getData(String judul) {
    if (judul == "")
      return tblCatatan.snapshots();
    else
      return tblCatatan
      // .where("judulCat",isEqualTo: judul)
      .orderBy("judulCat")
      .startAt([judul]).endAt([judul + '\uf8ff'])
      .snapshots();
  }

  static Future<void> tambahData({required itemCatatan item}) async {
    DocumentReference docRef = tblCatatan.doc(item.itemJudul);

    await docRef
    .set(item.toJson())
    .whenComplete(() => print("data berhasil diinput"))
    .catchError((e) => print(e));
  }

  static Future<void> ubahData({required itemCatatan item}) async {
    DocumentReference docRef = tblCatatan.doc(item.itemJudul);

    await docRef
    .update(item.toJson())
    .whenComplete(() => print("data berhasil di ubah"))
    .catchError((e) => print(e));
  }

  static Future<void> hapusData({required String judulhapus}) async {
    DocumentReference docRef = tblCatatan.doc(judulhapus);

    await docRef
    .delete()
    .whenComplete(() => print("data berhasil di hapus"))
    .catchError((e) => print(e));
  }

}
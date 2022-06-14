// ignore_for_file: prefer_const_constructors, unused_label, empty_statements, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/dataclass.dart';
import 'package:firebase_app/detdata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dbservices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: "FIREBASE CRUD",
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget { 
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _searchText = TextEditingController();

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchText.addListener(onSearch);
    super.initState();
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {
      
    });
    return Database.getData(_searchText.text);
  }

  int _jumlah = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FIREBASE CRUD"),
      ),
      floatingActionButton : FloatingActionButton(
        onPressed: () {
          // _jumlah++;
          // final dtBaru = itemCatatan(itemJudul: _jumlah.toString(), itemIsi: "3334");
          // Database.tambahData(item: dtBaru);
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => detData()));
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon (
          Icons.add,
          color: Colors.white,
          size: 32,
        )
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: Column(
          children: [
            TextField(
              controller: _searchText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue),
                )
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: onSearch(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('ERROR');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        DocumentSnapshot dsData = snapshot.data!.docs[index];
                        String lvJudul = dsData['judulCat'];
                        String lvIsi = dsData['isiCat'];
                        _jumlah = snapshot.data!.docs.length;
                        return ListTile(
                          onTap: () {
                            final dtBaru = itemCatatan(itemJudul: lvJudul, itemIsi: lvIsi);
                            // Database.ubahData(item: dtBaru);
                            Navigator.push(
                    context, MaterialPageRoute(builder: (context) => detData(dataDet : dtBaru)));
                          },
                          onLongPress: () {
                            Database.hapusData(judulhapus: lvJudul);
                          },
                          title : Text(lvJudul),
                          subtitle: Text(lvIsi),
                        );
                      }, 
                      separatorBuilder: (context, index) => SizedBox(height:8.0), 
                      itemCount: snapshot.data!.docs.length
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color> (
                        Colors.pinkAccent,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}

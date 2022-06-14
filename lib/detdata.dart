import 'package:firebase_app/dataclass.dart';
import 'package:firebase_app/dbservices.dart';
import 'package:flutter/material.dart';

class detData extends StatefulWidget {
  final itemCatatan? dataDet;
  const detData({ Key? key, this.dataDet }) : super(key: key);

  @override
  State<detData> createState() => _detDataState();
}

class _detDataState extends State<detData> {
  final _ctrJudul = TextEditingController();
  final _ctrIsi = TextEditingController();
  bool _isDisabled = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _ctrJudul.dispose();
    _ctrIsi.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ctrJudul.text = widget.dataDet?.itemJudul ?? "";
    _ctrIsi.text = widget.dataDet?.itemIsi ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataDet == null)
      _isDisabled = true;
      
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Data Note'),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ctrJudul,
              enabled: _isDisabled,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan judul Note'
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _ctrIsi,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan isi Note'
              ),
            ),
            ElevatedButton(onPressed: () {
              final dt = itemCatatan(itemJudul: _ctrJudul.text, itemIsi: _ctrIsi.text);
              Database.tambahData(item: dt);
              Navigator.pop(context);
            }, child: Text('Simpan Data'),),
          ],
        ),
      )
    );
  }
}
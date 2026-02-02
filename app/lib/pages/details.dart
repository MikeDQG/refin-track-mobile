import 'package:app/firebase/save_stroj.dart';
import 'package:app/models/stroj.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Stroj stroj;

  DetailsPage({required this.stroj});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  // Future<DocumentReference> response = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: Column(
          children: [
            Text(widget.stroj.naziv),
            ElevatedButton(
              onPressed: () async {
                await FirebaseStrojService.saveStroj(stroj: widget.stroj);
              },
              child: Text('save stroj'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseStrojService.getAllStroji();
              },
              child: Text('get all stroj'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseStrojService.getStrojById(widget.stroj.id);
              },
              child: Text('get stroj by id - 1'),
            ),
            ElevatedButton(
              onPressed: () async {
                print("nada");
              },
              child: Text('nada'),
            ),
          ],
        ),
      ),
    );
  }
}

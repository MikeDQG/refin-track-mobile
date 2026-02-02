
import 'package:app/models/stroj.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Stroj stroj;

  DetailsPage({required this.stroj});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: Text(stroj.naziv),
      ),
    );
  }
}

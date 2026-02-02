import 'dart:convert';
import 'dart:typed_data';

import 'package:app/models/stroj.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/src/objects/barcode.dart';

class CodeReadOptions extends StatelessWidget {
  final Uint8List image;
  final List<Barcode> barcodes;

  const CodeReadOptions({
    super.key,
    required this.image,
    required this.barcodes,
  });

  @override
  Widget build(BuildContext context) {
    if (barcodes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Izberi QR kodo')),
        body: const Center(child: Text('Ni zaznanih QR kod')),
      );
    }
    final List<Stroj> barcodeList = barcodes.map((barcode) {
      final Map<String, dynamic> json =
          jsonDecode(barcode.rawValue ?? '{}') as Map<String, dynamic>;
      return Stroj.fromJson(json);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Izberi QR kodo')),
      body: Center(
        child: Column(
          children: [
            Image.memory(image),
            ...barcodeList.map(
              (stroj) => ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8), 
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code),
                      const SizedBox(width: 10),
                      Text("ID: ${stroj.id.toString()}"),
                      const SizedBox(width: 10),
                      Expanded(child: Text("Naziv: ${stroj.naziv}")),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Izbrana koda'),
                      content: Text('Izbrali ste stroj:\nID: ${stroj.id}\nNaziv: ${stroj.naziv}'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('V redu'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

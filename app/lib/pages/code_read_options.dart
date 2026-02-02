import 'dart:convert';
import 'dart:typed_data';

import 'package:app/models/stroj.dart';
import 'package:app/pages/details.dart';
import 'package:app/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/src/objects/barcode.dart';

class CodeReadOptions extends StatefulWidget {
  final Uint8List image;
  final List<Barcode> barcodes;

  const CodeReadOptions({
    super.key,
    required this.image,
    required this.barcodes,
  });

  @override
  State<CodeReadOptions> createState() => _CodeReadOptionsState();
}

class _CodeReadOptionsState extends State<CodeReadOptions> {
  int selectedIndex = -1;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
      } else {
        selectedIndex = index;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.barcodes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Izberi QR kodo')),
        body: const Center(child: Text('Ni zaznanih QR kod')),
      );
    }
    final List<Stroj> barcodeList = widget.barcodes.map((barcode) {
      final Map<String, dynamic> json =
          jsonDecode(barcode.rawValue ?? '{}') as Map<String, dynamic>;
      return Stroj.fromJson(json);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Izberi QR kodo')),
      body: Center(
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.all(16.0),
          children: [
            Image.memory(widget.image),
            ...barcodeList.map(
              (stroj) => ListTile(
                key: ValueKey(stroj.id),
                title: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code),
                      const SizedBox(width: 10),
                      Text("ID: ${stroj.id.toString()}"),
                      const SizedBox(width: 10),
                      Expanded(child: Text("Naziv: ${stroj.naziv}")),
                      if (stroj.id == selectedIndex)
                        const Icon(Icons.check, color: Colors.green),
                    ],
                  ),
                ),
                onTap: () {
                  toggleSelection(stroj.id);
                },
              ),
            ),
            if (selectedIndex != -1)
              CardButton(
                title: "Naprej",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsPage(
                        stroj: barcodeList.firstWhere(
                          (stroj) => stroj.id == selectedIndex,
                        ),
                      ),
                    ),
                  );
                },
                theme: Theme.of(context),
                height: 50,
                borderRadius: 8.0,
                sizeFactor: 0.8,
              ),
          ],
        ),
      ),
    );
  }
}

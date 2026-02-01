import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner Page'),
      ),
      body: Center(
        child: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
            returnImage: true,
          ),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
              print('Barcode found! ${barcode.rawValue}');
            }
            if (image != null) {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text(barcodes.first.rawValue ?? 'No data'),
                  content: Image.memory(image),
                );
              });
            }
          },
        ),
      ),
    );
  }
}

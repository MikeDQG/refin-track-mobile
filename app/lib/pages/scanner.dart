import 'dart:typed_data';

import 'package:app/pages/code_read_options.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late final MobileScannerController _controller;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner Page')),
      body: Center(
        child: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
            returnImage: true,
          ),
          onDetect: (capture) async {
            if (_navigated) return;
            _navigated = true;

            await _controller.stop();

            final image = capture.image;
            if (image != null) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CodeReadOptions(image: image, barcodes: capture.barcodes),
                ),
              );
            }

            await _controller.start();
            _navigated = false;
          },
        ),
      ),
    );
  }
}

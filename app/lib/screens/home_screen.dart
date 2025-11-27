import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String _scanResult = 'Še niste skenirali kode.';
  Map<String, dynamic>? _machineData;
  bool _isLoading = false;

  // Asinhrona funkcija za skeniranje in poizvedbo
  void _scanAndQuery() async {
    // 1. Pojdi na zaslon za skeniranje in čakaj na rezultat
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScannerScreen()),
    );

    if (result != null && result is String) {
      setState(() {
        _scanResult = 'Skenirana koda: $result';
        _isLoading = true;
        _machineData = null;
      });

      // 2. Poizvedba na Firebase
      final data = await _firebaseService.getMachineDetails(result);

      // 3. Posodobi stanje
      setState(() {
        _isLoading = false;
        _machineData = data;
      });
    } else {
      setState(() {
        _scanResult = 'Skeniranje preklicano ali neuspešno.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iskalnik Strojev (QR)'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _scanAndQuery,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Skeniraj QR kodo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 40),
              
              // Prikaz rezultata skeniranja
              Text(_scanResult, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              const SizedBox(height: 20),

              // Prikaz stanja nalaganja ali podatkov
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_machineData != null)
                // Prikaz podatkov stroja
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Podatki o stroju:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const Divider(),
                        ..._machineData!.entries.map((entry) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text('${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 16)),
                        )).toList(),
                      ],
                    ),
                  ),
                )
              else if (_scanResult.contains('Skenirana koda'))
                // Prikaz, če koda ni najdena
                const Text(
                  'Stroj s to kodo ni najden v bazi.',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';

// OPOMBA: Tukaj moraš dodati konfiguracijo za Firebase,
// ki jo dobiš ob nastavitvi projekta (npr. firebase_options.dart).
// Za poenostavitev predpostavljam, da je inicializacija pravilna.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializacija Firebase
  // Če uporabljaš FlutterFire CLI, bo to izgledalo nekako takole:
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  // Za testiranje brez dejanske konfiguracije lahko to zakomentiraš,
  // vendar poizvedba na bazo ne bo delovala.
  
  // await Firebase.initializeApp(); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Iskalnik Strojev',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

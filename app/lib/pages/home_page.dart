import 'package:app/pages/page1.dart';
import 'package:app/pages/scanner.dart';
import 'package:app/widgets/card_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Refin Track')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardButton(
              title: 'Skeniraj QR kodo',
              icon: Icons.qr_code_scanner,
              height: MediaQuery.of(context).size.height / 4,
              theme: theme,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Scanner()),
                );
              },
            ),
            SizedBox(height: 20),
            CardButton(
              title: 'Isci po imenu',
              icon: Icons.search,
              height: MediaQuery.of(context).size.height / 4,
              theme: theme,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PageOne()),
                );
              },
            ),
            SizedBox(height: 20),
            CardButton(
              title: 'Zgodovina pregledov',
              icon: Icons.history,
              theme: theme,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PageOne()),
                );
              }, 
              height: MediaQuery.of(context).size.height / 4,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app/pages/page1.dart';
import 'package:app/pages/scanner.dart';
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
            ),
          ],
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  final ThemeData theme;

  const CardButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height / 4,
      child: Card(
        color: theme.colorScheme.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias, // needed for InkWell ripple
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 50),
                Text(title, style: TextStyle(color: Colors.white, fontSize: 30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

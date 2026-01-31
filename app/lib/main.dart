import 'package:app/page1.dart';
import 'package:app/scanner.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Navigation',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardButton(
              title: 'Skeniraj crtno kodo',
              icon: Icons.qr_code_scanner,
              theme: theme,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PageOne()),
                );
              },
            ),
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

  Widget _navButton(
    BuildContext context, {
    required String text,
    required Widget page,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

Widget buildCard(IconData icon, String text, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
    child: Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 50),
            const SizedBox(width: 10),
            Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    ),
  );
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

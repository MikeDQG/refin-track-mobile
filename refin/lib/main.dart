import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refin Track',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Izbira stroja'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCard(Icons.qr_code_scanner, 'Skeniraj crtno kodo', theme),
            SizedBox(height: 20),
            buildCard(Icons.search, 'Isci po imenu', theme),
            SizedBox(height: 20),
            buildCard(Icons.history, 'Zgodovina pregledov', theme),
          ],
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

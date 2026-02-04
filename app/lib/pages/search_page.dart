import 'package:app/firebase/stroj_service.dart';
import 'package:app/models/stroj.dart';
import 'package:app/pages/details.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Stroj> stroji = [];
  bool isLoading = true; // Add loading indicator

  @override
  void initState() {
    super.initState();
    _loadStroji();
  }

  Future<void> _loadStroji() async {
    try {
      final List<Stroj> existingStroji =
          await FirebaseStrojService.getAllStroji();

      if (!mounted) return;

      setState(() {
        print(existingStroji);
        stroji = existingStroji;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print('Error loading stroji: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : stroji.isEmpty
          ? Center(
              child: Text(
                "Ni vnesenih strojev",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          : Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListView(
                children: stroji
                    .map(
                      (stroj) => Card(
                        child: ListTile(
                          key: ValueKey(stroj.id),
                          title: Text(stroj.naziv), // Show stroj name
                          subtitle: stroj.opis != null && stroj.opis!.isNotEmpty
                              ? Text(stroj.opis!)
                              : null,
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsPage(stroj: stroj),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(), // Don't forget toList()
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchBar(),
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(controller: controller);
              },
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                return [];
              },
            )
          ],
        ),
      ),
    );
  }
}
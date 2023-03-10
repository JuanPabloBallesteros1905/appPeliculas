import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override

  String? get searchFieldLabel => 'Buscador';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(
        title: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('data');
  }
}

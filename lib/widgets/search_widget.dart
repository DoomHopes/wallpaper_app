import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/home_page_provider.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, providerData, child) => Visibility(
        child: providerData.searchListViewBuilder(1, query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // ignore: todo
    // TODO: something
    return Column();
  }
}

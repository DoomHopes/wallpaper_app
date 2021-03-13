import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/home_page_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, providerData, child) => Scaffold(
        appBar: AppBar(
          title: Text('Wallpaper App'),
        ),
        body: Visibility(
          child: providerData.listViewBuilder(
              'https://api.unsplash.com/search/photos?page=2&per_page=30&client_id=tZ53x_MgSn7Q0rh9HNWFkOC9nPLVqXL0T77iNilmD1U&query=car'),
        ),
      ),
    );
  }
}

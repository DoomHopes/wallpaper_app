import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/home_page_provider.dart';
import 'package:wallpaper_app/widgets/drawer_widget.dart';
import 'package:wallpaper_app/widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, providerData, child) => Scaffold(
        appBar: AppBar(
          title: Text('Wallpaper App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
            )
          ],
        ),
        drawer: MyDrawerWidget(),
        body: Visibility(
          child: providerData.listViewBuilder(1, 'car'),
        ),
      ),
    );
  }
}

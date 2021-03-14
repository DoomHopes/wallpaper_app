import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/home_page_provider.dart';

class MyDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, providerData, child) => SizedBox(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/wallpaper.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: null,
                ),
              ),
              ListTile(
                title: Text('Cars'),
                onTap: () {
                  providerData.getListFromAPI(1, 'car');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Office'),
                onTap: () {
                  providerData.getListFromAPI(1, 'office');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Nature'),
                onTap: () {
                  providerData.getListFromAPI(1, 'nature');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Winter'),
                onTap: () {
                  providerData.getListFromAPI(1, 'winter');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Summer'),
                onTap: () {
                  providerData.getListFromAPI(1, 'summer');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

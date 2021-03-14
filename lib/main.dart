import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/pages/home_page.dart';
import 'package:wallpaper_app/providers/home_page_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageProvider>(
          create: (_) => HomePageProvider(),
        ),
      ],
      child: MaterialApp(
        locale: Locale('ru'),
        title: 'Wallpaper App',
        initialRoute: '/first',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: true,
        routes: {
          '/first': (context) => HomePage(),
        },
      ),
    );
  }
}

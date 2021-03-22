import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/pages/home_page.dart';
import 'package:wallpaper_app/providers/home_page_provider.dart';
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

Locale checkLocale() {
  String locale =
      Locale(ui.window.locale.toString().replaceRange(2, 5, '')).toString();
  if (locale == 'ru') {
    return Locale('ru');
  } else {
    return Locale('en');
  }
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
        locale: checkLocale(),
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

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/home_page_provider.dart';
import 'package:wallpaperplugin/wallpaperplugin.dart';

class GridViewBuilder extends StatefulWidget {
  @override
  _GridViewBuilderState createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {
  int _page = 2;
  ScrollController _controller;
  String _localfile;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _loadData(1, 'car');
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _loadData(int page, String query) {
    context.read<HomePageProvider>().getGridViewListFromAPI(page, query);
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _loadData(_page, context.read<HomePageProvider>().query);
      setState(() {
        _page += 1;
      });
    }
  }

  static Future<bool> _checkAndGetPermission() async {
    final PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      final Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions(<PermissionGroup>[PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
        return null;
      }
    }
    return true;
  }

  _onTapImage(BuildContext context, values) {
    return AlertDialog(
      title: Text("Set as wallpaper ?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("NO"),
        ),
        FlatButton(
          onPressed: () async {
            if (await _checkAndGetPermission() != null) {
              Dio dio = Dio();
              final Directory appdirectory =
                  await getExternalStorageDirectory();
              final Directory directory =
                  await Directory(appdirectory.path + '/wallpapers')
                      .create(recursive: true);
              final String dir = directory.path;
              final String localfile = '$dir/myimage.jpeg';
              try {
                await dio.download(values, localfile);
                setState(() {
                  _localfile = localfile;
                });
                Wallpaperplugin.setWallpaperWithCrop(localFile: _localfile);
              } on PlatformException catch (e) {
                print(e);
              }
              Navigator.pop(context);
            }
          },
          child: Text("YES"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, providerData, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            _controller.jumpTo(0);
          },
        ),
        body: GridView.builder(
          controller: _controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 3
                    : 2,
            childAspectRatio: 1.5,
          ),
          itemCount: providerData.workList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => _onTapImage(
                        context, providerData.workList[index].urls.full));
              },
              child: Container(
                child: Image.network(
                  providerData.workList[index].urls.regular,
                  fit: BoxFit.fitWidth,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

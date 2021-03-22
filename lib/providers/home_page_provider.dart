import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/image_model.dart';
import 'package:wallpaper_app/widgets/circular_progress_loading_widget.dart';
import 'package:wallpaper_app/widgets/grid_view_widget.dart';

class HomePageProvider extends ChangeNotifier {
  List<ImageModel> workList = [];
  String query;
  int page;

  Widget listViewBuilder(int page, String query) {
    if (workList.isEmpty) {
      getListFromAPI(page, query);
      return const CircularProgressLoading();
    } else {
      return GridViewBuilder();
    }
  }

  Widget searchListViewBuilder(int page, String query) {
    getListFromAPI(page, query);
    return GridViewBuilder();
  }

  Future<void> getListFromAPI(int page, String query) async {
    this.query = query;
    workList = await getData(page, query);
    notifyListeners();
  }

  Future<void> getGridViewListFromAPI(int page, String query) async {
    this.query = query;
    List<ImageModel> temp = await getData(page, query);
    workList.addAll(temp);
    notifyListeners();
  }

  String getUrl(int page, String query) {
    return 'https://api.unsplash.com/search/photos?page=$page&per_page=30&client_id=tZ53x_MgSn7Q0rh9HNWFkOC9nPLVqXL0T77iNilmD1U&query=$query';
  }

  Future<List<ImageModel>> getData(int page, String query) async {
    String url = getUrl(page, query);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      final List<dynamic> listMap = jsonData['results'];
      return addToList(listMap);
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<ImageModel> addToList(List<dynamic> addList) {
    List<ImageModel> newImageList = [];
    newImageList =
        addList.map<ImageModel>((json) => ImageModel.fromJson(json)).toList();
    return newImageList;
  }
}

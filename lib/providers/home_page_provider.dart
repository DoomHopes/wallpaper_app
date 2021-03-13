import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/image_model.dart';
import 'package:wallpaper_app/widgets/circular_progress_loading_widget.dart';
import 'package:wallpaper_app/widgets/list_view_widget.dart';

class HomePageProvider extends ChangeNotifier {
  List<ImageModel> workList = [];

  Widget listViewBuilder(String url) {
    if (workList.isEmpty) {
      getReturnedListFromAPI(url);
      return const CircularProgressLoading();
    } else {
      return ListViewBuilder(listHome: workList);
    }
  }

  Future<void> getReturnedListFromAPI(String url) async {
    workList = await getData(url);
    notifyListeners();
  }

  Future<List<ImageModel>> getData(String url) async {
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
    List<ImageModel> newNewsList = [];
    newNewsList =
        addList.map<ImageModel>((json) => ImageModel.fromJson(json)).toList();
    return newNewsList;
  }
}

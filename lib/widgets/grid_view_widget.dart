import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/models/image_model.dart';
import 'package:wallpaper_app/providers/home_page_provider.dart';

class GridViewBuilder extends StatefulWidget {
  GridViewBuilder({Key key, @required this.listHome}) : super(key: key);
  final List<ImageModel> listHome;

  @override
  _GridViewBuilderState createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {
  int page = 2;
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _loadData(int page, String query) {
    context.read<HomePageProvider>().getGridViewListFromAPI(page, query);
    setState(() {
      page += 1;
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _loadData(page, context.read<HomePageProvider>().query);
      setState(() {
        page += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
        childAspectRatio: 1.5,
      ),
      itemCount: widget.listHome.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //to do something
          },
          child: Container(
            child: Image.network(
              widget.listHome[index].urls.regular,
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
    );
  }
}

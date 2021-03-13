import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/image_model.dart';

import 'circular_progress_loading_widget.dart';

class ListViewBuilder extends StatelessWidget {
  ListViewBuilder({Key key, @required this.listHome}) : super(key: key);
  final List<ImageModel> listHome;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
        childAspectRatio: 1.5,
      ),
      itemCount: listHome.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //to do something
          },
          child: Container(
            child: Image.network(
              listHome[index].urls.regular,
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

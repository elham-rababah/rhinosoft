import 'package:flutter/material.dart';
import 'package:pizaaelk/providers/auth_provider.dart';
import 'package:pizaaelk/widget/ImageSliderItem.dart';
import 'package:provider/provider.dart';

class ImageSliderRow extends StatelessWidget {
  ImageSliderRow({this.onTap, this.images});

  final onTap;
  final List<dynamic> images;

  List<Widget> scrollChildren = [];

  @override
  Widget build(BuildContext context) {
    buildScrollChildren();
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(right: 0.0),
        child: Row(children: scrollChildren),
      ),
    );
  }

  List<Widget> buildScrollChildren() {
    this.images.forEach((image) {
      scrollChildren.add(
        Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.only(top: 8.0, right: 15.0),
              child: image.toString().contains('http')
                  ? ImageSliderItem(
                imageUrl: image,
              )
                  : ImageSliderItem(
                image: image,
              ),
            );
          },
        ),
      );
    });
    scrollChildren.add( Builder(
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(top: 8.0, right: 15.0),
          child: ImageSliderItem(
            image: null,
            height: images.length == 0 ? 150 : 70.0,
            width: images.length == 0
                ? MediaQuery.of(context).size.width * 0.87
                : 70.0,
            onTap: onTap,
          ),
        );
      },
    ));
    return scrollChildren;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ImageSliderItem extends StatefulWidget {
  final File image;
  final String imageUrl;
  final bool selected;
  final Function onTap;
  final double width;
  final double height;


  ImageSliderItem(
      {Key key, this.image, this.selected: false, this.onTap, this.imageUrl, this.height = 70.0, this.width = 70.0})
      : super(key: key);

  @override
  _ImageSliderItemState createState() => _ImageSliderItemState();
}

class _ImageSliderItemState extends State<ImageSliderItem>
    with TickerProviderStateMixin {
  double _cardSize = 1.0;
  AnimationController _animationController;
  Animation _animation;

  File image;
  String caption;
  bool selected;

  @override
  void initState() {
    setState(() {
      image = widget.image;
      selected = widget.selected;
    });
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.4,
        upperBound: 1.0,
        duration: Duration(milliseconds: 60));
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutQuint);
    _animation.addListener(() {
      setState(() {
        _cardSize = _animation.value;
      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(ImageSliderItem oldWidget) {
    if (oldWidget.selected != widget.selected) {
      setState(() {
        selected = widget.selected;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GestureDetector(
            onTapDown: (TapDownDetails tap) {
              _animationController.reverse(from: 1.0);
            },
            onTapUp: (TapUpDetails tap) {
              _animationController.forward();
            },
            onTapCancel: () {
              _animationController.forward();
            },
            onTap: Feedback.wrapForTap(() {
              if (widget.onTap != null)
                widget.onTap();
              else {
//                Navigator.of(context).push(SlideUpPageRoute(widget: PostTaskIndex(task: new Task(category: caption),)));
              }
            }, context),
            child: Transform.scale(
              scale: _cardSize,
              child: Stack(
                children: <Widget>[
                  widget.image == null && widget.imageUrl == null
                      ? ImageContainer(widget: widget)
                      : Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(
                            color: Colors.grey, width: 2.5),
                      ),
                      child: ImageContainer(widget: widget)),
                  Positioned(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      width: widget.width,
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: selected
                            ? Color.fromRGBO(78, 62, 253, 0.8)
                            : Color.fromRGBO(78, 62, 253, 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Center(
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeOutQuart,
                            width: selected ? 30.0 : 0.0,
                            height: selected ? 30.0 : 0.0,
                            decoration: BoxDecoration(
                              color:
                              selected ? Colors.white : Colors.transparent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Center(
                                child: AnimatedOpacity(
                                    duration: Duration(milliseconds: 100),
                                    curve: Interval(0.8, 1.0),
                                    opacity: selected ? 1.0 : 0.0,
                                    child: Icon(
                                      FontAwesomeIcons.check,
                                      color: Color.fromRGBO(78, 62, 253, 1.0),
                                      size: 24.0,
                                    )))),
                      ),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ImageSliderItem widget;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .backgroundColor,
      ),
      child: Padding(
          padding: EdgeInsets.all(0.0),
          child: widget.image == null && widget.imageUrl == null
              ? Icon(
            FontAwesomeIcons.plus,
            color: Theme
                .of(context)
                .accentColor,
            size: widget.height * .50,
          )
              : Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .backgroundColor,
              ),
              child: widget.imageUrl != null
                  ? Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              )
                  : Image.file(
                widget.image,
                fit: BoxFit.cover,
              ))),
    );
  }
}

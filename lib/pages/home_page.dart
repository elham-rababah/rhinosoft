import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _listViewController;

  int allNewsItemShownCount = 5;
  bool isShowMore = false;

  @override
  void initState() {
    super.initState();
    _listViewController = ScrollController();
  }

  @override
  void dispose() {
    _listViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}

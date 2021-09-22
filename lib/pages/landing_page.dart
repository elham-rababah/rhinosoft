import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LandingPage extends StatefulWidget {
  final int index;
  String url;
  bool preventListeningToSharing;

  LandingPage({Key key, this.index, this.url}) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  int currentTab = 0;
  PageController pageController;
  TextEditingController urlController = TextEditingController();


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomePage(),
          // ProfilePage()
        ],
      ),
      // bottomNavigationBar: BottomNavBar(currentTab: currentTab,changeIndex: _changeCurrentTab),
    );
  }
}

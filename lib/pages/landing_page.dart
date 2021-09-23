import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizaaelk/pages/admin_page.dart';

import '../widget/bottom_nav_bar.dart';
import 'products/add_product_page.dart';
import 'products/product_list_page.dart';

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


  @override
  void initState() {
    super.initState();
    pageController = new PageController(keepPage: true);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ProductListPage(),
          AddProductPage(onChange: _changeCurrentTab,),
          AdminPage()
        ],
      ),
      bottomNavigationBar: BottomNavBar(changeIndex: _changeCurrentTab),
    );
  }

  _changeCurrentTab(int tab) {
    setState(() {
      currentTab = tab;
      pageController.jumpToPage(tab);
    });
  }
}



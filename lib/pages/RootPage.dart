import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizaaelk/pages/landing_page.dart';
import 'package:pizaaelk/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../Auth_view_model.dart';


class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).backgroundColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: Theme.of(context).brightness));
    AuthViewModel authViewModel = Provider.of(context);

    APP_STATUS status = authViewModel.status;

    Widget buildRoot() {
      switch (status) {
        case APP_STATUS.LOADING:
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        case APP_STATUS.UNAUTHENTICATED:
          return LoginPage();
        default:
          return LandingPage();
      }
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      switchInCurve: Curves.ease,
      child: buildRoot(),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:pizaaelk/pages/RootPage.dart';
import 'package:provider/provider.dart';

import 'Auth_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return LayoutBuilder(
        builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthViewModel>(
                create: (context) => AuthViewModel(),
              ),
            ],
            child: MaterialApp(
              showSemanticsDebugger: false,
              title: 'Pizzea  App',
              initialRoute: '/',
              routes: {'/': (context) => RootPage()},
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      );
    },
    );;
  }
}
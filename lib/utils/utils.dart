import 'package:flutter/material.dart';

class Utils {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                // key: key,
                  backgroundColor: Colors.grey,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ]),
                    )
                  ]));
        });
  }

  static hideDialog(context) {
    Navigator.of(context).pop();
  }
}
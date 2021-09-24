import 'package:flutter/material.dart';

class AppButtonWidget extends StatefulWidget {
  final String label;
  final Function onPressed;
  const AppButtonWidget({Key key, @required this.label, @required this.onPressed}) : super(key: key);

  @override
  _AppButtonWidgetState createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 35,
        decoration: const BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.all(
              Radius.circular(8.0)
          ),
        ),
        child: TextButton(
            child: Text(
                widget.label?? '',
              style: const TextStyle(
                color: Colors.white
              ),
            ),
          onPressed: widget.onPressed
        ),
      ),
    );
  }
}

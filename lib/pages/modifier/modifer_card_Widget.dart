import 'package:flutter/material.dart';
import 'package:pizaaelk/model/modifier_model.dart';

class modiferWidget extends StatelessWidget {
  final ModifierModel modifer;

  const modiferWidget({Key key, this.modifer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
          border: Border.all(color: Colors.deepOrangeAccent),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      modifer.modifierName ?? "",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(modifer.isRequired ? "isRequired" : "Not Required"),
                    Text(modifer.onlyOne
                        ? "Only One Selected"
                        : "Not Only One Selected"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: modifer.children.map((Children e) {
                      return Text("${e.label} => ${e.price}"
                         );
                    }).toList())
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pizaaelk/pages/modifier/add_modifer_page.dart';
import 'package:pizaaelk/providers/modifer_provider.dart';
import 'package:pizaaelk/widget/request_button_widget.dart';
import 'package:provider/provider.dart';

import 'modifer_card_Widget.dart';

class ModifierList extends StatelessWidget {
  ModifierProvider modifierProvider;

  @override
  Widget build(BuildContext context) {
    modifierProvider = Provider.of(context);
    modifierProvider.getModifiers();
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.99,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment:Alignment.topRight,
                  child: FractionallySizedBox(
                    widthFactor: .4,
                    child: AppButtonWidget(
                      label: "Add  Modifier",
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => AddModifierName()));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                modifierProvider.itemsLoading
                    ? Center(child: const CircularProgressIndicator())
                    : modifierProvider.allModifier.length == 0
                        ? Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 140,
                                ),
                                Text("No Items"),
                              ],
                            ),
                          )
                        : Expanded(
                            child: FractionallySizedBox(
                              widthFactor: 0.95,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      modifierProvider.allModifier.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return modiferWidget(
                                      modifer:
                                          modifierProvider.allModifier[index],
                                    );
                                  }),
                            ),
                          )
              ],
            ),
          )
        ],
      ),
    );
  }
}

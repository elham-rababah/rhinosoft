import 'package:flutter/material.dart';
import 'package:pizaaelk/model/modifier_model.dart';
import 'package:pizaaelk/providers/auth_provider.dart';
import 'package:pizaaelk/providers/modifer_provider.dart';
import 'package:pizaaelk/utils/utils.dart';
import 'package:pizaaelk/widget/request_button_widget.dart';
import 'package:provider/provider.dart';

class AddModifierName extends StatefulWidget {
  final Function onChange;

  const AddModifierName({Key key, this.onChange}) : super(key: key);

  @override
  _AddModifierNameState createState() => _AddModifierNameState();
}

class _AddModifierNameState extends State<AddModifierName> {
  final formKey = GlobalKey<FormState>();
  ModifierProvider modifierProvider;
  AuthProvider authProvider;

  ModifierModel modifierModel = ModifierModel(children: [Children()]);

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of(context);
    modifierProvider = Provider.of(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Modifier details",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                    ),
                                    onChanged: (val) {
                                      modifierModel.modifierName = val;
                                    },
                                  )
                                ],
                              ),
                              Row(children: <Widget>[
                                Checkbox(
                                  checkColor: Colors.greenAccent,
                                  activeColor: Colors.red,
                                  value: modifierModel.isRequired,
                                  onChanged: (bool value) {
                                    setState(() {
                                      modifierModel.isRequired = value;
                                    });
                                  },
                                ),
                                Text(
                                  'is Required ',
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ]),
                              Row(children: <Widget>[
                                Checkbox(
                                  checkColor: Colors.greenAccent,
                                  activeColor: Colors.red,
                                  value: modifierModel.onlyOne,
                                  onChanged: (bool value) {
                                    setState(() {
                                      modifierModel.onlyOne = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Select Only ',
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ]),
                              SizedBox(height: 20.0),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: modifierModel.children.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .9,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'label',
                                                    ),
                                                    onChanged: (val) {
                                                      modifierModel
                                                          .children[index]
                                                          .label = val;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .3,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'price',
                                                    ),
                                                    onChanged: (val) {
                                                      modifierModel
                                                              .children[index]
                                                              .price =
                                                          int.parse(val);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: AppButtonWidget(
                                    label: "Add Option",
                                    onPressed: () async {
                                      setState(() {
                                        modifierModel.children.add(Children());
                                      });
                                      // _validateAndSubmit();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: AppButtonWidget(
                                    label: "Add the Modifer",
                                    onPressed: () async {
                                      _validateAndSubmit();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSubmit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      Utils.showLoadingDialog(context);
      form.save();
      await modifierProvider.addModifier(
          modifierModel, authProvider.userData.uid);

      Utils.hideDialog(context);
      Navigator.of(context).pop();
    }
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizaaelk/model/Product.dart';
import 'package:pizaaelk/providers/auth_provider.dart';
import 'package:pizaaelk/providers/products_provider.dart';
import 'package:pizaaelk/utils/utils.dart';
import 'package:pizaaelk/widget/ImageSliderRow.dart';
import 'package:pizaaelk/widget/request_button_widget.dart';
import 'package:provider/provider.dart';





class AddProductPage extends StatefulWidget {
  final Product product;
  final Function onChange;

  AddProductPage({this.product, this.onChange});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController dateString = new TextEditingController();
  DateTime date;
  TextEditingController condition =
  new TextEditingController(text: "Select Item Condition");
  TextEditingController quantity = new TextEditingController(text: "1");

  List<dynamic> attachments = [];
  List<String> attachmentsURLs = [];
  List<StorageUploadTask> _uploadItem = [];
  final formKey = GlobalKey<FormState>();
  Product item = Product();
  ProductsProvider myProductsProvider;
  AuthProvider authProvider;
  bool _isLoading = false;
  bool _isDraft = false;
  List<String> categories = [];

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of(context);
    myProductsProvider = Provider.of(context, listen: false);

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
                          "Listing details",

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ImageSliderRow(
                          onTap: () => showImageOptions(context),
                          images: attachments,
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
                                  Text("Title",
                                      ),
                                  SizedBox(height: 10.0),
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Title',
                                    ),
                                    onChanged: (val){
                                      item.title = val;
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 20.0),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>[
                                  Text("Description",
                                  ),
                                  SizedBox(height: 10.0),
                                  TextField(
                                    minLines: 4,
                                    maxLines: 20,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Description',
                                    ),
                                    onChanged: (val){
                                      item.description = val;
                                    },
                                  )
                                ],
                              ),


                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: AppButtonWidget(
                                    label: "Save as Draft",

                                    onPressed: () async {
                                      _validateAndSubmit();
                                    })),
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
      await startUpload();
      item.images = attachmentsURLs;
      item.category = [];
      categories.forEach((element) {
        item.category.add(element);
      });
      await myProductsProvider.addProduct(item, authProvider.user.uid);
      Utils.hideDialog(context);

      widget.onChange(0);


    }
  }

  showConditionOptions(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return _BottomSheet(
            children: <Widget>[
              _BottomSheetItem(
                  title: "Old",
                  onTap: () async {
                    condition.text = "Old";
                  }),
              _BottomSheetItem(
                title: "New",
                onTap: () async {
                  condition.text = "New";
                },
              )
            ],
          );
        });
  }

  showImageOptions(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return _BottomSheet(
            children: <Widget>[
              _BottomSheetItem(
                  title: "Gallery",
                  icon: FontAwesomeIcons.image,
                  onTap: attachments.length == 10
                      ? null
                      : () async {
                    await getImage(ImageSource.gallery);
                  }),
              _BottomSheetItem(
                title: "Camera",
                icon: FontAwesomeIcons.camera,
                onTap: attachments.length == 10
                    ? null
                    : () async {
                  await getImage(ImageSource.camera);
                },
              )
            ],
          );
        });
  }

  Future getImage(ImageSource type) async {
    File _image = await ImagePicker.pickImage(source: type);
    if (_image != null) {
      String fileName = _image.path;
      fileName = fileName.split("/")[fileName.split("/").length - 1];
      setState(() {
        _uploadItem.add(null);
        attachments.add(_image);
      });
    }
  }

  Future startUpload() async {
    StorageReference ref = FirebaseStorage.instance.ref().child(
        "ItemAttachments/" +
            Provider.of<AuthProvider>(context, listen: false).user.uid);
    for (int i = 0; i < attachments.length; i++) {
      if (attachments[i].runtimeType != String) {
        String fileName = attachments[i]
            .path
            .split("/")[attachments[i].path.split("/").length - 1];
        StorageUploadTask uploadTask =
        ref.child(fileName).putFile(attachments[i]);
        print("asd ${_uploadItem.length}");
        setState(() {
          _uploadItem[i] = uploadTask;
        });
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        if (uploadTask.isComplete) {
          try {
            String url = await taskSnapshot.ref.getDownloadURL();
            attachmentsURLs.add(url);
          } catch (e) {
            print(e);
          }
        }
      } else {
        attachmentsURLs.add(attachments[i]);
      }
    }
  }
}

// ToDo Improve bottom sheet to make it component
class _BottomSheet extends StatelessWidget {
  final List<Widget> children;

  _BottomSheet({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(3.0)),
              width: 40.0,
              height: 6.0,
            ),
            ...children
          ],
        ),
      ),
    );
  }
}

class _BottomSheetItem extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String title;
  final ITEM_COLOR color;

  _BottomSheetItem(
      {Key key,
        @required this.onTap,
        @required this.title,
        @required this.icon,
        this.color = ITEM_COLOR.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (onTap != null) onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: color == ITEM_COLOR.error
                  ? Theme.of(context).errorColor
                  : Theme.of(context).primaryColor,
              size: 18.0,
            ),
            SizedBox(width: 24.0),
            Text(
              title ?? "",
            ),
          ],
        ),
      ),
    );
  }
}

enum ITEM_COLOR { primary, error }


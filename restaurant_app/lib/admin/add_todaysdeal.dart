import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_app/Widgets/Button.dart';
import 'package:restaurant_app/Widgets/GContainer.dart';
import 'package:restaurant_app/Widgets/TextField.dart';
import 'package:restaurant_app/admin/Image_upload.dart';
import 'package:restaurant_app/admin/TodaySpecial.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class RIKeys {
  static final riKey1 = GlobalKey<FormState>();
  static final riKey2 = GlobalKey<FormState>();
  static final riKey3 = GlobalKey<FormState>();
  static final riKey4 = GlobalKey<FormState>();
}

class add_todaysDeal extends StatefulWidget {
  const add_todaysDeal({Key? key}) : super(key: key);

  @override
  _add_todaysDealState createState() => _add_todaysDealState();
}

class _add_todaysDealState extends State<add_todaysDeal> {
  String? name;
  String? price;
  String? avail = "Not Available";
  String? image;

  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    XFile? selected = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(selected!.path);
    });
  }

  UploadTask? task;

  Future uploadFile() async {
    if (_imageFile == null) return;

    final fileName = _imageFile!.path.split('/').last;
    final destination = 'todaysdeal/$fileName';

    // print("Filename : " + fileName);
    task = FirebaseApi.uploadFile(destination, _imageFile!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    image = urlDownload;

    _Upload();
  }

  var food_type = ["Select Food Type", "Veg", "Non - Veg"];
  String? initial = "Select Food Type";

  final _formKey = GlobalKey<FormState>();

  late FocusNode nameFocuNode;
  late FocusNode priceFocuNode;

  bool isSwitched = false;

  Future<String?> _Upload() async {
    try {
      DocumentReference doc_ref =
          FirebaseFirestore.instance.collection("today'sDeal").doc();
      Map<String, dynamic> data = {
        "name": name!,
        "price": price!,
        "availability": avail!,
        "type": initial!,
        "image": image!,
        "doc_id": doc_ref.id,
      };
      FirebaseFirestore.instance
          .collection("today'sDeal")
          .doc(doc_ref.id)
          .set(data);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TodaySpecial(
                    topic: "Today's Deal Food Items",
                  )));
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(
                error,
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close Dialog",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        avail = "Available";
      });
    } else {
      setState(() {
        isSwitched = false;
        avail = "Not Available";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameFocuNode = FocusNode();
    priceFocuNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameFocuNode.dispose();
    priceFocuNode.dispose();
  }

  DialogBox(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: SizeConfig.height! * 38,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.height! * 5,
                  horizontal: SizeConfig.width! * 5),
              child: Column(
                children: [
                  gcontainer(
                    height: SizeConfig.height! * 20,
                    color: [
                      Colors.teal.withOpacity(0.2),
                      Colors.teal.withOpacity(0.4),
                    ],
                    cchild: Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              image: new DecorationImage(
                                  image: FileImage(_imageFile!),
                                  fit: BoxFit.fill)),
                        )),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            child: ListTile(
                              title: Text(name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(
                                        TextStyle(
                                            fontSize: SizeConfig.height! * 2.5),
                                      )),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    initial!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .merge(TextStyle(
                                            color:
                                                Theme.of(context).buttonColor)),
                                  ),
                                  Text(avail!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(TextStyle(
                                              color: avail == "Available"
                                                  ? Colors.green
                                                  : Colors.red))),
                                  Text("₹ " + price!.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(
                                            TextStyle(
                                                fontSize:
                                                    SizeConfig.height! * 2.5),
                                          )),
                                ],
                              ),
                              trailing: FaIcon(
                                Icons.add_rounded,
                                size: SizeConfig.height! * 3,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height! * 3,
                  ),
                  button(
                      function: () {
                        uploadFile();
                      },
                      height: SizeConfig.height! * 5,
                      width: SizeConfig.width! * 50,
                      color: Theme.of(context).accentColor,
                      txt: "Upload"),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: SizeConfig.height! * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodaySpecial(
                                      topic: "Today's Deal Food Items",
                                    )));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.chevron_left,
                            color: Theme.of(context).accentColor,
                            size: SizeConfig.height! * 5),
                      ),
                    )),
                    Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Add Item to Today's Deal  🍱",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .merge(TextStyle(
                                        fontSize: SizeConfig.height! * 3)),
                              ),
                            ),
                            Divider(
                              height: SizeConfig.height! * 2,
                              color: Theme.of(context).focusColor,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                      child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.width! * 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Food Type  :",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: DropdownButton(
                                            dropdownColor:
                                                Theme.of(context).accentColor,
                                            items: food_type.map((food_types) {
                                              return DropdownMenuItem(
                                                  value: food_types,
                                                  child: Text(food_types));
                                            }).toList(),
                                            onChanged: (type) {
                                              setState(() {
                                                initial = type.toString();
                                              });
                                            },
                                            value: initial,
                                          )),
                                    ),
                                  ],
                                ))),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: textField(
                            key: RIKeys.riKey1,
                            txt: "Food Name",
                            obscure: false,
                            myFocusNode: nameFocuNode,
                            function: (val) {
                              name = val;
                            },
                            validate: (value) {
                              if (value!.isEmpty && value == "") {
                                return "Food name not be left empty";
                              }
                            },
                          ),
                        )),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: textField(
                            key: RIKeys.riKey2,
                            txt: "Price",
                            type: TextInputType.number,
                            obscure: false,
                            myFocusNode: priceFocuNode,
                            function: (val) {
                              price = val;
                            },
                            validate: (value) {
                              if (value!.isEmpty && value == "") {
                                return "Food Price should not be left empty";
                              }
                            },
                          ),
                        )),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.width! * 7),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: button(
                                          function: () {
                                            _pickImage();
                                          },
                                          height: SizeConfig.height! * 5,
                                          width: SizeConfig.width! * 45,
                                          color: Theme.of(context).accentColor,
                                          txt: "Select Image"),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.width! * 10,
                                    ),
                                    Expanded(
                                      child: _imageFile != null
                                          ? Container(
                                              width: SizeConfig.width! * 80,
                                              child: Text(_imageFile!.path
                                                  .split('/')
                                                  .last),
                                            )
                                          : Text("No Files Selected"),
                                    )
                                  ],
                                ))),
                        Expanded(
                          child: Container(
                              child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.width! * 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Availability    :   ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Container(
                                      height: SizeConfig.height! * 1.5,
                                      child: Switch(
                                        onChanged: toggleSwitch,
                                        value: isSwitched,
                                        activeColor:
                                            Theme.of(context).focusColor,
                                        activeTrackColor:
                                            Theme.of(context).accentColor,
                                        inactiveTrackColor:
                                            Theme.of(context).focusColor,
                                        inactiveThumbColor:
                                            Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  DialogBox(context);
                                },
                                child: button(
                                  height: SizeConfig.height! * 10,
                                  width: SizeConfig.width! * 60,
                                  color: Theme.of(context).accentColor,
                                  txt: "Preview",
                                  function: () {
                                    //DialogBox(context);
                                    if (initial == "Select Food Type") {
                                      _alertDialogBox(
                                          "Select Proper Food Type");
                                    } else {
                                      if (!RIKeys.riKey1.currentState!
                                          .validate()) {
                                        _alertDialogBox(
                                            "Food Name should not be left Empty");
                                      } else {
                                        if (!RIKeys.riKey2.currentState!
                                            .validate()) {
                                          _alertDialogBox(
                                              "Food Price should not be left Empty");
                                        } else {
                                          if (_imageFile == null) {
                                            _alertDialogBox(
                                                "No Image is Selected");
                                          } else {
                                            DialogBox(context);
                                          }
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                height: SizeConfig.height! * 2,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}

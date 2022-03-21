import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/Screens/details_screen.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

import 'Button.dart';

class food_list extends StatefulWidget {
  final String? img;
  final String? name;
  final String? price;
  final String? type;
  final String? doc_id;
  final String? count;
  final String? collectionName;
  final String? availability;

  const food_list(
      {Key? key,
      this.img,
      this.name,
      this.price,
      this.type,
      this.doc_id,
      this.count,
      this.collectionName,
      this.availability})
      : super(key: key);

  @override
  _food_listState createState() => _food_listState();
}

class _food_listState extends State<food_list> {
  Future<void> deleteItem() async {
    FirebaseFirestore.instance
        .collection("userdetails")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .doc(widget.doc_id)
        .delete();
  }

  Future<void> _deleteSaved() async {
    FirebaseFirestore.instance
        .collection("userdetails")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Saved")
        .doc(widget.doc_id)
        .delete();
  }

  Future<void> _alertDialogBox() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              "The food item will delete permanently from the cart",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            content: Container(
                child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width! * 10,
              ),
              child: button(
                height: SizeConfig.height! * 5,
                width: SizeConfig.width! * 5,
                color: Theme.of(context).accentColor,
                txt: "Confirm Delete",
                function: () {
                  Navigator.pop(context);
                  deleteItem();
                },
              ),
            )),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close Dialog",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 2),
      child: Container(
        height: SizeConfig.height! * 23,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: SizeConfig.height! * 4.5,
                          backgroundImage: NetworkImage(widget.img!),
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.name!.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .merge(TextStyle(
                                        fontSize: SizeConfig.height! * 2.2)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "₹  " + widget.price!,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: widget.count != null
                              ? Text(
                                  widget.count!,
                                  style: Theme.of(context).textTheme.subtitle1,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    showAnimatedDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: DetailScreen(
                                            collectionName:
                                                widget.collectionName,
                                            productId: widget.doc_id,
                                            title: widget.name,
                                            img: widget.img,
                                            availability: widget.availability,
                                            price: widget.price,
                                            type: widget.type,
                                          ),
                                        );
                                      },
                                      animationType: DialogTransitionType
                                          .slideFromBottomFade,
                                      curve: Curves.easeInCirc,
                                      duration: Duration(seconds: 1),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: SizeConfig.height! * 3,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).accentColor),
                                    child: FaIcon(
                                      Icons.add,
                                      size: SizeConfig.height! * 3,
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        child: widget.count != null
                            ? GestureDetector(
                                onTap: () {
                                  _alertDialogBox();
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: FaIcon(
                                    Icons.delete,
                                    size: SizeConfig.height! * 3,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  _deleteSaved();
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: FaIcon(
                                    Icons.favorite,
                                    size: SizeConfig.height! * 3,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Expanded(
              child: Divider(
                height: SizeConfig.height! * 2,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

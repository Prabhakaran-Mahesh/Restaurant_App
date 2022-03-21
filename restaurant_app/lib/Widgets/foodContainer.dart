import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/Screens/details_screen.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

import 'Button.dart';
import 'GContainer.dart';

class food_container extends StatefulWidget {
  final String img;
  final String title;
  final String availability;
  final String price;
  final String type;
  final String collectionName;
  final String doc_id;

  const food_container(
      {Key? key,
      required this.img,
      required this.title,
      required this.availability,
      required this.price,
      required this.type,
      required this.collectionName,
      required this.doc_id})
      : super(key: key);

  @override
  _food_containerState createState() => _food_containerState();
}

class _food_containerState extends State<food_container> {
  bool contains = false;
  String userid = FirebaseAuth.instance.currentUser!.uid;
  Future<void> _addtoSaved() {
    setState(() {
      contains = !contains;
    });
    return FirebaseFirestore.instance
        .collection("userdetails")
        .doc(userid)
        .collection("Saved")
        .doc(widget.doc_id)
        .set({
      "collectionName": widget.collectionName,
      "doc_id": widget.doc_id,
      "name": widget.title,
      "price": widget.price,
      "image": widget.img,
      "type": widget.type,
      "availability": widget.availability,
    });
  }

  Future<void> _deleteSaved() {
    setState(() {
      contains = !contains;
    });
    return FirebaseFirestore.instance
        .collection("userdetails")
        .doc(userid)
        .collection("Saved")
        .doc(widget.doc_id)
        .delete();
  }

  void Contains() async {
    final snapShot = await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(userid)
        .collection("Saved")
        .doc(widget.doc_id)
        .get();

    if (snapShot.exists) {
      if (mounted) {
        setState(() {
          contains = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Contains();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 5),
      child: gcontainer(
        color: [
          Colors.teal.withOpacity(0.1),
          Colors.teal.withOpacity(0.3),
        ],
        cchild: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(25)),
                    image: new DecorationImage(
                        image: NetworkImage(widget.img), fit: BoxFit.fill)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.width! * 3),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.title.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText1!.merge(
                                  TextStyle(
                                    fontSize: SizeConfig.height! * 2,
                                  ),
                                )),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.type,
                            style: Theme.of(context).textTheme.bodyText1!.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
                                )),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.availability,
                            style: Theme.of(context).textTheme.bodyText1!.merge(
                                TextStyle(
                                    color: widget.availability == "Available"
                                        ? Colors.green
                                        : Colors.red))),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text("₹  " + widget.price,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(
                                        TextStyle(
                                            fontSize: SizeConfig.height! * 2,
                                            color:
                                                Theme.of(context).focusColor),
                                      )),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                contains
                                    ? _deleteSaved()
                                    : showdialog(context,
                                        "Food Item will be added to Favorites");
                              },
                              child: Container(
                                child: FaIcon(
                                  Icons.favorite,
                                  size: SizeConfig.height! * 3,
                                  color: contains
                                      ? Colors.pink
                                      : Theme.of(context).focusColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: DetailScreen(
                                        collectionName: widget.collectionName,
                                        productId: widget.doc_id,
                                        title: widget.title,
                                        img: widget.img,
                                        availability: widget.availability,
                                        price: widget.price,
                                        type: widget.type,
                                      ),
                                    );
                                  },
                                  animationType:
                                      DialogTransitionType.slideFromBottomFade,
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showdialog(BuildContext context, String text) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            text,
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
              txt: "Confirm",
              function: () {
                Navigator.pop(context);
                _addtoSaved();
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
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
}

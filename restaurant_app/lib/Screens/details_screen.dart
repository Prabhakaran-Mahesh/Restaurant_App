import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:restaurant_app/Widgets/Button.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class DetailScreen extends StatefulWidget {
  final String? productId;
  final String? collectionName;
  final String? img;
  final String? title;
  final String? availability;
  final String? price;
  final String? type;

  const DetailScreen(
      {this.productId,
      this.collectionName,
      this.img,
      this.title,
      this.availability,
      this.price,
      this.type});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool contains = false;
  int _itemCount = 1;
  String userid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> Contains() async {
    final snapShot = await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(userid)
        .collection("cart")
        .doc(widget.productId)
        .get();

    if (snapShot.exists) {
      setState(() {
        contains = true;
      });
    }
  }

  Future<void> _addtoCart() {
    return FirebaseFirestore.instance
        .collection("userdetails")
        .doc(userid)
        .collection("cart")
        .doc(widget.productId)
        .set({
      "Collection_name": widget.collectionName,
      "name": widget.title,
      "price": widget.price,
      "count": _itemCount.toString(),
      "image": widget.img,
      "type": widget.type,
      "doc_id": widget.productId,
    });
  }

  Future<void> _updateCart() {
    return FirebaseFirestore.instance
        .collection("userdetails")
        .doc(userid)
        .collection("cart")
        .doc(widget.productId)
        .update({
      "count": _itemCount.toString(),
    });
  }

  void _increment() {
    setState(() {
      _itemCount++;
    });
  }

  void _decrement() {
    setState(() {
      if (_itemCount > 1) {
        _itemCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection(widget.collectionName!)
              .doc(widget.productId)
              .get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> documentData = snapshot.data!.data();

              return Container(
                height: SizeConfig.height! * 50,
                width: SizeConfig.width! * 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: new DecorationImage(
                              image: NetworkImage(widget.img!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      size: SizeConfig.height! * 3,
                                      color: Colors.red.shade700,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Container(
                          height: double.infinity,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width! * 2,
                              vertical: SizeConfig.height! * 0.5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(35),
                                  bottomRight: Radius.circular(35))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width! * 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.title!.toUpperCase() +
                                          "  - ₹ " +
                                          widget.price!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .merge(TextStyle(
                                              fontSize:
                                                  SizeConfig.height! * 2.5)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${widget.type}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .merge(TextStyle(
                                              fontSize:
                                                  SizeConfig.height! * 2)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text(widget.availability!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .merge(TextStyle(
                                                      fontSize:
                                                          SizeConfig.height! *
                                                              2,
                                                      color:
                                                          widget.availability! ==
                                                                  'Available'
                                                              ? Colors.green
                                                              : Colors.red))),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: SizeConfig.height! * 5,
                                          width: SizeConfig.width! * 20,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: SizeConfig.height! * 3,
                                                ),
                                                onPressed: () => _decrement(),
                                                color: Colors.green,
                                              ),
                                              Text(
                                                _itemCount.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .merge(TextStyle(
                                                        color: Theme.of(context)
                                                            .focusColor)),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  size: SizeConfig.height! * 3,
                                                ),
                                                color: Colors.green,
                                                onPressed: () => _increment(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: SizedBox()),
                                        Expanded(
                                          flex: 3,
                                          child: GestureDetector(
                                            onTap: () {
                                              showdialog(context,
                                                  "Food Item will be added to cart");
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: SizeConfig.height! * 5,
                                              width: SizeConfig.width! * 10,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Theme.of(context)
                                                          .accentColor)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        SizeConfig.width! * 0.5,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .shopping_cart_outlined,
                                                    size:
                                                        SizeConfig.height! * 3,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                  Text(
                                                    "Add to Cart  ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
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
              function: () async {
                Navigator.pop(context);
                contains ? await _updateCart() : await _addtoCart();
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

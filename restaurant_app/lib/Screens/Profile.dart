import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/Screens/favorites.dart';
import 'package:restaurant_app/Screens/history.dart';
import 'package:restaurant_app/Screens/yourcart.dart';
import 'package:restaurant_app/main.dart';

import '../sizeConfig/sizeConfig.dart';

import 'profilebox.dart';

class profilepage extends StatefulWidget {
  final String name;
  final String email;
  final double number;
  final bool theme;

  const profilepage(
      {required this.name,
      required this.email,
      required this.number,
      required this.theme});

  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.height! * 1.5),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.chevron_left,
                                            size: SizeConfig.height! * 6,
                                            color:
                                                Theme.of(context).accentColor,
                                          )),
                                      Text(
                                        "Profile",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .merge(TextStyle(
                                                fontSize:
                                                    SizeConfig.height! * 4)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.all(
                                            SizeConfig.height! * 0.2),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: SizeConfig.width! * 2),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.name.toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .merge(TextStyle(
                                                      fontSize:
                                                          SizeConfig.height! *
                                                              3,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ),
                                            SizedBox(
                                              height: SizeConfig.height! * 1,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FaIcon(
                                                  Icons.phone_android,
                                                  size: SizeConfig.height! * 3,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.width! * 3,
                                                ),
                                                Text(
                                                    (widget.number)
                                                        .round()
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .merge(TextStyle(
                                                            fontSize: SizeConfig
                                                                    .height! *
                                                                1.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: SizeConfig.height! * 1,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FaIcon(
                                                  Icons.mail_outline,
                                                  size: SizeConfig.height! * 3,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.width! * 3,
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Text(
                                                    (widget.email).toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .merge(TextStyle(
                                                            fontSize: SizeConfig
                                                                    .height! *
                                                                1.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              height: SizeConfig.height! * 30,
                              width: SizeConfig.width! * 32,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(65),
                                      bottomRight: Radius.circular(65))),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                310,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                70,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: SizeConfig
                                                                  .width! *
                                                              3,
                                                          vertical: SizeConfig
                                                                  .height! *
                                                              2),
                                                      child: InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Icon(
                                                            Icons.cancel,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                            size: SizeConfig
                                                                    .height! *
                                                                4,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "Your Bitmoji",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .merge(TextStyle(
                                                          fontSize: SizeConfig
                                                                  .height! *
                                                              2.3)),
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeConfig.height! * 35,
                                                  width: SizeConfig.width! * 70,
                                                  child: Image.asset(
                                                    "assets/profile2.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeConfig.height! * 2,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Container(
                                                              height: SizeConfig
                                                                      .height! *
                                                                  30,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  70,
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height:
                                                          SizeConfig.height! *
                                                              5,
                                                      width: SizeConfig.width! *
                                                          50,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Text(
                                                        "Change Bitmoji",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .merge(TextStyle(
                                                                fontSize: SizeConfig
                                                                        .height! *
                                                                    2.5)),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: CircleAvatar(
                                        radius: SizeConfig.height! * 8,
                                        backgroundColor:
                                            Theme.of(context).accentColor,
                                        backgroundImage:
                                            AssetImage("assets/profile2.png"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
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
                                        builder: (context) => your_cart()));
                              },
                              child: profilebox(
                                img: "assets/cart.png",
                                name: "Your Cart",
                              ),
                            )),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => favorites()));
                                },
                                child: profilebox(
                                  img: "assets/fav.png",
                                  name: "Favorites",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => History()));
                                },
                                child: profilebox(
                                  img: "assets/history.png",
                                  name: "History",
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              helper_class2()));
                                },
                                child: profilebox(
                                  img: "assets/home.png",
                                  name: "Home",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: SizeConfig.height! * 6,
                      width: SizeConfig.width! * 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).accentColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: SizeConfig.height! * 4,
                          ),
                          SizedBox(
                            width: SizeConfig.width! * 1,
                          ),
                          Text(
                            "Logout",
                            style: Theme.of(context).textTheme.bodyText1!.merge(
                                TextStyle(
                                    fontSize: SizeConfig.height! * 3,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

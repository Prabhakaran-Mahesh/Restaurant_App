import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Screens/favorites.dart';
import 'package:restaurant_app/Screens/foods.dart';
import 'package:restaurant_app/Screens/history.dart';
import 'package:restaurant_app/Screens/yourcart.dart';
import 'package:restaurant_app/main.dart';
import 'package:rxdart/rxdart.dart';

import '../Style/appState.dart';
import '../Style/appTheme.dart';
import '../databaseHelper/profile_helper.dart';
import '../sizeConfig/sizeConfig.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  User? user = FirebaseAuth.instance.currentUser;

  String? id;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    id = user!.uid;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  bool a = true;
  double x = 0;
  bool theme = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 35,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.height! * 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Container(
                                height: SizeConfig.height! * 10,
                                width: SizeConfig.width! * 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: SizeConfig.height! * 5,
                                      backgroundColor:
                                          Colors.teal.withOpacity(0.3),
                                      backgroundImage:
                                          AssetImage("assets/profile2.png"),
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 6,
                            child: SizedBox(),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (theme == true) {
                                  setState(() {
                                    theme = false;
                                  });
                                } else {
                                  setState(() {
                                    theme = true;
                                  });
                                }
                                Provider.of<AppStateNotifier>(context,
                                        listen: false)
                                    .updateThemeOn(theme);
                              },
                              child: Container(
                                  height: 50,
                                  width: 100,
                                  color: Colors.transparent,
                                  child: !theme
                                      ? FaIcon(
                                          Icons.light_mode,
                                          size: SizeConfig.height! * 4,
                                          color:
                                              AppTheme.lightTheme.primaryColor,
                                        )
                                      : FaIcon(
                                          Icons.dark_mode,
                                          size: SizeConfig.height! * 4,
                                          color:
                                              AppTheme.darkTheme.primaryColor,
                                        )),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.width! * 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.height! * 1,
                      ),
                      StreamBuilder<Object>(
                          stream: FirebaseFirestore.instance
                              .collection("userdetails")
                              .doc(user!.uid)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            return Text(
                                "${snapshot.data['Name']}".toUpperCase(),
                                style: Theme.of(context).textTheme.subtitle1);
                          }),
                      Divider(
                          height: SizeConfig.height! * 2,
                          color: Theme.of(context).buttonColor),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: SizeConfig.height! * 62,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: Sidebar_list(
                                          Icons.person_outline,
                                          "Profile",
                                          Profile_helper(
                                            pId: id,
                                            theme: theme,
                                          )),
                                    )),
                                    Expanded(
                                      child: Container(
                                          child: Sidebar_list(
                                              Icons.wallet_giftcard,
                                              "Today's Special",
                                              foods(
                                                collectionName: "today'sDeal",
                                                title:
                                                    " Today's Deal ",
                                              ))),
                                    ),
                                    Expanded(
                                        child: Container(
                                      child: Sidebar_list(
                                          Icons.favorite_outline,
                                          "Favorites",
                                          favorites()),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Sidebar_list(
                                          Icons.shopping_cart_outlined,
                                          "Your Cart",
                                          your_cart()),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Sidebar_list(
                                          Icons.history_edu_outlined,
                                          "History",
                                          History()),
                                    )),
                                    Divider(
                                        height: SizeConfig.height! * 2,
                                        color: Theme.of(context).buttonColor),
                                    Expanded(
                                        child: Container(
                                      child: Sidebar_list(
                                          Icons.settings_outlined,
                                          "Settings",
                                          helper_class2()),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Sidebar_list(Icons.info_outline,
                                          "About", helper_class2()),
                                    )),
                                    Divider(
                                        height: SizeConfig.height! * 2,
                                        color: Theme.of(context).buttonColor),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.center,
                                      child: FlatButton(
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                          },
                                          color: Theme.of(context).accentColor,
                                          height: SizeConfig.height! * 5,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    SizeConfig.width! * 3),
                                            child: Text(
                                              "Logout",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .merge(TextStyle(
                                                      color: Theme.of(context)
                                                          .focusColor)),
                                            ),
                                          )),
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Transform.translate(
                offset: Offset(x, 0),
                child: Align(
                  alignment: Alignment(0, -0.9),
                  child: GestureDetector(
                    onTap: () {
                      a == true ? a = false : a = true;
                      a == true ? x = 0 : x = -SizeConfig.width! * 15.3;

                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 110,
                        color: Theme.of(context).primaryColor,
                        alignment: Alignment.centerLeft,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: Theme.of(context).accentColor,
                          size: SizeConfig.height! * 3.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile Sidebar_list(
    IconData icon,
    String txt,
    Widget wi,
  ) {
    return ListTile(
      leading: FaIcon(
        icon,
        color: Theme.of(context).buttonColor,
        size: SizeConfig.height! * 3,
      ),
      title: Text(
        txt,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .merge(TextStyle(fontSize: SizeConfig.height! * 2.15)),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => wi));
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

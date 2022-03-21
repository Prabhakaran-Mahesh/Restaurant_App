import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/Screens/search.dart';
import 'package:restaurant_app/Screens/yourcart.dart';

import 'Home.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int _selectedPage = 0;
  List<Widget> _tabs = [
    Home(),
    Search(),
    your_cart(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPage,
          unselectedItemColor: Theme.of(context).focusColor,
          onTap: (val) {
            setState(() {
              _selectedPage = val;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(
              icon: FaIcon(Icons.shopping_cart_outlined),
              title: Text("Cart"),
            ),
          ]),
      body: _tabs[_selectedPage],
    ));
  }
}

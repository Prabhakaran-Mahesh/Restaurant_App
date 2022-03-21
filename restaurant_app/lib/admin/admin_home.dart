import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/admin/add_items.dart';
import 'package:restaurant_app/admin/delevired.dart';
import 'package:restaurant_app/admin/delevired_helper.dart';
import 'package:restaurant_app/admin/received.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class admin_home extends StatefulWidget {
  const admin_home({Key? key}) : super(key: key);

  @override
  _admin_homeState createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {
  @override
  int _selectedPage = 0;
  List<Widget> _tabs = [Recevied(), add_item(), deleveypage()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: SizedBox(
        width: SizeConfig.width! * 18,
        height: SizeConfig.height! * 12,
        child: new FloatingActionButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.logout,
            color: Theme.of(context).primaryColor,
            size: SizeConfig.height! * 3,
          ),
        ),
      ),
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
                icon: FaIcon(Icons.add_alert), title: Text("Received")),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), title: Text("Add Items")),
            BottomNavigationBarItem(
              icon: FaIcon(Icons.check_box_rounded),
              title: Text("Delievered"),
            ),
          ]),
      body: _tabs[_selectedPage],
    ));
  }
}

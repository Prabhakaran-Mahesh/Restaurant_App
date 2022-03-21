import 'package:flutter/material.dart';

import '../Widgets/SideBar.dart';
import '../sizeConfig/sizeConfig.dart';
import 'HomePage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: <Widget>[
          HomePage(),
          SideBar(),
        ],
      ),
    ));
  }
}

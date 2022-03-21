import 'dart:ui';

import 'package:flutter/material.dart';

import '../sizeConfig/sizeConfig.dart';

// ignore: camel_case_types
class gcontainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? cchild;
  final List<Color>? color;

  const gcontainer({Key? key, this.height, this.width, this.cchild, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: color!,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                blurRadius: 16,
                spreadRadius: 16,
                color: Colors.white.withOpacity(0.01))
          ]),
      child: cchild,
    );
  }
}

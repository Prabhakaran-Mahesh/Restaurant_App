import 'package:flutter/material.dart';

// ignore: camel_case_types
class button extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String txt;
  final Function? function;
  const button(
      {Key? key,
      required this.height,
      required this.width,
      required this.color,
      required this.txt,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function as Function(),
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          txt,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .merge(TextStyle(color: Theme.of(context).focusColor)),
        ),
      ),
    );
  }
}

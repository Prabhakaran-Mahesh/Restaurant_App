import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/GContainer.dart';
import '../sizeConfig/sizeConfig.dart';

class profilebox extends StatelessWidget {
  final String? img;
  final String? name;

  const profilebox({this.img, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: gcontainer(
        color: [
          Theme.of(context).accentColor.withOpacity(0.1),
          Theme.of(context).accentColor.withOpacity(0.2)
        ],
        cchild: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: SizeConfig.height! * 12,
                width: SizeConfig.width! * 22,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                        image: AssetImage(img!), fit: BoxFit.fill)),
              ),
              SizedBox(
                height: SizeConfig.height! * 1,
              ),
              Text(
                name!,
                style: Theme.of(context).textTheme.subtitle1!.merge(
                    GoogleFonts.poppins(
                        fontSize: SizeConfig.height! * 2,
                        fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

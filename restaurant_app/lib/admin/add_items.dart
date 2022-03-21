import 'package:flutter/material.dart';
import 'package:restaurant_app/admin/all_food.dart';
import 'package:restaurant_app/admin/special_offers.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

import 'TodaySpecial.dart';

class add_item extends StatefulWidget {
  const add_item({Key? key}) : super(key: key);

  @override
  _add_itemState createState() => _add_itemState();
}

class _add_itemState extends State<add_item> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            image: new DecorationImage(
                                image: AssetImage("assets/hi.png"))),
                      ),
                    )),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: SizeConfig.width! * 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Welcome Admin!",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .merge(TextStyle(
                                          fontSize: SizeConfig.height! * 3)),
                                ),
                              ),
                              Divider(
                                height: SizeConfig.height! * 2,
                                color: Theme.of(context).focusColor,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              )),
              Expanded(
                child: DetailList(
                    context: context,
                    image: "assets/food.jpg",
                    name: "Food Items",
                    widgetname: all_food(
                      topic: "All Foods Items",
                    )),
              ),
              Expanded(
                  child: Container(
                child: DetailList(
                    context: context,
                    image: "assets/specialoffers.jpg",
                    name: "Special Offers",
                    widgetname: special_offers(
                      topic: "Special Offered Items",
                    )),
              )),
              Expanded(
                  child: DetailList(
                      context: context,
                      image: "assets/todaysdeal.png",
                      name: "Today Special's",
                      widgetname: TodaySpecial(
                        topic: "Today's Deal Food Items",
                      ))),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Container DetailList(
      {BuildContext? context,
      String? image,
      String? name,
      Widget? widgetname}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 5),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context!)
              .push(MaterialPageRoute(builder: (context) => widgetname!));
        },
        child: Container(
          height: SizeConfig.height! * 13,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context!).primaryColor.withOpacity(0.8),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: new DecorationImage(
                          image: AssetImage(
                            image!,
                          ),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      EdgeInsets.symmetric(horizontal: SizeConfig.width! * 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Text(
                    name!,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .merge(TextStyle(fontSize: SizeConfig.height! * 2.5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

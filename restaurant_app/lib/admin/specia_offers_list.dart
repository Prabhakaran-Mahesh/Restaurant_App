import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/Widgets/Button.dart';
import 'package:restaurant_app/admin/special_offers.dart';
import 'package:restaurant_app/admin/update_special_offers.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class special_offers_list extends StatefulWidget {
  final String? img;
  final String? name;
  final String? price;
  final String? availability;
  final String? type;
  final String? offer;

  final String? doc_id;
  const special_offers_list(
      {Key? key,
      this.img,
      this.name,
      this.price,
      this.availability,
      this.type,
      this.offer,
      this.doc_id})
      : super(key: key);

  @override
  _special_offers_listState createState() => _special_offers_listState();
}

class _special_offers_listState extends State<special_offers_list> {
  bool isSwitched = false;
  String? avail;

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;

        avail = "Not Available";
      });
    } else {
      setState(() {
        isSwitched = false;

        avail = "Available";
      });
    }

    Map<String, dynamic> data = {
      "availability": avail!,
    };

    FirebaseFirestore.instance
        .collection("specialOffers")
        .doc(widget.doc_id)
        .update(data);
  }

  void deleteItem() {
    FirebaseFirestore.instance
        .collection("specialOffers")
        .doc(widget.doc_id)
        .delete();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => special_offers(
                  topic: "Special Offered Items",
                )));
  }

  Future<void> _alertDialogBox() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              "The food item will delete permanently from the database",
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
                txt: "Confirm Delete",
                function: () {
                  Navigator.pop(context);
                  deleteItem();
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
        });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      avail = widget.availability!;
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 2),
      child: Container(
        height: SizeConfig.height! * 23,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: SizeConfig.height! * 4.5,
                      backgroundImage: NetworkImage(widget.img!),
                    ),
                  )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width! * 2),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: SizeConfig.width! * 2),
                                        child: Text(
                                          widget.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .merge(TextStyle(
                                                  fontSize: SizeConfig.height! *
                                                      2.2)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _alertDialogBox();
                                        },
                                        child: Container(
                                          child: FaIcon(
                                            Icons.delete,
                                            size: SizeConfig.height! * 2,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "₹ " + widget.price!,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            )),
                          ],
                        ),
                      )),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            height: SizeConfig.height! * 1.5,
                            child: Switch(
                              onChanged: (val) {
                                toggleSwitch(val);
                              },
                              value: widget.availability! == "Available"
                                  ? !isSwitched
                                  : isSwitched,
                              activeColor: Theme.of(context).focusColor,
                              activeTrackColor: Theme.of(context).accentColor,
                              inactiveTrackColor: Theme.of(context).focusColor,
                              inactiveThumbColor: Theme.of(context).accentColor,
                            ),
                          )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => update_special_offers(
                                          name: widget.name,
                                          price: widget.price,
                                          type: widget.type,
                                          img: widget.img,
                                          availability: widget.availability,
                                          doc_id: widget.doc_id,
                                        )));
                          },
                          child: Container(
                            child: Text("Edit",
                                style: Theme.of(context).textTheme.bodyText2),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Expanded(
              child: Divider(
                height: SizeConfig.height! * 2,
                color: Theme.of(context).buttonColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

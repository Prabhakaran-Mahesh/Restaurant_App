import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

import 'delevired_helper.dart';

class delevired_details extends StatelessWidget {
  final String? userid;
  final String? Name;
  final double? number;
  const delevired_details({Key? key, this.userid, this.Name, this.number})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String today_date = formatter.format(today);

    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            image: new DecorationImage(
                                image: AssetImage("assets/success.png"))),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Text("Completed orders",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2!.merge(
                                TextStyle(fontSize: SizeConfig.height! * 3.5))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width! * 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Name!.toUpperCase(),
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ))),
                            Expanded(
                                child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${number!.truncate()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          var num = (number!.truncate())
                                              .abs()
                                              .toString();
                                          await FlutterPhoneDirectCaller
                                              .callNumber(num);
                                          //launch(('tel://${num}'));
                                        },
                                        icon: Icon(Icons.call),
                                        color: Theme.of(context).accentColor,
                                        iconSize: SizeConfig.height! * 3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('Completed Order')
                                .doc(today_date)
                                .collection("Orders")
                                .doc(userid)
                                .collection("Orders")
                                .where("Date", isEqualTo: today_date)
                                .get(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Scaffold(
                                  body: Center(
                                    child: Text("error: ${snapshot.error}"),
                                  ),
                                );
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListView(
                                  children: snapshot.data!.docs
                                      .map<Widget>((document) {
                                    return Container(
                                      height: SizeConfig.height! * 70,
                                      child: deleveir_helper(
                                        userid: userid,
                                        id: document['Id'],
                                      ),
                                    );
                                  }).toList(),
                                );
                              }

                              return Scaffold(
                                body: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}

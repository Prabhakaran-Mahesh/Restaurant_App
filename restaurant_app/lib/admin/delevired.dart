import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/admin/delevired_details.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class deleveypage extends StatelessWidget {
  const deleveypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String today_date = formatter.format(today);

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
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        width: SizeConfig.width! * 1,
                        decoration: BoxDecoration(
                            image: new DecorationImage(
                                image: AssetImage("assets/success.png"),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Today Delivered Orders",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2!.merge(
                              TextStyle(fontSize: SizeConfig.height! * 4)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Completed Order')
                      .doc(today_date)
                      .collection("Orders")
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                        body: Center(
                          child: Text("error: ${snapshot.error}"),
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: ListView(
                          children: snapshot.data!.docs.map<Widget>((document) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.width! * 3,
                                  vertical: SizeConfig.height! * 1),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => delevired_details(
                                            userid: document['User Id'],
                                            Name: document['Name'],
                                            number: document['Number'],
                                          )));
                                },
                                child: Container(
                                  height: SizeConfig.height! * 12,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.width! * 3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: SizeConfig.height! * 1,
                                        ),
                                        Expanded(
                                            child: Text(
                                          "${document['Name']}".toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .merge(TextStyle(
                                                  fontSize: SizeConfig.height! *
                                                      2.5)),
                                        )),
                                        SizedBox(
                                          height: SizeConfig.height! * 1,
                                        ),
                                        Expanded(
                                            child: Text(document['Number']
                                                .toString()
                                                .split(".")
                                                .first)),
                                        // SizedBox(height: SizeConfig.height! * 0.5,),
                                        Divider(
                                          thickness: 3,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }

                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/foodList.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

import '../main.dart';

class favorites extends StatefulWidget {
  const favorites({Key? key}) : super(key: key);

  @override
  _favoritesState createState() => _favoritesState();
}

class _favoritesState extends State<favorites> {
  String userid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: SizeConfig.height! * 25,
                          width: SizeConfig.width! * 2,
                          decoration: BoxDecoration(
                              image: new DecorationImage(
                                  image: AssetImage("assets/history.png"),
                                  fit: BoxFit.fill)),
                        ),
                      )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.height! * 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Favorites  🍱",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .merge(TextStyle(
                                              fontSize:
                                                  SizeConfig.height! * 4)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: SizeConfig.height! * 2,
                                  color: Theme.of(context).focusColor,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("  Back    ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  height: double.infinity,
                  child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("userdetails")
                        .doc(userid)
                        .collection("Saved")
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("Error : ${snapshot.error}"),
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        return snapshot.data!.docs.isEmpty
                            ? Center(
                                child: Column(
                                children: [
                                  Container(
                                    height: SizeConfig.height! * 40,
                                    width: SizeConfig.width! * 60,
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image:
                                                AssetImage("assets/empty.png"),
                                            fit: BoxFit.fill)),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.height! * 5,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "No Favorites",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(TextStyle(
                                                fontSize:
                                                    SizeConfig.height! * 3)),
                                      )),
                                ],
                              ))
                            : Container(
                                height: SizeConfig.height! * 250,
                                child: ListView(
                                    children:
                                        snapshot.data!.docs.map((document) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: SizeConfig.height! * 14,
                                      child: food_list(
                                        name: document['name'],
                                        img: document['image'],
                                        price: document['price'],
                                        type: document['type'],
                                        availability: document['availability'],
                                        collectionName:
                                            document['collectionName'],
                                        doc_id: document['doc_id'],
                                      ),
                                    ),
                                  );
                                }).toList()),
                              );
                      }
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

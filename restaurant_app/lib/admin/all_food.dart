import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/admin/add_all_food.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

import 'all_food_list.dart';

class all_food extends StatefulWidget {
  final String? topic;
  const all_food({Key? key, this.topic}) : super(key: key);

  @override
  _all_foodState createState() => _all_foodState();
}

class _all_foodState extends State<all_food> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("allFood");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: SizeConfig.width! * 18,
          height: SizeConfig.height! * 12,
          child: new FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => add_allFood()));
            },
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
              size: SizeConfig.height! * 3,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
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
                      child: Icon(Icons.chevron_left,
                          color: Theme.of(context).accentColor,
                          size: SizeConfig.height! * 5),
                    ),
                  )),
                  Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.topic! + "  🍱",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .merge(TextStyle(
                                      fontSize: SizeConfig.height! * 3)),
                            ),
                          ),
                          Divider(
                            height: SizeConfig.height! * 2,
                            color: Theme.of(context).focusColor,
                          ),
                        ],
                      )),
                ],
              ),
            )),
            Expanded(
                flex: 6,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Expanded(
                    child: FutureBuilder<QuerySnapshot>(
                      future: _collectionReference.get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Scaffold(
                            body: Center(
                              child: Text("Error : ${snapshot.error}"),
                            ),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            height: SizeConfig.height! * 250,
                            child: ListView(
                                children: snapshot.data!.docs.map((document) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: SizeConfig.height! * 14,
                                  child: all_food_list(
                                    name: document['name'],
                                    img: document['image'],
                                    price: document['price'],
                                    availability: document['availability'],
                                    type: document['type'],
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
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

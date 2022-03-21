import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:restaurant_app/Screens/foods.dart';
import 'package:restaurant_app/Widgets/foodContainer.dart';

import '../sizeConfig/sizeConfig.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _collectionReference1 =
      FirebaseFirestore.instance.collection("today'sDeal");
  final CollectionReference _collectionReference2 =
      FirebaseFirestore.instance.collection("specialOffers");
  final CollectionReference _collectionReference3 =
      FirebaseFirestore.instance.collection("allFood");

  int s = 0;

  bool ans = true;
  Future<void> lengthData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("allFood").get();
    final alldata = querySnapshot.docs.map((e) => e.data()).toList();
    var size = alldata.length;

    setState(() {
      this.s = size;
    });
  }

  List<Widget> list = [];

  Future<void> listofWidget(AsyncSnapshot snapshot) async {
    final list1 = snapshot.data.docs.map<Widget>((document) {
      return Container(
        height: SizeConfig.height! * 20,
        child: food_container(
            collectionName: "allFood",
            doc_id: document['doc_id'],
            img: document['image'],
            title: document['name'],
            type: document['type'],
            availability: document['availability'],
            price: document['price']),
      );
    }).toList();

    this.list = list1;
  }

  var _sliderKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.height! * 5),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        child: Image.asset(
                          "assets/cook.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: SizeConfig.width! * 5),
                          child: Text(
                            "WELCOME  \n RESTAURANT NAME  🍔",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline1!.merge(
                                TextStyle(
                                    fontSize: SizeConfig.height! * 3.1,
                                    fontWeight: FontWeight.w800)),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              height: SizeConfig.height! * 90,
              margin: EdgeInsets.only(top: SizeConfig.height! * 3),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width! * 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Today's Deal",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .merge(TextStyle(
                                  color: Theme.of(context).buttonColor,
                                  fontSize: SizeConfig.height! * 3,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Container(
                              child: FutureBuilder<QuerySnapshot>(
                                future: _collectionReference1.get(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Scaffold(
                                      body: Center(
                                        child:
                                            Text("Error : ${snapshot.error}"),
                                      ),
                                    );
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      height: SizeConfig.height! * 21,
                                      width: double.infinity,
                                      child: PageView(
                                          scrollDirection: Axis.horizontal,
                                          children: snapshot.data!.docs
                                              .map((document) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      SizeConfig.height! * 1),
                                              child: Container(
                                                height: SizeConfig.height! * 18,
                                                child: food_container(
                                                    collectionName:
                                                        "today'sDeal",
                                                    doc_id: document['doc_id'],
                                                    img: document['image'],
                                                    title: document['name'],
                                                    type: document['type'],
                                                    availability: document[
                                                        'availability'],
                                                    price: document['price']),
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
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width! * 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Special Offers",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .merge(TextStyle(
                                  color: Theme.of(context).buttonColor,
                                  fontSize: SizeConfig.height! * 3,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Container(
                              child: FutureBuilder<QuerySnapshot>(
                                future: _collectionReference2.get(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Scaffold(
                                      body: Center(
                                        child:
                                            Text("Error : ${snapshot.error}"),
                                      ),
                                    );
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      height: SizeConfig.height! * 21,
                                      width: double.infinity,
                                      child: PageView(
                                          scrollDirection: Axis.horizontal,
                                          children: snapshot.data!.docs
                                              .map((document) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      SizeConfig.height! * 1),
                                              child: Container(
                                                height: SizeConfig.height! * 18,
                                                child: food_container(
                                                    collectionName:
                                                        "specialOffers",
                                                    doc_id: document['doc_id'],
                                                    img: document['image'],
                                                    title: document['name'],
                                                    type: document['type'],
                                                    availability: document[
                                                        'availability'],
                                                    price: document['price']),
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
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.width! * 5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "All Foods",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .merge(TextStyle(
                                        color: Theme.of(context).buttonColor,
                                        fontSize: SizeConfig.height! * 3,
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.width! * 2),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => foods(
                                                collectionName: "allFood",
                                                title: "RESTAURANT NAME - MENU",
                                              )));
                                },
                                child: Text(
                                  "View All",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(TextStyle(
                                          decoration:
                                              TextDecoration.underline)),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: FutureBuilder<QuerySnapshot>(
                            future: _collectionReference3.get(),
                            builder: (context, snapshot) {
                              if (ans == true) {
                                lengthData();
                                ans = false;
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                listofWidget(snapshot);
                                return SizedBox(
                                    height: SizeConfig.height! * 25,
                                    child: PageView(children: <Widget>[
                                      Container(
                                          height: SizeConfig.height! * 25,
                                          child: CarouselSlider.builder(
                                              key: _sliderKey,
                                              unlimitedMode: false,
                                              slideBuilder: (index) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: list[index],
                                                );
                                              },
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5))
                                    ]));
                              }
                              return Scaffold(
                                body: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ))
                    ],
                  )),
                ],
              ),
            ),
          )),
        ],
      )
    ]));
  }

  Expanded HappyFoods(String img, String txt) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: SizeConfig.height! * 5,
          backgroundImage: AssetImage(img),
        ),
        Text(txt)
      ],
    ));
  }
}

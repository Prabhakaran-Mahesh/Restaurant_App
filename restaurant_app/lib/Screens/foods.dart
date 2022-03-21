import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/Widgets/foodContainer.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class foods extends StatefulWidget {
  final String? collectionName;
  final String? title;
  const foods({Key? key, this.collectionName, this.title}) : super(key: key);

  @override
  _foodsState createState() => _foodsState();
}

class _foodsState extends State<foods> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _collectionReference =
        FirebaseFirestore.instance.collection(widget.collectionName!);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.height! * 2),
          child: Column(
            children: [
             Expanded(child: Container(child: Row(
              children: [
              GestureDetector(
              onTap: () {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
        builder: (Context) => helper_class2()));
        },
          child: FaIcon(
            Icons.chevron_left,
            size: SizeConfig.height! * 4,
            color: Theme.of(context).buttonColor,
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: SizeConfig.width!*90,
          child: Text(widget.title!,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .merge(TextStyle(
                color: Theme.of(context).buttonColor,
                fontSize: SizeConfig.height! * 2,
                fontWeight: FontWeight.w800,
              ))),
        ),
        ],
      ),
    ),),
              Expanded(
                flex: 10,
                  child:Container(child: FutureBuilder<QuerySnapshot>(
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
    return snapshot.data!.docs.isEmpty
    ? Center(
    child: Column(
    children: [
    Container(
    height: SizeConfig.height! * 40,
    width: SizeConfig.width! * 60,
    decoration: BoxDecoration(
    image: new DecorationImage(
    image: AssetImage(
    "assets/empty.png"),
    fit: BoxFit.fill)),
    ),
    SizedBox(
    height: SizeConfig.height! * 5,
    ),
    Container(
    alignment: Alignment.center,
    child: Text(
    "Your cart is empty !",
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
    height: SizeConfig.height! * 18,
    child: food_container(
    collectionName:
    widget.collectionName!,
    doc_id: document['doc_id'],
    img: document['image'],
    title: document['name'],
    type: document['type'],
    availability:
    document['availability'],
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
    ),)
            ],
          ),
        ),
      ),
    );
  }
}

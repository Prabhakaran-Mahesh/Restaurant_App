import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/foodContainer.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool contains = true;
  void Contains() async {
    final snapShot = await FirebaseFirestore.instance
        .collection("allFood")
        .orderBy("name")
        .startAfter([_searchString]).endAt(["$_searchString\uf8ff"]).get();

    if (snapShot.docs.isEmpty) {
      if (mounted) {
        contains = false;
      }
    } else {
      if (mounted) {
        contains = true;
      }
    }
  }

  String _searchString = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        if (_searchString.isEmpty)
          Center(
            child: Container(
              child: Text(
                "Search Results",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          )
        else
          FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("allFood")
                  .orderBy("name")
                  .startAfter([_searchString]).endAt(
                      ["$_searchString\uf8ff"]).get(),
              builder: (context, AsyncSnapshot snapshot) {
                Contains();
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("error: ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return contains
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.height! * 15,
                              bottom: SizeConfig.height! * 1),
                          child: ListView(
                            children:
                                snapshot.data!.docs.map<Widget>((document) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.height! * 1),
                                child: Container(
                                  height: SizeConfig.height! * 18,
                                  child: food_container(
                                    title: document['name'],
                                    img: document['image'],
                                    price: document['price'],
                                    collectionName: "allFood",
                                    availability: document['availability'],
                                    doc_id: document['doc_id'],
                                    type: document['type'],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : Center(
                          child: Container(
                              height: SizeConfig.height! * 10,
                              child: Text("No results Found")));
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 5),
            height: SizeConfig.height! * 7,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border:
                    Border.all(width: 2, color: Theme.of(context).accentColor)),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchString = val.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.bodyText1,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width! * 2,
                    vertical: SizeConfig.height! * 2),
                prefixIcon: Icon(
                  Icons.search,
                  size: SizeConfig.height! * 4,
                  color: Theme.of(context).accentColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

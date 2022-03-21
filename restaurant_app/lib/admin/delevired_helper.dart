import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class deleveir_helper extends StatefulWidget {
  final String? userid;
  final String? id;

  const deleveir_helper({Key? key, this.id, this.userid}) : super(key: key);

  @override
  _deleveir_helperState createState() => _deleveir_helperState();
}

class _deleveir_helperState extends State<deleveir_helper> {
  double? total_amount;
  int? count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalnum();
    getTotal();
  }

  Future getTotal() async {
    var today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String today_date = formatter.format(today);

    await FirebaseFirestore.instance
        .collection('Completed Order')
        .doc(today_date)
        .collection("Orders")
        .doc(widget.userid)
        .collection("Orders")
        .doc(widget.id)
        .collection("Order Data")
        .snapshots()
        .listen((snapshot) {
      double total = snapshot.docs.fold(
          0,
          (tot, doc) =>
              tot +
              (double.parse(doc.data()['price']) *
                  double.parse(doc.data()['count'])));
      setState(() {
        this.total_amount = total;
      });
    });
  }

  Future getTotalnum() async {
    var today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String today_date = formatter.format(today);

    await FirebaseFirestore.instance
        .collection('Completed Order')
        .doc(today_date)
        .collection("Orders")
        .doc(widget.userid)
        .collection("Orders")
        .doc(widget.id)
        .collection("Order Data")
        .snapshots()
        .listen((snapshot) {
      int total = snapshot.docs
          .fold(0, (tot, doc) => tot + int.parse(doc.data()['count']));
      setState(() {
        this.count = total;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String today_date = formatter.format(today);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: SizeConfig.height! * 10,
        width: SizeConfig.width! * 15,
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('Completed Order')
                .doc(today_date)
                .collection("Orders")
                .doc(widget.userid)
                .collection("Orders")
                .doc(widget.id)
                .collection("Order Data")
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
                return Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: ListView(
                          children: snapshot.data!.docs.map<Widget>((document) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.width! * 1,
                                  vertical: SizeConfig.height! * 1),
                              child: Container(
                                  height: SizeConfig.height! * 12,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15)),
                                                image: new DecorationImage(
                                                    image: NetworkImage(
                                                        document['image']),
                                                    fit: BoxFit.fill))),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "${document['name']}"
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .merge(
                                                    TextStyle(
                                                        fontSize:
                                                            SizeConfig.height! *
                                                                2.5),
                                                  )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Count",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .merge(TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentColor)),
                                                ),
                                              )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        document['count'],
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .headline1!
                                                                .merge(
                                                                  TextStyle(
                                                                      fontSize:
                                                                          SizeConfig.height! *
                                                                              4),
                                                                )),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: SizeConfig.width! * 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: SizeConfig.width! * 0.5,
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Total Count: ",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ))),
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${count}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .merge(TextStyle(
                                                fontSize:
                                                    SizeConfig.height! * 2.5,
                                                color: Theme.of(context)
                                                    .focusColor)),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Total Amount: ",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ))),
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "₹ ${total_amount}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .merge(TextStyle(
                                                fontSize:
                                                    SizeConfig.height! * 2.5,
                                                color: Theme.of(context)
                                                    .focusColor)),
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: SizeConfig.height! * 2),
                          alignment: Alignment.center,
                          child: Text(
                            "BACK TO LIST",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:restaurant_app/Widgets/Button.dart';
import 'package:restaurant_app/Widgets/foodList.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class your_cart extends StatefulWidget {
  const your_cart({Key? key}) : super(key: key);

  @override
  _your_cartState createState() => _your_cartState();
}

class _your_cartState extends State<your_cart> {
  String userid = FirebaseAuth.instance.currentUser!.uid;
  double total_amount = 0;
  int count = 0;
  String? status = "NO ORDERS YET";

  String? name;
  double? mobile;

  Future getname() async {
    await FirebaseFirestore.instance
        .collection('userdetails')
        .doc(userid)
        .get()
        .then((snap) {
      this.name = snap.data()!['Name'].toString();
      this.mobile = snap.data()!['Mobile'].toDouble();
    });
  }

  Future getStatus() async {
    var Snapshot = await FirebaseFirestore.instance
        .collection("orders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (Snapshot.exists) {
      setState(() {
        this.status = Snapshot.get('status').toString();
      });
    }
  }

  Future orderdata() async {
    print(this.name);
    var snapshot = await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .get()
        .then((snap) {
      snap.docs.forEach((doc) async {
        await FirebaseFirestore.instance
            .collection("orders")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "Total Amount": this.total_amount,
          "Total Count": this.count,
          "Name": this.name,
          "Time": DateTime.now(),
          "Mobile": this.mobile,
          "status": "Order Received",
          "User Id": userid
        }).whenComplete(() => {
                  FirebaseFirestore.instance
                      .collection("orders")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orders")
                      .add(doc.data())
                });
      });
    });
  }

  Future histroyorder() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .get()
        .then((snap) {
      snap.docs.forEach((doc) async {
        await FirebaseFirestore.instance
            .collection("userdetails")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("History")
            .doc(doc.data()['doc_id'])
            .set(doc.data());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
    getStatus();
    getTotal();
    getTotalnum();
  }

  Future getTotal() async {
    await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(userid)
        .collection("cart")
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
    await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(userid)
        .collection("cart")
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
                          decoration: BoxDecoration(
                              image: new DecorationImage(
                                  image: AssetImage("assets/cart.png"),
                                  fit: BoxFit.fill)),
                        ),
                      )),
                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "  Your Cart  🍱",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .merge(TextStyle(
                                          fontSize: SizeConfig.height! * 3.5)),
                                ),
                              ),
                              Divider(
                                height: SizeConfig.height! * 2,
                                color: Theme.of(context).focusColor,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Order Status : " + '$status'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .merge(TextStyle(
                                          fontSize: SizeConfig.height! * 2)),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                )),
            Expanded(
                flex: 8,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("userdetails")
                      .doc(userid)
                      .collection("cart")
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
                                    height: SizeConfig.height! * 14,
                                    child: food_list(
                                      name: document['name'],
                                      img: document['image'],
                                      price: document['price'],
                                      type: document['type'],
                                      count: document['count'],
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
                )),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.width! * 2),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.width! * 0.5,
                                      ),
                                      Expanded(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Items: ",
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
                                                      color: Theme.of(context)
                                                          .focusColor)),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.width! * 2),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.width! * 0.5,
                                      ),
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
                                                          SizeConfig.height! *
                                                              2.5,
                                                      color: Theme.of(context)
                                                          .focusColor)),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          height: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.width! * 2),
                                  child: button(
                                    txt: "Continue Shopping",
                                    height: SizeConfig.height! * 4,
                                    width: SizeConfig.width! * 45,
                                    color: Theme.of(context).accentColor,
                                    function: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  helper_class2()));
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.width! * 2),
                                  child: button(
                                    txt: "Buy Now",
                                    height: SizeConfig.height! * 4,
                                    width: SizeConfig.width! * 45,
                                    color: Theme.of(context).accentColor,
                                    function: () {
                                      showdialog(context, "Place Order !!");
                                    },
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future showdialog(BuildContext context, String text) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            text,
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
              txt: "Confirm",
              function: () {
                Navigator.pop(context);
                orderdata();
                histroyorder();
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
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
}

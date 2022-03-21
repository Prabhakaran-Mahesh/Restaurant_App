import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/admin/recieved_order.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class Recevied extends StatefulWidget {
  @override
  _ReceviedState createState() => _ReceviedState();
}

class _ReceviedState extends State<Recevied> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                              image: AssetImage("assets/order.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Received Orders",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.merge(
                            TextStyle(fontSize: SizeConfig.height! * 4.3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: double.infinity,
              child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('orders').get(),
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
                            return recievedOrders(
                              name: document['Name'],
                              time: document['Time'],
                              Total_Amount: document['Total Amount'],
                              Total_count: document['Total Count'],
                              number: document['Mobile'],
                              status: document['status'],
                              uid: document['User Id'],
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
          ),
        ],
      ),
    );
  }
}

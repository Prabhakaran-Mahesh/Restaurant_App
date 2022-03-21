import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/admin/recieved_details.dart';
import 'package:restaurant_app/sizeConfig/sizeConfig.dart';

class recievedOrders extends StatelessWidget {
  final String? name;
  final double? number;
  final double? Total_Amount;
  final int? Total_count;
  final Timestamp? time;
  final String? status;
  final String? uid;

  const recievedOrders(
      {this.name,
      this.number,
      this.Total_Amount,
      this.Total_count,
      this.time,
      this.status,
      this.uid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width! * 3, vertical: SizeConfig.height! * 1),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ResDetails(
                    name: name,
                    number: number,
                    Total_Amount: Total_Amount,
                    Total_count: Total_count,
                    time: time,
                    userid: uid,
                    status: status,
                  )));
        },
        child: Expanded(
          child: Container(
            height: SizeConfig.height! * 12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          name!,
                          style: Theme.of(context).textTheme.subtitle1,
                        )),
                        Expanded(
                          child: Text(
                            status!,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .merge(TextStyle(color: Colors.green)),
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          "${time!.toDate()}",
                        ))
                      ],
                    ),
                  )),
                  Divider(
                    thickness: 3,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

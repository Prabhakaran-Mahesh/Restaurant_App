import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Service {
  static String? name;
  static String? email;
  static double? mobile;
  static String? password;
  static String? uid;

  static User? user = FirebaseAuth.instance.currentUser;

  static void getdata() {
    StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("userdetails")
          .doc(user!.uid)
          .snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs.data();
              name = data['Name'];
              email = data['E-Mail'];
              mobile = data['Mobile'];
              password = data['Password'];
              uid = data['UID'];
              print("Hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii" + name!);

              return Container();
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Screens/Profile.dart';

class Profile_helper extends StatefulWidget {
  final String? pId;
  final bool? theme;
  const Profile_helper({Key? key, this.pId, this.theme}) : super(key: key);

  @override
  _Profile_helperState createState() => _Profile_helperState();
}

class _Profile_helperState extends State<Profile_helper> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("userdetails");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: _collectionReference.doc(widget.pId).get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> docData = snapshot.data.data();
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: profilepage(
                      name: docData['Name'],
                      number: docData['Mobile'],
                      email: docData['E-mail'],
                      theme: widget.theme!,
                    ),
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
    );
  }
}

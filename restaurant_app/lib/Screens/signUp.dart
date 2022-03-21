import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/Button.dart';
import '../Widgets/GContainer.dart';
import '../Widgets/TextField.dart';
import '../sizeConfig/sizeConfig.dart';
import 'signIn.dart';

class RIKeys {
  static final riKey1 = GlobalKey<FormState>();
  static final riKey2 = GlobalKey<FormState>();
  static final riKey3 = GlobalKey<FormState>();
  static final riKey4 = GlobalKey<FormState>();
}

// ignore: camel_case_types
class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  _signUpState createState() => _signUpState();
}

// ignore: camel_case_types
class _signUpState extends State<signUp> {
  String? name = "";
  String? email = "";
  double? mobile = 0;
  String? password = "";

  Future<String?> _signup() async {
    try {
      final User? currentUSer = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email!, password: password!))
          .user;
      Map<String, dynamic> data = {
        "Uid": currentUSer!.uid,
        "Name": name,
        "E-mail": email,
        "Mobile": mobile,
        "role" : "user"
      };
      FirebaseFirestore.instance
          .collection("userdetails")
          .doc(currentUSer.uid)
          .set(data);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak_passwod') {
        return "The password is too week";
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exist';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
            content: Container(
              child: Text(
                error,
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close Dialog",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  void _submitform() async {
    String? feedback = await _signup();
    if (feedback != null) {
      _alertDialogBox(feedback);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    bottom = max(min(bottom, SizeConfig.height! * 8), -1);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.black.withOpacity(0.0)),
              ),
            ),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width! * 3,
                    vertical: SizeConfig.height! * 1),
                child: Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(
                height: SizeConfig.height! * 0.5,
              ),
              gcontainer(
                height: SizeConfig.height! * 70,
                width: SizeConfig.width! * 95,
                color: [
                  Colors.white.withOpacity(0.2),
                  Colors.white38.withOpacity(0.2)
                ],
                cchild: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width! * 8,
                        ),
                        child: Text(
                          "Looks like you don't have an account.\nLet's create a new account..!",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.height! * 2,
                      ),
                      textField(
                        key: RIKeys.riKey1,
                        txt: "Name",
                        obscure: false,
                        function: (val) {
                          name = val;
                        },
                        validate: (value) {
                          if (value!.isEmpty && value == "") {
                            return "Name should not be left empty";
                          }
                        },
                      ),
                      textField(
                        key: RIKeys.riKey2,
                        txt: "Phone Number",
                        obscure: false,
                        type: TextInputType.number,
                        length: 10,
                        function: (val) {
                          setState(() {
                            mobile = double.parse(val);
                          });
                        },
                        validate: (value) {
                          if (value!.isEmpty &&
                              value == "" &&
                              value.length != 10) {
                            return "Phone Number should not be left empty";
                          }
                        },
                      ),
                      textField(
                        key: RIKeys.riKey3,
                        txt: "Email",
                        obscure: false,
                        function: (val) {
                          email = val;
                        },
                        validate: (value) {
                          if (value!.isEmpty && value == "") {
                            return "Email should not be left empty";
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: bottom),
                        child: textField(
                          key: RIKeys.riKey4,
                          txt: "Password",
                          obscure: true,
                          function: (val) {
                            password = val;
                          },
                          validate: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Password should not be left empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.height! * 2,
                      ),
                      button(
                        height: SizeConfig.height! * 5,
                        width: SizeConfig.width! * 40,
                        color: Colors.teal.shade300,
                        txt: "Submit",
                        function: () {
                          if (!RIKeys.riKey1.currentState!.validate()) {
                            _alertDialogBox("Name should not be left Empty");
                          } else {
                            if (!RIKeys.riKey2.currentState!.validate()) {
                              _alertDialogBox(
                                  "Phone Number should not be left Empty");
                            } else {
                              if (!RIKeys.riKey3.currentState!.validate()) {
                                _alertDialogBox(
                                    "Email should not be left Empty");
                              } else {
                                if (!RIKeys.riKey4.currentState!.validate()) {
                                  _alertDialogBox(
                                      "Password should not be left Empty");
                                } else {
                                  _submitform();
                                }
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.height! * 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signIn()));
                        },
                        child: Text(
                          "Already an user?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .merge(TextStyle(
                                decoration: TextDecoration.underline,
                                decorationThickness: 1.5,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.height! * 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    ));
  }
}

import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Style/appTheme.dart';
import '../Widgets/Button.dart';
import '../Widgets/GContainer.dart';
import '../Widgets/TextField.dart';
import '../sizeConfig/sizeConfig.dart';
import 'signUp.dart';

class RIKeys {
  static final riKey1 = GlobalKey<FormState>();
  static final riKey2 = GlobalKey<FormState>();
}

class signIn extends StatefulWidget {
  const signIn({Key? key}) : super(key: key);

  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  String? email = "";
  String? password = "";

  String? role;
  Future<void> checkrole() async {
    User user = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(user.uid)
        .get();
    setState(() {
      role = snap['role'];
    });
  }

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password is too week";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exist for that email";
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
    String? feedback = await _loginAccount();
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
    bottom = max(min(bottom, 10), -1);
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
                  "Sign In",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(
                height: SizeConfig.height! * 0.5,
              ),
              gcontainer(
                height: SizeConfig.height! * 50,
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
                          "Welcome Back.You've been missed.\nLet's sign you in..!",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.height! * 2,
                      ),
                      textField(
                        key: RIKeys.riKey1,
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
                          key: RIKeys.riKey2,
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
                            _alertDialogBox("Email should not be left Empty");
                          } else {
                            if (!RIKeys.riKey2.currentState!.validate()) {
                              _alertDialogBox(
                                  "Password should not be left Empty");
                            } else {
                              _submitform();
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
                                  builder: (context) => signUp()));
                        },
                        child: Text(
                          "Doesn't have an account?",
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

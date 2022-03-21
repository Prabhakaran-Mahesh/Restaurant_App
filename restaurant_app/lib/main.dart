import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Screens/Main_home.dart';
import 'package:restaurant_app/admin/admin_home.dart';
import 'Screens/connectivity_checker.dart';
import 'Screens/signIn.dart';
import 'Style/appState.dart';
import 'Style/appTheme.dart';
import 'sizeConfig/sizeConfig.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: MaterialApp(
        home: Helperclass(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class Helperclass extends StatelessWidget {
  const Helperclass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checker();
  }
}

class helper_class3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        home: admin_home(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appState.isDarkModeOn ? ThemeMode.light : ThemeMode.dark,
      );
    });
  }
}

class helper_class2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        home: MainHome(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appState.isDarkModeOn ? ThemeMode.light : ThemeMode.dark,
      );
    });
  }
}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        home: signIn(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appState.isDarkModeOn ? ThemeMode.light : ThemeMode.dark,
      );
    });
  }
}

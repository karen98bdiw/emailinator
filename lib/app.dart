import 'package:emailinator/constats.dart';
import 'package:emailinator/email.dart';
import 'package:emailinator/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Email(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: mainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Home.routeName,
        routes: {
          Home.routeName: (c) => Home(),
        },
      ),
    );
  }
}

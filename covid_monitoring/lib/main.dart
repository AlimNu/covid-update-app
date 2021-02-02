import 'package:covid_monitoring/constant.dart';
import 'file:///E:/DATA/Github/Flutter_Project/covid-update-app/covid_monitoring/lib/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white60,
      ),
      home: HomeScreen(),
    );
  }
}


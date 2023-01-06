import 'package:flutter/material.dart';
import 'package:flutter_web_scraper/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String title = 'Flutter Web Scraper';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: title),
    );
  }
}

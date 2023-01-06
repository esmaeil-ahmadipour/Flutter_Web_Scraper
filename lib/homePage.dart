import 'package:flutter/material.dart';
import 'package:flutter_web_scraper/detectIpPage.dart';
import 'package:flutter_web_scraper/loadPhotoPage.dart';
import 'package:flutter_web_scraper/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final String detectIp = "Detect IP";
    final String loadPhoto = "Load Photo";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          CustomizedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return DetectIpPage(title: detectIp);
              }));
            },
            title: detectIp,
          ),
          CustomizedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return LoadPhotoPage(title: loadPhoto);
              }));
            },
            title: loadPhoto,
          ),
        ],
      ),
    );
  }
}

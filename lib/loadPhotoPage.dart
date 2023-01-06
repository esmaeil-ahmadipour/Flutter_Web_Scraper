import 'package:flutter/material.dart';
import 'package:flutter_web_scraper/widgets.dart';
import 'package:web_scraper/web_scraper.dart';

class LoadPhotoPage extends StatefulWidget {
  LoadPhotoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoadPhotoPageState createState() => _LoadPhotoPageState();
}

class _LoadPhotoPageState extends State<LoadPhotoPage> {
  List<Map<String, dynamic>>? webScrapeResult;
  final String baseUrl = 'https://www.w3schools.com';
  final String urlPath2 = '/css/';
  final String urlPath3 = 'css_image_gallery.asp';
  final WebScraper webScraper = WebScraper('https://www.w3schools.com');
  final String innerAddress = 'div.img > a > img';
  final List<String> attributeList = ['src'];

  void fetchData() async {
    if (await webScraper.loadWebPage(urlPath2 + urlPath3)) {
      setState(() {
        webScrapeResult = webScraper.getElement(innerAddress, attributeList);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: webScrapeResult == null
          ? Center(
              child: LoadingWidget(),
            )
          : ListView.builder(
              itemCount: webScrapeResult!.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> attributes =
                    webScrapeResult![index]['attributes'];
                return PhotoItem(
                    url: '$baseUrl' + '$urlPath2' + '${attributes['src']}');
              }),
    );
  }
}

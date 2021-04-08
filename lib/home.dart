import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'https://www.w3schools.com';
  String urlPrat2 = '/css/';
  String urlPrat3 = 'css_image_gallery.asp';
  WebScraper webScraper = WebScraper('https://www.w3schools.com');
  List<Map<String, dynamic>> imageURLs;

  void fetchData() async {
    if (await webScraper.loadWebPage(urlPrat2 + urlPrat3)) {
      setState(() {
        imageURLs = webScraper.getElement('div.img > a > img', ['src']);
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
      body: imageURLs == null
          ? Center(
              child:
                  CircularProgressIndicator(), // Loads Circular Loading Animation
            )
          : ListView.builder(
              itemCount: imageURLs.length,
              itemBuilder: (BuildContext context, int index) {
                // Attributes are in the form of List<Map<String, dynamic>>.
                Map<String, dynamic> attributes =
                    imageURLs[index]['attributes'];
                return Image.network(
                    '$url' + '$urlPrat2' + '${attributes['src']}');
              }),
    );
  }
}

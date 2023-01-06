import 'package:flutter/material.dart';
import 'package:flutter_web_scraper/widgets.dart';
import 'package:web_scraper/web_scraper.dart';

class DetectIpPage extends StatefulWidget {
  DetectIpPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DetectIpPageState createState() => _DetectIpPageState();
}

class _DetectIpPageState extends State<DetectIpPage> {
  final WebScraper webScraper = WebScraper('https://ipcost.com/');
  final String innerAddressDescription = 'div.e > strong';
  final String innerAddressTitle = 'div.e > small';

  final String titleResultKey = "title";
  final String descriptionResultKey = "title";

  List<Map<String, dynamic>>? webScrapeResultTitle;
  List<Map<String, dynamic>>? webScrapeResultDescription;

  /// in this case , we don't need urlPath.
  final String urlPath = '';

  /// in this case , attributes always null and we don't need them.
  final List<String> attributeList = [''];

  void fetchData() async {
    if (await webScraper.loadWebPage(urlPath)) {
      setState(() {
        webScrapeResultTitle =
            webScraper.getElement(innerAddressTitle, attributeList);
        webScrapeResultDescription =
            webScraper.getElement(innerAddressDescription, attributeList);
        //
        // print("webScrapeResultTitle::::${webScrapeResultTitle!.toList()}");
        // print(
        //     "webScrapeResultDescription::::${webScrapeResultDescription!.toList()}");
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
      body: webScrapeResultTitle == null || webScrapeResultDescription == null
          ? Center(
              child: LoadingWidget(),
            )
          : ListView.builder(
              itemCount: webScrapeResultDescription!.length,
              itemBuilder: (BuildContext context, int index) {
                return IpInfoItem(
                    titleResult: webScrapeResultTitle![index][titleResultKey],
                    descriptionResult: webScrapeResultDescription![index]
                        [descriptionResultKey]);
              }),
    );
  }
}

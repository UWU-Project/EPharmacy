import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PillID2 extends StatelessWidget {
  const PillID2({Key? key}) : super(key: key);

  // Future<void> doLaunch(BuildContext context) async {
  //   final String url = 'https://www.webmd.com/pill-identification/default.htm';
  //   if (await canLaunch(url))
  //     await launch(
  //         url,
  //       forceSafariVC: true,
  //       forceWebView: true,
  //       enableJavaScript: true,
  //       enableDomStorage: true,
  //         headers: <String, String>{'my_header_key': 'my_header_value'},
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PILL IDENTIFIER'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebView(
            initialUrl: 'https://www.rxwiki.com/pill_identifier',
            javascriptMode: JavascriptMode.unrestricted,
            // onWebViewCreated: (WebViewController webViewController) {
            //   _controller.complete(webViewController);
            // },
          );
        },
      ),
    );
  }
}

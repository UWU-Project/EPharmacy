import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PillID extends StatelessWidget {
  const PillID({Key? key}) : super(key: key);

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

  launchURL(String url) async {
    if(await canLaunch(url)){
      await launch(
          url,
          forceWebView: true,
          universalLinksOnly: true,

      );
    } else{
      throw 'Not launchable';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PILL IDENTIFIER'),
        centerTitle: true,
      ),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Get in touch',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0),
                const Text(
                    "We'd love to hear from you. Our friendly team is always here to chat.",
                    style: TextStyle(
                        color: Color(0xFFA895D1),
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: 30.0),

                TextButton(
                  onPressed: () async {

                    // doLaunch(context);

                    const url = 'https://druggenius.com/pill-identifier';
                    launchURL(url);
                    // if(await canLaunch(url)){
                    //   await launch(url);
                    // }else {
                    //   throw 'Could not launch $url';
                    // }
                    //logic  goes here
                  },

                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.language, color: Color(0xFFED92A2)),
                      SizedBox(width: 20.0),
                      Text('blog.logrocket.com',
                          style: TextStyle(
                              color: Color(0xFFA294C2),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),

                ),

              ],
            ),
          ),
        )



    );
  }
}

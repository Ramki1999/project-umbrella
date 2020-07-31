import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

///Shows guidelines on various disaster scenario from trusted source : "https://www.cdc.gov/disasters"
class Guidelines extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Umbrella",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "Guidlines",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
//        centerTitle: true,
        elevation: 9.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Flood",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WebView(
                          initialUrl:
                              'https://www.cdc.gov/disasters/floods/index.html',
                          onWebViewCreated:
                              (WebViewController webViewController) {
                            _controller.complete(webViewController);
                          },
                        );
                      },
                    ));
                  },
                  child: Card(
                    elevation: 24,
                    child: Container(
                      width: 350,
                      height: 100,
                      child: Image.asset(
                        "asset/Flood.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Cyclones/Hurricanes",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WebView(
                          initialUrl:
                              'https://www.cdc.gov/disasters/hurricanes/index.html',
                          onWebViewCreated:
                              (WebViewController webViewController) {
                            _controller.complete(webViewController);
                          },
                        );
                      },
                    ));
                  },
                  child: Card(
                    elevation: 24,
                    child: Container(
                      width: 350,
                      height: 100,
                      child: Image.asset(
                        "asset/cyclone.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Tornado",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WebView(
                          initialUrl:
                              'https://www.cdc.gov/disasters/tornadoes/index.html',
                          onWebViewCreated:
                              (WebViewController webViewController) {
                            _controller.complete(webViewController);
                          },
                        );
                      },
                    ));
                  },
                  child: Card(
                    elevation: 24,
                    child: Container(
                      width: 350,
                      height: 100,
                      child: Image.asset(
                        "asset/tornado.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  "WildFires",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WebView(
                          initialUrl:
                              'https://www.cdc.gov/disasters/wildfires/index.html',
                          onWebViewCreated:
                              (WebViewController webViewController) {
                            _controller.complete(webViewController);
                          },
                        );
                      },
                    ));
                  },
                  child: Card(
                    elevation: 24,
                    child: Container(
                      width: 350,
                      height: 100,
                      child: Image.asset(
                        "asset/wildfire.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

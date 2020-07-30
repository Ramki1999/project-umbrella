import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Fill the google form - "https://docs.google.com/forms/d/e/1FAIpQLSdQ5haiEiduIy3_g_uc9jLkNYrkuQGH6I1YWM3ysQDJQvnPZA/viewform?usp=sf_link"
class UFeedback extends StatelessWidget {
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
              "Feedback",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 9.0,
      ),
      body: WebView(
        initialUrl:
            "https://docs.google.com/forms/d/e/1FAIpQLSdQ5haiEiduIy3_g_uc9jLkNYrkuQGH6I1YWM3ysQDJQvnPZA/viewform?usp=sf_link",
      ),
    );
  }
}

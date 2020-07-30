import 'package:flutter/material.dart';

///Chat interface to support offline chat between umbrella users during a disaster
class DuckChat extends StatefulWidget {
  @override
  _DuckChatState createState() => _DuckChatState();
}

class _DuckChatState extends State<DuckChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Emergency",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "Chat",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 9.0,
      ),
    );
  }
}

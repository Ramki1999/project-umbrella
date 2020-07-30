import 'package:flutter/material.dart';
import 'package:umbrella/Widgets/FadeAnimation.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

///Setting the duration to 3 seconds
class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  /// Navigates the control to HomeScreen once the animation is complete
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FadeAnimation(1, Container(child: Image.asset('asset/logo.png'))),
          FadeAnimation(
              1.3,
              Container(
                  child: Text(
                "UMBRELLA",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ))),
          FadeAnimation(
              1.6,
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 5.0,
                    width: 300.0,
                    color: Colors.red,
                  ))),

          /// CAPTION - Act before you React.
//          FadeAnimation(
//            1.9,
//            Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text("ACT ",
//                      style:
//                          TextStyle(fontSize: 30,color: Colors.red, fontWeight: FontWeight.bold)),
//                  Text(
//                    "BEFORE YOU ",
//                    style: TextStyle(
//                        color: Colors.black,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 20),
//                  ),
//                  Text(
//                    "RE",
//                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                  ),
//                  Text(
//                    "ACT",
//                    style: TextStyle(
//                        color: Colors.red,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 20),
//                  )
//                ],
//              ),
//            ),
//          )
        ],
      )),
    );
  }
}

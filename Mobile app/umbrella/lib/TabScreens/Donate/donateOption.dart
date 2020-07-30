import 'package:flutter/material.dart';
import 'donate.dart';
import 'package:page_transition/page_transition.dart';

///Used to display the various donations required to raise the relief funds for the disaster damage in the country.
///The data used here is static however once the server is deployed
class DonatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                  child: Column(
                children: <Widget>[
                  Text(
                    "DONATE",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "#Save Assam - Assam Floods",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Donate())),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'asset/Assam.jpeg',
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                  )
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Text(
                    "#Cyclone Amphan - Odisha relief funds",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Donate())),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'asset/Amphan.jpg',
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                  )
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Text(
                    "#Uttarakhand Forest fire Fund",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Donate())),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'asset/uttarkhand-fire.jpeg',
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

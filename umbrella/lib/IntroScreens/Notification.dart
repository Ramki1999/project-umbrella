import 'package:flutter/material.dart';
import 'package:umbrella/DrawerScreens/Emergency/Maps.dart';
import 'package:umbrella/DrawerScreens/Guidelines/Guidelines.dart';
import 'package:umbrella/Widgets/ShowPic.dart';
import 'package:umbrella/IntroScreens/HomeScreen.dart';
import 'package:page_transition/page_transition.dart';

///Uses FCM to send Push notifications to the app.
///Data used here are static. However once the server is deployed, everything will be dynamic
class NotiBell extends StatefulWidget {
  @override
  _NotiBellState createState() => _NotiBellState();
}

class _NotiBellState extends State<NotiBell> {
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
              "Notifications",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 9.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                show = null;
              });
            },
          )
        ],
      ),
      body: (show == null)
          ? Center(child: Text("No Notifications"))
          : Column(
              children: <Widget>[
                Card(
                  elevation: 9,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: 150.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (show['notification']['title']
                                              .toString()
                                              .substring(9, 14) ==
                                          "Flood")
                                      ? NetworkImage(
                                          "https://i.guim.co.uk/img/media/892522b22a8dbf15576abbeb830f3c181534cfc3/0_147_2800_1680/master/2800.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=c8de04ceac35d8583e6240cd4c2ed692")
                                      : (show['notification']['title']
                                                  .toString()
                                                  .substring(9, 14) ==
                                              "Cyclone")
                                          ? NetworkImage(
                                              "https://i.guim.co.uk/img/media/8356345fq3453ft34255345324534f43rwef43c6/0_147_2800_1680/master/2800.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=c8de04ceac35d8583e6240cd4c2ed692")
                                          : NetworkImage(
                                              "https://i.guim.co.uk/img/media/432543254wfcasdfa43rfw44252345435345rt44/0_147_2800_1680/master/2800.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=c8de04ceac35d8583e6240cd4c2ed692"))),
                        ),
                        Container(
                          height: 200,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 20),
                                Text(
                                  show['notification']['title'],
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Text(
                                      show['notification']['title']
                                          .toString()
                                          .substring(9, 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Container(
                                    height: 120,
                                    width: 200,
                                    child: Text(
                                      show['notification']['body'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 48, 48, 54)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      splashColor: Colors.redAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: Guidelines()));
                      },
                      child: Text(
                        "Guidelines",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    RaisedButton(
                      splashColor: Colors.grey,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: MapScreen()));
                      },
                      child: Text(
                        "Safe Zones",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Quick Guide",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: ShowPic(disaster: "flood"))),
                  child: Card(
                    child: Container(
                      width: 350,
                      height: 250,
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        "asset/flood-guide.jpg", //Flood Guidelines - Static
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:umbrella/DrawerScreens/Emergency/DuckChat.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:umbrella/IntroScreens/HomeScreen.dart';
import 'package:page_transition/page_transition.dart';

///The SOS Chat is a feature to contact the Rescue officials during extreme emergency
///Ur message will be displayed on the rescue officials portal(Once the server is deployed)
///In future this can support offline(without internet and mobile network) by connecting it with the Cluster Duck Network developed by project OWL
class SOSChat extends StatefulWidget {
  @override
  _SOSChatState createState() => _SOSChatState();
}

class _SOSChatState extends State<SOSChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SOS",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "Chat",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
//        centerTitle: true,
        elevation: 9.0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Chat will be enabled once you press SOS button"),
              duration: Duration(seconds: 5),
            ),
          );
          Navigator.push(context,
              PageTransition(type: PageTransitionType.fade, child: DuckChat()));
        },
        label: Icon(Icons.chat),
        splashColor: Colors.deepOrangeAccent,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "LOCATION",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Container(
                        width: 280,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.pin_drop,
                              color: Colors.red,
                            ),
                            Text(
                              "$uLat , $uLng",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "NAME",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.white.withOpacity(0.1),
                          filled: true,
                          isDense: true,
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.red),
                          focusColor: Colors.red,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            borderSide: new BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            borderSide: new BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          hintText: "APJ Abdhul Kalam",
                          labelText: "APJ Abdhul Kalam",
                        ),
                      ),
                    ),
                    Text(
                      "USER ID",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    new QrImage(
                      data: '9840802020',
                      size: 100,
                    ),
                    Text(
                      "MESSAGE",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 10 * 14.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Enter a message",
                          filled: true,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 185,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage('asset/sos.jpg'),
                        ),
                      ),
                      iconSize: 180,
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "The Chat will be enabled once the server is ready"),
                            duration: Duration(seconds: 5),
                          ),
                        );
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: DuckChat()));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

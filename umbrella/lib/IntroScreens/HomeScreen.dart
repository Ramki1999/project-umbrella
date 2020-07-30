import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:geolocator/geolocator.dart';
import 'package:umbrella/DrawerScreens/Account.dart';
import 'package:umbrella/DrawerScreens/Emergency/Contacts.dart';
import 'package:umbrella/DrawerScreens/Emergency/Maps.dart';
import 'package:umbrella/DrawerScreens/Emergency/SOS_Chat.dart';
import 'package:umbrella/DrawerScreens/Guidelines/Guidelines.dart';
import 'package:umbrella/DrawerScreens/Settings.dart';
import 'package:umbrella/TabScreens/Donate/donateOption.dart';
import 'package:umbrella/TabScreens/Home_Weather/home.dart';
import 'package:umbrella/TabScreens/UmbrellaBot/HelpBot.dart';
import 'package:umbrella/IntroScreens/Notification.dart';
import 'package:umbrella/DrawerScreens/News/NewsPage.dart';
import 'package:umbrella/DrawerScreens/Feedback.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Map<String, dynamic> show; //for alert notifications in the Notification Screen
double uLat, uLng; //get user Location

///Using Firebase Cloud messaging to push notifications during a disaster.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final FirebaseMessaging _fcm = FirebaseMessaging();
  _getCurrentLocation() async {
    final _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(_currentPosition.longitude);
    print(_currentPosition.latitude);
    setState(() {
      if (_currentPosition != null) {
        uLat = _currentPosition.latitude;
        uLng = _currentPosition.longitude;
      }
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 1)
      ..addListener(() => setState(() => {}));

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          show = message;
        });
        print("onMessage: $message");

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(
                message['notification']['title'],
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  NotiBell(); //Notification Screen
                },
                color: Colors.red,
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          show = message;
        });
        print("onLaunch: $message");

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(
                message['notification']['title'],
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  NotiBell(); //Notification Screen
                },
                color: Colors.red,
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          show = message;
        });
        print("onResume: $message");

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(
                message['notification']['title'],
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  NotiBell(); //Notification Screen
                },
                color: Colors.red,
              ),
            ],
          ),
        );
      },
    );

    _fcm.getToken().then((token) {
      update(token);
    });
  }

  update(String token) {
    print(token);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          //Drawer Screen with multiple options
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("A.P.J Abdul Kalam"),
                  accountEmail: new Text("9840802020"),
                  currentAccountPicture: new CircleAvatar(
                    child: Image.asset("asset/user.png"),
                    backgroundColor: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Emergency',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {},
                ),

                ///To Store Emergency contacts of Local Rescue officers and first responders
                new ListTile(
                    leading: Icon(
                      Icons.contacts,
                      color: Colors.black,
                    ),
                    title: Text('Contacts'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => Contacts()));
                    }),

                ///Chat Interface to interact with the Rescue officers and local umbrella users during emergency situation.
                ///Can Implement offline chat option using the network established by PROJECT OWL.
                new ListTile(
                    leading: Icon(
                      Icons.chat,
                      color: Colors.black,
                    ),
                    title: Text('SOS Chat'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => SOSChat()));
                    }),

                ///Find Evacuation Tips and Safe zones near your place used in emergency situation
                new ListTile(
                    leading: Icon(
                      Icons.map,
                      color: Colors.black,
                    ),
                    title: Text('Offline Map'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => MapScreen()));
                    }),
                Divider(),

                ///Edit your account details, NOTE: Umbrella recognizes its user by phone number and their location coordinates
                new ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    title: Text('Account'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => UserDetails()));
                    }),

                ///News Updates to get the users updated with climatic change.Very much Useful during disaster times
                new ListTile(
                    leading: Icon(
                      Icons.library_books,
                      color: Colors.black,
                    ),
                    title: Text('News'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => NewsPage()));
                    }),

                ///Guidelines to be followed during disaster times - Crowd sourced from trusted CDC data
                new ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    title: Text('Guidelines'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => Guidelines()));
                    }),

                ///Settings to change the temperature unit and location options
                new ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => SettingsScreen()));
                    }),
                Divider(),

                ///Feedback  to improve umbrella
                ///Google Form link : "https://docs.google.com/forms/d/e/1FAIpQLSdQ5haiEiduIy3_g_uc9jLkNYrkuQGH6I1YWM3ysQDJQvnPZA/viewform?usp=sf_link"
                new ListTile(
                    leading: Icon(
                      Icons.bug_report,
                      color: Colors.black,
                    ),
                    title: Text('Feedback'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => UFeedback()));
                    }),
                ListTile(
                  title: Text('0.0.1'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("Umbrella", style: TextStyle(color: Colors.red)),
            centerTitle: true,

            ///Alert Notification - Gives you alert and suggestions during Disaster times
            actions: <Widget>[
              IconButton(
                  icon: (show != null)
                      ? Icon(Icons.notifications_active, color: Colors.red)
                      : Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: NotiBell()));
                  })
            ],
            bottom: TabBar(
              controller: _controller,
              tabs: [
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Image.asset('asset/donate.png')),
              ],
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: [
              HelpBot(), // Umbrella Bot - Watson assistant ChatBot to answer and guide you during a disaster
              HomePage(), //Weather updates - uses the Open Weather api
              DonatePage(), //Donation for raising relief funds for the affected ppl - uses Razorpay payment gateway
            ],
          ),
        ),
//            ),
      ),
    );
  }
}

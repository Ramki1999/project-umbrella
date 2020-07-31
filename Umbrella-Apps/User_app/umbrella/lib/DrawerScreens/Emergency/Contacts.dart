import 'package:flutter/material.dart';
import 'call_service.dart';

///Shows the necessary contacts during an emergency situation
///Note that the numbers used here are static and not valid, However once the server is established location based caching of Emergency numbers can be done.
class Contacts extends StatelessWidget {
  final CallService _service = locator<CallService>();
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
              "Contacts",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 9.0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('asset/fire.jpeg'),
                  ),
                ),
                title: Text("Fire Service",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  _service.call("9445086091");
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('asset/police.png'),
                  ),
                ),
                title: Text("Local Police",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  _service.call("9999999999");
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('asset/disaster.png'),
                  ),
                ),
                title: Text("State Disaster Mangement",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  _service.call("9840984089");
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('asset/med+.jpeg'),
                  ),
                ),
                title: Text(
                  "Medical Emergency",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  _service.call("108");
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

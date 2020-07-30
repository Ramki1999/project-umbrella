import 'package:flutter/material.dart';
import 'package:umbrella/TabScreens/UmbrellaBot/MapSearch.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';
import 'package:bubble/bubble.dart';
import 'package:page_transition/page_transition.dart';

///Uses IBM Watson Assistant to intelligently answer the users questions on disaster and
///Shows them navigation to relief centers for shelter and food
class HelpBot extends StatefulWidget {
  @override
  _HelpBotState createState() => _HelpBotState();
}

class _HelpBotState extends State<HelpBot> {
  bool _mapState = false;
  String mapMarkers = "";
  bool _isWriting = false;
  bool trans = false;

  ///CREDENTIALS
  WatsonAssistantV2Credential credential = WatsonAssistantV2Credential(
    // TODO: change the credential to yours
    version: '2020-07-25',
    username: 'apikey',
    apikey: 'ReL0IDwm_ljfc7dyiyHTygIM5f40udwhrlZXv6LaAWq6', //API KEY
    assistantID: '3fa0b125-821e-4a4b-863f-4a23ccedfc42', //WATSON ASSISTANT ID
    url:
        'https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/606b7d08-d2e0-4200-9175-82ac2e33335e/v2',
  );

  WatsonAssistantApiV2 watsonAssistant;
  WatsonAssistantResponse watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  final TextEditingController myController = TextEditingController();
  //messages stores the request and responses
  List<Map> messsages = List();

  /// Responsible for the communication with the Watson Assistant
  void response(query) async {
    myController.clear();
    setState(() => _isWriting = false);
    watsonAssistantResponse =
        await watsonAssistant.sendMessage(query, watsonAssistantContext);
    setState(() {
      messsages.insert(0, {
        "data": query,
        "message": watsonAssistantResponse.resultText,
      });

      ///To activate the map if user is trying to ask about relief centers for food,shelter and animals
      if (watsonAssistantResponse.resultText.substring(29, 39) ==
          "Animal Aid") {
        setState(() {
          mapMarkers = "Animal";
          _mapState = true;
          print(watsonAssistantResponse.resultText.substring(29, 38));
        });
      } else if (watsonAssistantResponse.resultText.substring(29, 45) ==
          "Free food Relief") {
        setState(() {
          mapMarkers = "Food";
          _mapState = true;
          print(watsonAssistantResponse.resultText.substring(29, 44));
        });
      } else if (watsonAssistantResponse.resultText.substring(29, 43) ==
          "Public Shelter") {
        setState(() {
          mapMarkers = "Shelter";
          _mapState = true;
          print(watsonAssistantResponse.resultText.substring(29, 43));
        });
      }
    });

    watsonAssistantContext = watsonAssistantResponse.context;
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV2(watsonAssistantCredential: credential);
    response("qwerty");
  }

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
              "Bot",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: new IconButton(
          icon: Icon(
            Icons.restore,
            color: Colors.red,
          ),
          onPressed: () {
            watsonAssistantContext.resetContext();
            setState(() {
              messsages.clear();
              _mapState = false;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(mapMarkers);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: MapSearch(
                    markerOpt: mapMarkers,
                  )));
        },
        tooltip: 'Maps',
        elevation: 20,
        backgroundColor: (!_mapState) ? Colors.grey : Colors.green,
        child: Icon(
          Icons.pin_drop,
          color: (_mapState) ? Colors.white : Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["data"],
                        messsages[index]["message"]))),
            Divider(
              height: 1.0,
              color: Colors.red,
            ),
            Container(
//              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.mic),
                    color: (trans) ? Colors.red : Colors.grey,
                    onPressed: () {
                      setState(() {
                        trans = true;
                      });
                    },
                  ),
                  Flexible(
                    child: TextField(
                      controller: myController,
                      onChanged: (String txt) =>
                          setState(() => _isWriting = txt.length > 0),
                      onSubmitted: response,
                      decoration: InputDecoration.collapsed(
                          hintText: "Enter some text!"),
                    ),
                  ),
                  Container(
//                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    child: IconButton(
                        icon: Icon(Icons.send, color: Colors.red),
                        onPressed: _isWriting
                            ? () {
                                response(myController.text);
                              }
                            : null),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chat(String data, String message) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          (data != "qwerty")
              ? Bubble(
                  radius: Radius.circular(15.0),
                  color: Colors.black,
                  elevation: 0.0,
                  alignment: Alignment.topRight,
                  nip: BubbleNip.rightTop,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage("asset/user.png"),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                            child: Text(
                          data,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ))
              : Text(
                  "initiate",
                  style: TextStyle(color: Colors.transparent),
                ),
          SizedBox(height: 10),
          Bubble(
              radius: Radius.circular(15.0),
              color: Colors.red,
              elevation: 0.0,
              alignment: Alignment.topLeft,
              nip: BubbleNip.leftBottom,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("asset/bot.png"),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                        child: Text(
                      message,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}

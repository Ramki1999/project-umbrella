import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../IntroScreens/HomeScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:umbrella/Widgets/FadeAnimation.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:pin_entry_text_field/pin_entry_text_field.dart';

///Account Settings to edit user details - Note User Mobile number and Location is a key parameter for Umbrella
///On Mobile number registration Authentication is sent via OTP.
///However this will be demonstrated finally once the entire project is complete.

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
//  final _phoneController = TextEditingController();
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
    super.initState();
    _getCurrentLocation();
//    getUser().then((user) {
//      if (user != null) {
//        // send the user to the home page
//        HomeScreen();
//      }
//    });
  }

  //LOGIN AUTHENTICATION
  /*
  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if(user != null){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomeScreen(),
            ));
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done automatically
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight:250),
                  child: FadeAnimation(1,Container(
                      padding: const EdgeInsets.only(top: 10,left: 3,right: 2,bottom: 10),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Text("Enter your OTP : ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          Image.asset("assets/images/otp-icon.png",height: 100,),
                          SizedBox(height: 10,),
                          PinEntryTextField(
                            fields: 6,
                            showFieldAsBox: false,
                            onSubmit:  (String pin ) async{
                              AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: pin);

                              AuthResult result = await _auth.signInWithCredential(credential);
                              FirebaseUser user = result.user;
                              if(user != null){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomeScreen()
                                ));
                              }else{
                                print("Error");
                              }
                            },
                          ),
                        ],
                      )
                  )),
                ),
              );
            },
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }

  Future<FirebaseUser> getUser() async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    return await _auth.currentUser();
  }
  */

  String validateNonEmpty(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length == 0)
      return 'field is required!';
    else
      return null;
  }

  String validateMinLength(String value, {int length = 3}) {
    if (value.length < length)
      return 'minimum $length character are required !';
    else
      return null;
  }

  String validatePhone(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 10)
      return 'valid phone number is required !';
    else
      return null;
  }

  String validateEmail(String value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value))
      return 'valid email is required !';
    else
      return null;
  }

  final List<String> _list = List();

  TextFormField getCustomEditTextArea({
    String labelValue = "",
    String hintValue = "",
    Function validator,
    IconData icon,
    bool validation,
    TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String validationErrorMsg,
  }) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
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
        hintText: hintValue,
        labelText: labelValue,
      ),
      validator: validator,
    );
  }

  double uLat, uLng;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "User",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "Details",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 9.0,
      ),
      body: SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            new QrImage(
              data: '9840802020,$uLat,$uLng',
              size: 300,
            ),
            SizedBox(
              height: 20,
            ),
            new Container(
                child: new Center(
              child: new Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: new Form(
                      key: _formKey,
                      autovalidate: false,
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: getCustomEditTextArea(
                                  labelValue: "Full Name",
                                  hintValue: "A.P.J Abdul Kalam",
                                  validator: (value) {
                                    _list.insert(0, value);
                                    validateMinLength(value, length: 3);
                                  },
                                  icon: Icons.account_circle)),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: getCustomEditTextArea(
                                  labelValue: "Personal Email",
                                  hintValue: "apj.kalam2020@gmail.com",
                                  validator: (value) {
                                    _list.insert(1, value);
                                    validateMinLength(value, length: 3);
                                  },
                                  icon: Icons.email)),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: getCustomEditTextArea(
                                  labelValue: "Contact Number",
                                  hintValue: '9840802020',
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    _list.insert(2, value);
                                    validateMinLength(value, length: 3);
                                  },
                                  icon: Icons.phone)),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            splashColor: Colors.redAccent,
                            elevation: 0.8,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20),
                                side: BorderSide(color: Colors.white)),
                            color: Colors.red,
                            onPressed: () {
//                              final phone = _phoneController.text.trim();
//                              loginUser((phone[1]=="+")?phone:"+91"+phone
//                                  , context);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: HomeScreen()));
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

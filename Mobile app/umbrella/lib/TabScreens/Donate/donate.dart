import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

///Donation Payment gateway using Razor Pay - Secured and has multiple options
///In future Additional feature of tracking the transaction can be done as the money is indirectly transferred from one umbrella user to other
class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_DuQ6V9s5gCbhDG",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "UmbrellaDonate",
      "description": "Payment for some good cause",
      "prefill": {
        "contact": "9840802020",
        "email": "apj.kalam2020@gmail.com"
      }, //Can be replaced by user details once authenticated
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Pament success");
    Toast.show("Pament success", context);
  }

  void handlerErrorFailure() {
    print("Pament error");
    Toast.show("Pament error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Donate",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "Money",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 9.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset("asset/helping.jpg"),
            SizedBox(
              height: 20,
            ),
            Text(
              "The Amount you are paying is going for a good cause. Be a part of the big change.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              "# HUMANITY the ultimate solution",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: textEditingController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: "Amount to pay"),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(
                "Donate Now",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}

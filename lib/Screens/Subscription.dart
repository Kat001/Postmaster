import 'package:flutter/material.dart';

import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  Razorpay _razorpay;
  double _setAmount;
  Future<List<dynamic>> subscriptionData;

  String subscriptionId = "";
  String plan = "";
  String amount = "";
  String validity = "";
  String minDelivery = "";
  String cashBack = "";
  String roi = "";

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    subscriptionData = fetchSubscriptionData();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(double amount) async {
    var options = {
      'key': 'rzp_test_eAO1C3UKqngmHc',
      'amount': amount * 100,
      'name': 'Postmaster',
      'description': 'Send your Pacakages',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  Widget rowWidget(String str1, String str2) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            str1,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 17,
            ),
          ),
        ),
        //SizedBox(width: 40.0),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 50.0),
            child: Text(
              str2,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<List<dynamic>> fetchSubscriptionData() async {
    http.Response res = await http.get(
      'https://www.mitrahtechnology.in/apis/mitrah-api/order/getdetail.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "user": "admin",
        "password": "1234",
        "table_name": "subscription"
      },
    );
    //print(res.body);
    var responseData = json.decode(res.body);

    if (responseData["status"] == 200) {}

    return json.decode(res.body)['message'];
  }

  Widget plansWidget() {
    return FutureBuilder<List<dynamic>>(
      future: fetchSubscriptionData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF0F0F0),
                                blurRadius: 5.0,
                                spreadRadius: 5.0,
                              )
                            ]),
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Subscription plan : " +
                                      snapshot.data[index]['plan'],
                                  style: TextStyle(
                                    fontFamily: "RobotoBold",
                                    fontSize: displayWidth(context) * 0.04,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "₹" + snapshot.data[index]['amount'],
                                    style: TextStyle(
                                      fontFamily: 'RobotoBold',
                                      color: Color(0xFF27DEBF),
                                      fontSize: displayWidth(context) * 0.05,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 80.0, bottom: 5.0),
                                    child: rowWidget("Validity",
                                        snapshot.data[index]["validity"]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 80.0, bottom: 5.0),
                                    child: rowWidget("Minimum delivery",
                                        snapshot.data[index]["delivery"]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 80.0, bottom: 5.0),
                                    child: rowWidget("Cashback",
                                        snapshot.data[index]["cashback"]),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 80.0),
                                    child: rowWidget(
                                        "Roi", snapshot.data[index]["roi"]),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: displayWidth(context) * 0.03,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  InkWell(
                                    onTap: () {
                                      double data = double.parse(
                                          snapshot.data[index]['amount']);
                                      setState(() {
                                        _setAmount = data;
                                        subscriptionId =
                                            snapshot.data[index]['id'];

                                        plan = snapshot.data[index]['plan'];

                                        amount = snapshot.data[index]['amount'];
                                        validity =
                                            snapshot.data[index]['validity'];
                                        minDelivery = snapshot.data[index]
                                            ['minimum_delivery'];
                                        cashBack =
                                            snapshot.data[index]['cashback'];
                                        roi = snapshot.data[index]['roi'];
                                      });
                                      openCheckout(data);
                                    },
                                    child: Container(
                                        //alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            //right: displayWidth(context) * 0.07,
                                            bottom:
                                                displayWidth(context) * 0.05,
                                            top: displayHeight(context) * 0.01),
                                        //height: displayHeight(context) * 0.07,
                                        //width: displayWidth(context) * 0.35,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 25,
                                              right: 25,
                                              top: 10,
                                              bottom: 10),
                                          child: Text(
                                            "Activate",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
                                              fontSize:
                                                  displayWidth(context) * 0.03,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: Colors.green,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*ListTile(
                        title: Text(snapshot.data[index]['plan']),
                        subtitle: Text(snapshot.data[index]['amount']),
                      )*/
                    ],
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Subscription",
            style: TextStyle(
                fontFamily: "RobotoBold",
                fontSize: 20.0,
                color: Color(0xFF2AD0B5)),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: new EdgeInsets.only(
                right: displayWidth(context) * 0.2,
                left: displayWidth(context) * 0.2,
              ),
              child: Image(
                image: AssetImage('assets/images/subscribe.jpg'),
                height: 200.0,
                width: 200.0,
              ),
            ),
            Expanded(child: plansWidget()),
            /*Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    //margin: EdgeInsets.only(left: 0.0.w, right: 8.0.w),
                    width: 30.0.w,
                    height: 30.0.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF0F0F0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Plan1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF465A64),
                            fontFamily: "RobotoBold",
                            fontSize: displayWidth(context) * 0.05),
                      ),
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.only(left: 0.0.w, right: 8.0.w),
                    width: 30.0.w,
                    height: 30.0.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF0F0F0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Plan2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF465A64),
                            fontFamily: "RobotoBold",
                            fontSize: displayWidth(context) * 0.05),
                      ),
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.only(left: 0.0.w, right: 8.0.w),
                    width: 25.0.w,
                    height: 30.0.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF0F0F0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Plan3",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF465A64),
                            fontFamily: "RobotoBold",
                            fontSize: displayWidth(context) * 0.05),
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
            /*Expanded(
              child: Container(
                margin: new EdgeInsets.only(left: 75, right: 75, top: 40),
                child: MaterialButton(
                  // color: Color(0xFF27DEBF),
                  onPressed: () {
                    print("login clicked..");
                  },
                  minWidth: 250.0,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8.0)),
                  height: 45.0,
                  child: Text(
                    "Subscribe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontFamily: 'RobotoBold',
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    gradient: RadialGradient(
                        radius: 15,
                        colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
              ),
            ),*/
          ],
        ));
  }

  void _handlePaymentSuccess(
    PaymentSuccessResponse response,
  ) {
    _addWalletBalanace();
    _getSubscribed();
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  Future<http.Response> _addWalletBalanace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res;

    Map data = {
      "amount": _setAmount,
      "type": "credit",
      "status": "success",
      "payment_mode": "UPI",
      "comment": "DONT KNOW"
    };

    var body = json.encode(data);

    res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/wallet_transaction.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    print(res.body);
    var responseData = json.decode(res.body);

    return res;
  }

  Future<http.Response> _getSubscribed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res;

    Map data = {
      "subscription_id": subscriptionId,
      "plan": plan,
      "amount": double.parse(amount),
      "validity": validity,
      "minimum_delivery": minDelivery,
      "cashback": cashBack,
      "roi": roi
    };

    var body = json.encode(data);

    res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/subscription.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    print("ksjdjksandjksa" + res.body);
    var responseData = json.decode(res.body);

    return res;
  }
}

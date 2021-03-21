import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:postmaster/Components/sizes_helpers.dart';

class Completeorderdetail extends StatefulWidget {
  @override
  _CompleteorderdetailState createState() => _CompleteorderdetailState();
}

class _CompleteorderdetailState extends State<Completeorderdetail> {
  Future<List<dynamic>> mySubscription;
  bool _isdata = true;
  @override
  void initState() {
    super.initState();
    mySubscription = mySubscriptionData();
  }

  Future<List<dynamic>> mySubscriptionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/my_subscription.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token
      },
    );
    //print(res.body);
    var responseData = json.decode(res.body);
    print(responseData['message']);

    if (responseData["status"] == 404) {
      setState(() {
        _isdata = false;
      });
    }
    return json.decode(res.body)['message'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text(
              "My Subscriptions",
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
            )),
        body: FutureBuilder<List<dynamic>>(
          future: mySubscription,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      rowWidget("Subscription plan:",
                                          snapshot.data[index]['plan']),
                                      SizedBox(height: 12.0),
                                      rowWidget("Validy:",
                                          snapshot.data[index]['validity']),
                                      SizedBox(height: 12.0),
                                      rowWidget(
                                          "Starting date:",
                                          snapshot.data[index]
                                              ['starting_date']),
                                      SizedBox(height: 12.0),
                                      rowWidget("Expiry date:",
                                          snapshot.data[index]['expiry_date']),
                                      SizedBox(height: 12.0),
                                      rowWidget("Order completed:", "10"),
                                      SizedBox(height: 12.0),
                                      rowWidget(
                                          "Minimum delivery:",
                                          snapshot.data[index]
                                              ['minimum_delivery']),
                                      SizedBox(height: 12.0),
                                      rowWidget(
                                          "Total cashback:",
                                          "₹" +
                                              snapshot.data[index]['cashback']),
                                      SizedBox(height: 12.0),
                                      Center(
                                        child: Container(
                                          height: displayHeight(context) * 0.05,
                                          // padding: const EdgeInsets.only(top: ),
                                          // margin: new EdgeInsets.only(
                                          //   left: 60,
                                          //   right: 60,
                                          //   top: 18,
                                          // ),
                                          margin: EdgeInsets.all(
                                              displayHeight(context) * 0.01),
                                          child: MaterialButton(
                                            onPressed: () {
                                              /*Navigator.push(
                                context, SlideLeftRoute(page: Topup()));*/
                                            },
                                            minWidth: 250.0,
                                            height: 10,
                                            child: Text(
                                              "Upgrade",
                                              style: TextStyle(
                                                fontFamily: 'RobotoBold',
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              gradient: RadialGradient(
                                                  radius: 15,
                                                  colors: [
                                                    Color(0xFF27DEBF),
                                                    Color(0xFF465A64)
                                                  ])),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: displayHeight(context) * 0.05,
                                          // padding: const EdgeInsets.only(top: ),
                                          // margin: new EdgeInsets.only(
                                          //   left: 60,
                                          //   right: 60,
                                          //   top: 18,
                                          // ),
                                          margin: EdgeInsets.all(
                                              displayHeight(context) * 0.01),
                                          child: MaterialButton(
                                            onPressed: () {
                                              /* Navigator.push(
                                context, SlideLeftRoute(page: Topup()));*/
                                            },
                                            minWidth: 250.0,
                                            height: 10,
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                fontFamily: 'RobotoBold',
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              gradient: RadialGradient(
                                                  radius: 15,
                                                  colors: [
                                                    Color(0xFF27DEBF),
                                                    Color(0xFF465A64)
                                                  ])),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: displayHeight(context) * 0.05,
                                          // padding: const EdgeInsets.only(top: ),
                                          // margin: new EdgeInsets.only(
                                          //   left: 60,
                                          //   right: 60,
                                          //   top: 18,
                                          // ),
                                          margin: EdgeInsets.all(
                                              displayHeight(context) * 0.01),
                                          child: MaterialButton(
                                            onPressed: () {
                                              /*Navigator.push(
                                context, SlideLeftRoute(page: Topup()));*/
                                            },
                                            minWidth: 250.0,
                                            height: 10,
                                            child: Text(
                                              "Renew",
                                              style: TextStyle(
                                                fontFamily: 'RobotoBold',
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              gradient: RadialGradient(
                                                  radius: 15,
                                                  colors: [
                                                    Color(0xFF27DEBF),
                                                    Color(0xFF465A64)
                                                  ])),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            } else {
              if (_isdata == true) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text("No Subscription !"));
              }
            }
          },
        ));
  }
}

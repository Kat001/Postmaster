import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:postmaster/Screens/Topup.dart';
import 'package:sizer/sizer.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:postmaster/Components/animate.dart';

import 'package:postmaster/Screens/Forgot_pass.dart';
//import 'package:http/http.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

class Mysubscription extends StatefulWidget {
  @override
  _MysubscriptionState createState() => _MysubscriptionState();
}

class _MysubscriptionState extends State<Mysubscription> {
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
        body: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowWidget("Subscription plan:", "plan1"),
                    SizedBox(height: 12.0),
                    rowWidget("Status:", "True"),
                    SizedBox(height: 12.0),
                    rowWidget("Starting date:", "20-12-1910"),
                    SizedBox(height: 12.0),
                    rowWidget("Expiry date:", "20-12-2021"),
                    SizedBox(height: 12.0),
                    rowWidget("Order completed:", "10"),
                    SizedBox(height: 12.0),
                    rowWidget("Order pending to reach goal:", "2"),
                    SizedBox(height: 12.0),
                    rowWidget("Total cashback:", "₹1000"),
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
                        margin: EdgeInsets.all(displayHeight(context) * 0.01),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            gradient: RadialGradient(radius: 15, colors: [
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
                        margin: EdgeInsets.all(displayHeight(context) * 0.01),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            gradient: RadialGradient(radius: 15, colors: [
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
                        margin: EdgeInsets.all(displayHeight(context) * 0.01),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            gradient: RadialGradient(radius: 15, colors: [
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
        ));
  }
}

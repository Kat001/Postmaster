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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
<<<<<<< HEAD
      body: Container(
        //height: MediaQuery.of(context).copyWith().size.height / 3,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Subscription plan:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 130, right: 10),
                    child: Text(
                      "plan1",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Status:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 130, right: 10),
                    child: Text(
                      "ohkkk",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                children: [
                  Text(
                    "Start date:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 130, right: 10),
                    child: Text(
                      "20-12-2020:",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                children: [
                  Text(
                    "Expiry date:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 130, right: 10),
                    child: Text(
                      "20-12-2021:",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                children: [
                  Text(
                    "Order completed:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 130, right: 10),
                    child: Text(
                      "10",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Orders pending to reach goal:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 130, right: 10),
                    child: Text(
                      "2",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                children: [
                  Text(
                    "Total cashback:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 130, right: 10),
                    child: Text(
                      "₹1000",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                children: [
                  Text(
                    "Available Balance:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 118, right: 10),
                    child: Text(
                      "₹0",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  height: displayHeight(context) * 0.05,
                  // padding: const EdgeInsets.only(top: ),
                  // margin: new EdgeInsets.only(
                  //   left: 60,
                  //   right: 60,
                  //   top: 18,
                  // ),
                  margin: EdgeInsets.all(displayHeight(context) * 0.02),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context, SlideLeftRoute(page: Topup()));
                    },
                    minWidth: 250.0,
                    height: 10,
                    child: Text(
                      "Upgrad",
                      style: TextStyle(
                        fontFamily: 'RobotoBold',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      gradient: RadialGradient(
                          radius: 15,
                          colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
                ),
                Container(
                  height: displayHeight(context) * 0.05,
                  // padding: const EdgeInsets.only(top: ),
                  // margin: new EdgeInsets.only(
                  //   left: 60,
                  //   right: 60,
                  //   top: 18,
                  // ),
                  margin: EdgeInsets.all(displayHeight(context) * 0.02),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context, SlideLeftRoute(page: Topup()));
                    },
                    minWidth: 250.0,
                    height: 10,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: 'RobotoBold',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      gradient: RadialGradient(
                          radius: 15,
                          colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
                ),
                Container(
                  height: displayHeight(context) * 0.05,
                  //width: displayHeight(context) * 0.09,
                  // padding: const EdgeInsets.only(top: ),
                  // margin: new EdgeInsets.only(
                  //   left: 60,
                  //   right: 60,
                  //   top: 18,
                  // ),
                  margin: EdgeInsets.all(displayHeight(context) * 0.02),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context, SlideLeftRoute(page: Topup()));
                    },
                    minWidth: 250.0,
                    height: 10,
                    child: Text(
                      "Renew",
                      style: TextStyle(
                        fontFamily: 'RobotoBold',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      gradient: RadialGradient(
                          radius: 15,
                          colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
                ),
              ],
            ),
          ],
=======
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Subscriptions plan:",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                        child: Text(
                          "plan1",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Status:",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                        child: Text(
                          "True",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Starting date:",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                        child: Text(
                          "20-12-1910",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Expiray date:",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                        child: Text(
                          "20-12-2021",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Order completed:",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                        child: Text(
                          "10",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Order pending to reach goal:",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                        child: Text(
                          "2",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total cashback:",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                        child: Text(
                          "₹1000",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
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
                    Navigator.push(context, SlideLeftRoute(page: Topup()));
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
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    gradient: RadialGradient(
                        radius: 15,
                        colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
              ),
              Container(
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
                    Navigator.push(context, SlideLeftRoute(page: Topup()));
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
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    gradient: RadialGradient(
                        radius: 15,
                        colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
              ),
              Container(
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
                    Navigator.push(context, SlideLeftRoute(page: Topup()));
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
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    gradient: RadialGradient(
                        radius: 15,
                        colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
              ),
            ],
          ),
          margin: EdgeInsets.only(top: 3.0.h, left: 5.0.w, right: 5.0.w),
          width: 150.0.w,
          height: 70.0.h,
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
>>>>>>> fec5162576b4d13679601d913d210f92710cc5a2
        ),
      ),
    );
  }
}

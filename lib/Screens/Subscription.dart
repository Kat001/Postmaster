import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:sizer/sizer.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
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
                height: 266.0,
                width: 266.0,
              ),
            ),
            Container(
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
            ),
            Container(
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
          ],
        ));
  }
}

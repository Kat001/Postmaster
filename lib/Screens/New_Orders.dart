import 'package:flutter/material.dart';
import 'package:postmaster/Screens/Favroite_store.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/NewOrdertest.dart';
import 'package:postmaster/Screens/NewOrderstore.dart';
import 'package:postmaster/Screens/Subscription.dart';

class Neworder extends StatefulWidget {
  @override
  _NeworderState createState() => _NeworderState();
}

class _NeworderState extends State<Neworder> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: TabBar(
              onTap: (index) {},
              indicatorColor: Color(0xFF2BCDB4),
              indicator: BoxDecoration(
                color: Color(0xFF2BCDB4),
                borderRadius: BorderRadius.circular(15),
              ),
              tabs: [
                Tab(
                  child: Text(
                    "Create Order ",
                    style: TextStyle(
                        color: Color(0xFF465A64),
                        fontFamily: "RobotoBold",
                        fontSize: displayWidth(context) * 0.04),
                  ),
                ),
                Tab(
                  child: Text(
                    "Active",
                    style: TextStyle(
                        color: Color(0xFF465A64),
                        fontFamily: "RobotoBold",
                        fontSize: displayWidth(context) * 0.04),
                  ),
                ),
                Tab(
                  child: Text(
                    "Completed",
                    style: TextStyle(
                        color: Color(0xFF465A64),
                        fontFamily: "RobotoBold",
                        fontSize: displayWidth(context) * 0.04),
                  ),
                ),
              ],
            ),
            body: TabBarView(children: [
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Buy from store
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, SlideLeftRoute(page: NewOrder()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 7.0.h, left: 8.0.w, right: 8.0.w),
                          width: 120.0.w,
                          height: 12.0.h,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.05),
                                  width: displayWidth(context) * 0.1,
                                  height: displayHeight(context) * 0.05,
                                  child: SvgPicture.asset(
                                    box,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.05,
                                      top: displayHeight(context) * 0.015),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom:
                                                displayHeight(context) * 0.01),
                                        child: Text(
                                          "Send Your Package",
                                          style: TextStyle(
                                            fontFamily: "RobotoBold",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(),
                                        child: Text(
                                          "Deliver Or Receive Items Such",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Gifts, Documents etc.",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Buy from store
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, SlideLeftRoute(page: NewOrderStore()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5.0.h, left: 8.0.w, right: 8.0.w),
                          width: 120.0.w,
                          height: 12.0.h,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.05),
                                  width: displayWidth(context) * 0.1,
                                  height: displayHeight(context) * 0.05,
                                  child: SvgPicture.asset(
                                    cart,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.05,
                                      top: displayHeight(context) * 0.015),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom:
                                                displayHeight(context) * 0.01),
                                        child: Text(
                                          "Buy from your Favorite Restro.",
                                          style: TextStyle(
                                            fontFamily: "RobotoBold",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(),
                                        child: Text(
                                          "Deliver or receive items such",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "as gifts, documents, keys",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Favrouite store
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, SlideLeftRoute(page: FavoriteStore()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5.0.h, left: 8.0.w, right: 8.0.w),
                          width: 120.0.w,
                          height: 12.0.h,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.05),
                                  width: displayWidth(context) * 0.1,
                                  height: displayHeight(context) * 0.05,
                                  child: SvgPicture.asset(
                                    gps,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.05,
                                      top: displayHeight(context) * 0.015),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom:
                                                displayHeight(context) * 0.01),
                                        child: Text(
                                          "Buy from your Favorite store",
                                          style: TextStyle(
                                            fontFamily: "RobotoBold",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(),
                                        child: Text(
                                          "Didn't Ordered Yet ? Order Now",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Will Deliver To Your Door-Step.",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Subscription
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, SlideLeftRoute(page: Subscription()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5.0.h,
                              left: 8.0.w,
                              right: 8.0.w,
                              bottom: 4.0.h),
                          width: 120.0.w,
                          height: 12.0.h,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.05),
                                  width: displayWidth(context) * 0.1,
                                  height: displayHeight(context) * 0.05,
                                  child: SvgPicture.asset(
                                    subscription,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: displayWidth(context) * 0.05,
                                      top: displayHeight(context) * 0.015),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom:
                                                displayHeight(context) * 0.01),
                                        child: Text(
                                          "Subscription",
                                          style: TextStyle(
                                            fontFamily: "RobotoBold",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(),
                                        child: Text(
                                          "Enroll and get amazing cashbacks!",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize:
                                                displayWidth(context) * 0.04,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Center(
                child: Container(
                  child: Text("Active Orders"),
                ),
              ),
              Center(
                child: Container(
                  child: Text("Completed Orders"),
                ),
              ),
            ])),
      ),
    );
  }
}

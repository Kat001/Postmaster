import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Screens/Createorder.dart';
import 'package:postmaster/Screens/Homepage.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Profile.dart';
import 'package:postmaster/Screens/New_Orders.dart';
import 'package:postmaster/Screens/Chat.dart';
import 'package:sizer/sizer.dart';
import 'package:postmaster/Screens/Info.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentstate = 0;
  final List<Widget> _children = [Neworder(), Info(), Chat(), Profile()];
  // void onTappedBar(int index) {
  //   setState(() {
  //     _currentstate = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            exit(0);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          InkWell(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setString("token", null);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
            },
            child: Container(
              margin: EdgeInsets.only(right: 5.0.w, top: 1.0.h),
              child: Text(
                "Log Out",
                style: TextStyle(
                    fontFamily: 'RobotoBold',
                    fontSize: 18.0.sp,
                    color: Color(0xFF2AD0B5)),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: displayHeight(context) * 0.01,
          left: displayWidth(context) * 0.02,
          right: displayWidth(context) * 0.02,
        ),
        child: SizedBox(
          height: displayHeight(context) * 0.09,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(displayWidth(context) * 0.04),
            ),
            child: BottomAppBar(
              color: Color(0XFF2BCDB4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //New Orders
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentstate = 0;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.02,
                        left: displayWidth(context) * 0.05,
                        right: displayHeight(context) * 0.00,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: displayWidth(context) * 0.08,
                            height: displayHeight(context) * 0.03,
                            margin: EdgeInsets.only(
                              bottom: displayHeight(context) * 0.005,
                            ),
                            child: SvgPicture.asset(
                              add,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.005,
                            ),
                            child: Text("New Orders",
                                style: TextStyle(
                                  fontSize: displayHeight(context) * 0.015,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  //till here done with mediaquery
                  //Info
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentstate = 1;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.02,
                        left: displayWidth(context) * 0.05,
                        right: displayWidth(context) * 0.05,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: displayWidth(context) * 0.08,
                            height: displayHeight(context) * 0.03,
                            margin: EdgeInsets.only(
                              bottom: displayHeight(context) * 0.005,
                            ),
                            child: SvgPicture.asset(
                              info,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.005,
                            ),
                            child: Text(
                              "Info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: displayHeight(context) * 0.015,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Chat
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentstate = 2;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.02,
                        left: displayWidth(context) * 0.05,
                        right: displayWidth(context) * 0.05,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 8.0.w,
                            height: 3.0.h,
                            margin: EdgeInsets.only(
                              bottom: displayHeight(context) * 0.005,
                            ),
                            child: SvgPicture.asset(
                              chaticon,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.005,
                            ),
                            child: Text("Chat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: displayHeight(context) * 0.015,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Profile
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentstate = 3;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.02,
                        left: displayWidth(context) * 0.05,
                        right: displayWidth(context) * 0.05,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: displayHeight(context) * 0.08,
                            height: displayWidth(context) * 0.03,
                            margin: EdgeInsets.only(
                              bottom: displayHeight(context) * 0.005,
                            ),
                            child: SvgPicture.asset(
                              profile_icon,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                top: displayHeight(context) * 0.005,
                              ),
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: displayHeight(context) * 0.015,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _children[_currentstate],
    );
  }
}

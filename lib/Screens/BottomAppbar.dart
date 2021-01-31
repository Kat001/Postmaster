import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:postmaster/Screens/Createorder.dart';
//import 'package:postmaster/Screens/Homepage.dart';
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
import 'package:postmaster/Screens/Refer.dart';
import 'dart:io';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentstate = 0;
  final List<Widget> _children = [
    Neworder(),
    Chat(),
    Profile(),
    Info(),
  ];
  // void onTappedBar(int index) {
  //   setState(() {
  //     _currentstate = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: Refer()));
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: displayHeight(context) * 0.023,
                  right: displayWidth(context) * 0.06),
              child: Text(
                "Invite",
                style: TextStyle(
                  color: Color(0xFF27DEBF),
                  fontFamily: 'RobotoBold',
                  fontSize: displayWidth(context) * 0.05,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: displayWidth(context) * 0.05),
            width: 25,
            height: 25,
            child: SvgPicture.asset(
              language,
              color: Color(0xFF465A64),
            ),
          )
        ],
        leading: IconButton(
          onPressed: () async {
            // exit(0);
            return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are you sure?',
                        style: TextStyle(
                            fontFamily: "Roboto", color: Color(0xFF465A64))),
                    content: Text('Do you want to exit an App',
                        style: TextStyle(
                            fontFamily: "Roboto", color: Color(0xFF465A64))),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => exit(0),
                        child: Text('Yes',
                            style: TextStyle(
                                fontFamily: "RobotoBold",
                                color: Color(0xFF2BCDB4))),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        /*Navigator.of(context).pop(true)*/
                        child: Text('No',
                            style: TextStyle(
                                fontFamily: "RobotoBold",
                                color: Color(0xFF2BCDB4))),
                      ),
                    ],
                  ),
                ) ??
                false;
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      bottomNavigationBar: Container(
        height: _screenSize.height * 0.12,
        child: SizedBox(
          height: displayHeight(context) * 0.05,
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
                      top: displaySize(context).height * 0.02,
                      left: displayWidth(context) * 0.05,
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

                //Chat
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
                      _currentstate = 2;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: displayHeight(context) * 0.02,
                      //left: displayWidth(context) * 0.05,
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
              ],
            ),
          ),
        ),
      ),
      body: _children[_currentstate],
    );
  }
}

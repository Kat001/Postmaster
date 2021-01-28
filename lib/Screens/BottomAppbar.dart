import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/Screens/Createorder.dart';
import 'package:login/Screens/Login.dart';
import 'package:login/Components/customicons.dart';
import 'package:login/Components/animate.dart';
import 'package:login/Screens/Profile.dart';
import 'package:login/Screens/New_Orders.dart';
import 'package:login/Screens/Chat.dart';
import 'package:sizer/sizer.dart';
import 'package:login/Screens/Info.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentstate = 0;
  final List<Widget> _children = [neworder(), info(), Chat(), Profile()];
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
          onPressed: () {
            Navigator.push(context, SlideRightRoute(page: Login()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5.0.w, top: 1.0.h),
            child: Text(
              "Log Out",
              style: TextStyle(
                  fontFamily: 'RobotoBold',
                  fontSize: 18.0.sp,
                  color: Color(0xFF2AD0B5)),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 1.0.h, left: 2.0.w, right: 2.0.w),
        child: SizedBox(
          height: 9.0.h,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0.w),
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
                        _currentstate = 1;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 2.0.h, left: 5.0.w, right: 0.0.w),
                      child: Column(
                        children: [
                          Container(
                            width: 8.0.w,
                            height: 3.0.h,
                            margin: EdgeInsets.only(bottom: 0.5.h),
                            child: SvgPicture.asset(
                              add,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0.5.h),
                            child: Text("New Orders",
                                style: TextStyle(
                                  fontSize: 10.0.sp,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Info
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentstate = 2;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 2.0.h, left: 5.0.w, right: 5.0.w),
                      child: Column(
                        children: [
                          Container(
                            width: 8.0.w,
                            height: 3.0.h,
                            margin: EdgeInsets.only(bottom: 0.5.h),
                            child: SvgPicture.asset(
                              info,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0.5.h),
                            child: Text(
                              "Info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0.sp,
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
                        _currentstate = 3;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 2.0.h, left: 5.0.w, right: 5.0.w),
                      child: Column(
                        children: [
                          Container(
                            width: 8.0.w,
                            height: 3.0.h,
                            margin: EdgeInsets.only(bottom: 0.5.h),
                            child: SvgPicture.asset(
                              chaticon,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0.5.h),
                            child: Text("Chat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0.sp,
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
                        _currentstate = 0;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 2.0.h, left: 5.0.w, right: 5.0.w),
                      child: Column(
                        children: [
                          Container(
                            width: 8.0.w,
                            height: 3.0.h,
                            margin: EdgeInsets.only(bottom: 0.5.h),
                            child: SvgPicture.asset(
                              profile_icon,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 0.5.h),
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0.sp,
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

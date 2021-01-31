import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Screens/Refer.dart';
import 'package:postmaster/Screens/privacy.dart';
import 'package:postmaster/Screens/faq.dart';
import 'package:postmaster/Screens/terms.dart';
import 'package:postmaster/Screens/Topup.dart';
import 'package:sizer/sizer.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:postmaster/Components/sizes_helpers.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "XYZ,",
              style: TextStyle(
                  fontFamily: "RobotoBold",
                  fontSize: 28.0.sp,
                  color: Color(0xFF465A64)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 10),
            child: Text(
              "+91 1234567890",
              style: TextStyle(
                  fontFamily: "Roboto", fontSize: 18, color: Color(0xFF465A64)),
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Current Balance",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 130, right: 10),
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
                Container(
                  margin: EdgeInsets.only(top: 20, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Available Balance",
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
                      "Top Up Balance",
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
            height: 20.0.h,
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
          ),
          Container(
            margin: EdgeInsets.only(top: 40, left: 20),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    profile_icon,
                    color: Color(0xFF465A64),
                  ),
                ),
                Container(
                  child: Text(
                    "Personal Details",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25, left: 20),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    region,
                    color: Color(0xFF465A64),
                  ),
                ),
                Container(
                  child: Text(
                    "Region",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: Refer()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 25, left: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      refer,
                      color: Color(0xFF465A64),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Refer n Earn",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25, left: 20),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    language,
                    color: Color(0xFF465A64),
                  ),
                ),
                Container(
                  child: Text(
                    "Language",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 15, left: 65),
              child: Divider(
                color: Colors.black,
              )),
          InkWell(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: Terms()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 65),
              child: Text(
                "Terms and Conditions",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: Privacy()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 65),
              child: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: Faqs()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 65),
              child: Text(
                "FAQ",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 65),
            child: Text(
              "App Version",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 17,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setString("token", null);
              Navigator.push(context, SlideLeftRoute(page: Login()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 65),
              child: Text(
                "Logout",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

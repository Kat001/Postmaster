import 'package:flutter/material.dart';
import 'package:postmaster/Screens/example.dart';
import 'package:postmaster/models/user_data.dart';
import 'package:postmaster/Components/toast_utils.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Screens/Language.dart';
import 'package:postmaster/Screens/Personal_details.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Screens/Refer.dart';
import 'package:postmaster/Screens/Region.dart';

import 'package:postmaster/Screens/Mysubscription.dart';
import 'package:postmaster/Screens/Topup.dart';
import 'package:postmaster/Screens/example.dart';
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

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';
import 'package:postmaster/Screens/App_version.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String firstName = "";
  String middleName = "";
  String lastName = "";
  String email = "";
  String phon = "";

  @override
  void initState() {
    super.initState();
    fetchInformation();
  }

  Future fetchInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      firstName = prefs.getString("first_name");
      lastName = prefs.getString("last_name");
      email = prefs.getString("email");
      phon = prefs.getString("phn_number");
    });
  }

  /* Future<http.Response> fetchInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res;
    if (token != null) {
      res = await http.get(
        'https://www.mitrahtechnology.in/apis/mitrah-api/user-info.php',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token,
        },
      );
      print(res.body);
      var responseData = json.decode(res.body);

      var data = responseData["message"];

      setState(() {
        firstName = data["first_name"];
        lastName = data["last_name"];
        email = data["email"];
        phon = data["phn_number"];
      });
    } else {}

    /*} else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", responseData['message'], "Cancel"));
    }*/
    return res;
  */
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
            margin: EdgeInsets.only(left: 85.0),
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
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "$firstName $lastName",
              style: TextStyle(
                  fontFamily: "RobotoBold",
                  fontSize: 28.0.sp,
                  color: Color(0xFF465A64)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 10),
            child: Text(
              "+91 $phon",
              style: TextStyle(
                  fontFamily: "Roboto", fontSize: 18, color: Color(0xFF465A64)),
            ),
          ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowWidget("Current Balance:", "₹0"),
                      SizedBox(height: 12.0),
                      rowWidget("Available Balance:", "₹0"),
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
                              Navigator.push(
                                  context, SlideLeftRoute(page: Topup()));
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
          ),
          Container(
            margin: EdgeInsets.only(top: 40, left: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  SlideLeftRoute(page: PersonalDetails()),
                );
              },
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
          ),
          Container(
            margin: EdgeInsets.only(top: 25, left: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(context, SlideLeftRoute(page: Mysubscription()));
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      subscription,
                      color: Color(0xFF465A64),
                    ),
                  ),
                  Container(
                    child: Text(
                      "My subscription",
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
            child: InkWell(
              onTap: () {
                Navigator.push(context, SlideLeftRoute(page: Region()));
              },
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
            child: InkWell(
              onTap: () {
                Navigator.push(context, SlideLeftRoute(page: Language()));
              },
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
          ),
          Container(
              margin: EdgeInsets.only(top: 15, left: 65),
              child: Divider(
                color: Colors.black,
              )),
          InkWell(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: AppVersion()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 25,
                    height: 25,
                    // child: SvgPicture.asset(
                    //   //version,
                    //   color: Color(0xFF465A64),
                    // ),
                  ),
                  Container(
                    child: Text(
                      "App Version",
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
          InkWell(
            onTap: () async {
              return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Are you sure?',
                          style: TextStyle(
                              fontFamily: "Roboto", color: Color(0xFF465A64))),
                      content: Text('Do you want to Logout from an App',
                          style: TextStyle(
                              fontFamily: "Roboto", color: Color(0xFF465A64))),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("token", null);
                            Navigator.push(
                                context, SlideLeftRoute(page: Login()));
                          },
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
          SizedBox(height: 100.0)
        ],
      ),
    ));
  }
}

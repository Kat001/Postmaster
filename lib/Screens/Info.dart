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

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: Terms()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      terms_and_conditions,
                      color: Color(0xFF465A64),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Terms and Conditions",
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
              Navigator.push(context, SlideLeftRoute(page: Privacy()));
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
                      privacy_policy,
                      color: Color(0xFF465A64),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Privacy Policy",
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
              Navigator.push(context, SlideLeftRoute(page: Faqs()));
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
                      faq,
                      color: Color(0xFF465A64),
                    ),
                  ),
                  Container(
                    child: Text(
                      "FAQ",
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
        ],
      ),
    ));
  }
}

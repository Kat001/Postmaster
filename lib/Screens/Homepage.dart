import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Screens/Createorder.dart';
import 'package:postmaster/Screens/Signup.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Components/sizes_helpers.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: new EdgeInsets.only(top: 60, bottom: 20),
            child: Image(
              image: AssetImage('assets/images/login.jpg'),
              height: displayHeight(context) * 0.33,
              width: displayWidth(context) * 0.50,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(
              left: displayWidth(context) * 0.2,
              right: displayWidth(context) * 0.2,
              bottom: displayHeight(context) * 0.04,
            ),
            child: MaterialButton(
              // color: Color(0xFF27DEBF),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()));
              },
              minWidth: displayWidth(context) * 0.5,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8.0)),
              height: displayHeight(context) * 0.06,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: displayWidth(context) * 0.06,
                  fontFamily: 'roboto',
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                gradient: RadialGradient(
                    radius: 15,
                    colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
          ),
          Container(
            margin: new EdgeInsets.only(
              left: displayWidth(context) * 0.2,
              right: displayWidth(context) * 0.2,
              bottom: displayHeight(context) * 0.04,
            ),
            child: MaterialButton(
              // color: Color(0xFF27DEBF),

              onPressed: () {
                Navigator.push(context, SlideLeftRoute(page: Signup()));
              },
              minWidth: displayWidth(context) * 0.5,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8.0)),
              height: displayHeight(context) * 0.06,
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: displayWidth(context) * 0.06,
                  fontFamily: 'roboto',
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                gradient: RadialGradient(
                    radius: 15,
                    colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
          ),
          Container(
            margin: new EdgeInsets.only(
              left: displayWidth(context) * 0.2,
              right: displayWidth(context) * 0.2,
              bottom: displayHeight(context) * 0.04,
            ),
            child: MaterialButton(
              // color: Color(0xFF27DEBF),
              onPressed: () {
                Navigator.push(context, SlideLeftRoute(page: CreateOrder()));
              },
              minWidth: displayWidth(context) * 0.5,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8.0)),
              height: displayHeight(context) * 0.06,
              child: Text(
                "Create Order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: displayWidth(context) * 0.06,
                  fontFamily: 'roboto',
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                gradient: RadialGradient(
                    radius: 15,
                    colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
          ),
          //Till here done with media query
          Container(
            margin: new EdgeInsets.only(
                bottom: displayHeight(context) * 0.02,
                top: displayHeight(context) * 0.01),
            child: Text(
              "- Or Sign in with -",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF707070),
                fontSize: displayWidth(context) * 0.04,
              ),
            ),
          ),
          //till here done with media query
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: displayWidth(context) * 0.33,
                ),
                child: FloatingActionButton(
                  heroTag: 'btn3',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: displayWidth(context) * 0.01,
                        vertical: displayHeight(context) * 0.01),
                    child: SvgPicture.asset(
                      google_plus,
                      color: Color(0xFF465A64),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: displayWidth(context) * 0.05),
                  child: FloatingActionButton(
                    heroTag: 'btn4',
                    onPressed: () {},
                    backgroundColor: Color(0xFF465A64),
                    child: Container(
                      child: SvgPicture.asset(
                        facebook_logo,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

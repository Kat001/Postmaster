import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Screens/Createorder.dart';
import 'package:postmaster/Screens/Signup.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/animate.dart';

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
              height: 266.0,
              width: 266.0,
            ),
          ),
          Container(
            margin: new EdgeInsets.only(left: 75, right: 75, bottom: 20),
            child: MaterialButton(
              // color: Color(0xFF27DEBF),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()));
              },
              minWidth: 250.0,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8.0)),
              height: 45.0,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
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
            margin: new EdgeInsets.only(left: 75, right: 75, bottom: 20),
            child: MaterialButton(
              // color: Color(0xFF27DEBF),

              onPressed: () {
                Navigator.push(context, SlideLeftRoute(page: Signup()));
              },
              minWidth: 250.0,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8.0)),
              height: 45.0,
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
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
            margin: new EdgeInsets.only(left: 75, right: 75, bottom: 20),
            child: MaterialButton(
              // color: Color(0xFF27DEBF),
              onPressed: () {
                Navigator.push(context, SlideLeftRoute(page: CreateOrder()));
              },
              minWidth: 250.0,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8.0)),
              height: 45.0,
              child: Text(
                "Create Order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
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
            margin: new EdgeInsets.only(bottom: 30, top: 10.0),
            child: Text(
              "- Or Sign in with -",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF707070), fontSize: 16.0),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 115),
                child: FloatingActionButton(
                  heroTag: 'btn3',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: SvgPicture.asset(
                      google_plus,
                      color: Color(0xFF465A64),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
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

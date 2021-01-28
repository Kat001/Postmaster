import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Screens/SetPassword.dart';
import 'package:postmaster/Screens/Signup.dart';
import 'package:postmaster/Components/animate.dart';

class Otpclass extends StatefulWidget {
  @override
  _OtpclassState createState() => _OtpclassState();
}

class _OtpclassState extends State<Otpclass> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, SlideRightRoute(page: Signup()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: new EdgeInsets.only(top: 0, bottom: 20),
                // child: Image(
                //   image: AssetImage('assets/images/otppic.jpg'),
                //   height: 266.0,
                //   width: 266.0,
                // ),
                child: SvgPicture.asset(
                  otppic,
                  height: 266.0,
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    "Enter OTP",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: TextFormField(
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            nextField(value, pin2FocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: TextFormField(
                          focusNode: pin2FocusNode,
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            nextField(value, pin3FocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: TextFormField(
                          focusNode: pin3FocusNode,
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            nextField(value, pin4FocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: TextFormField(
                          focusNode: pin4FocusNode,
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            nextField(value, pin5FocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: TextFormField(
                          focusNode: pin5FocusNode,
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            pin5FocusNode.unfocus();
                          },
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: new EdgeInsets.only(
                    left: 75, right: 75, bottom: 20, top: 60),
                child: MaterialButton(
                  // color: Color(0xFF27DEBF),
                  onPressed: () {
                    Navigator.push(
                        context, SlideLeftRoute(page: Setpassword()));
                  },
                  minWidth: 250.0,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8.0)),
                  height: 45.0,
                  child: Text(
                    "Set Password",
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
            ],
          ),
        ),
      ),
    );
  }
}

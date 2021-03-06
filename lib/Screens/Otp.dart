import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Screens/SetPassword.dart';
import 'package:postmaster/Screens/Setnewpassword.dart';
import 'package:postmaster/Screens/Signup.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Otpclass extends StatefulWidget {
  Otpclass({
    Key key,
    this.phn_number,
  }) : super(key: key);

  final String phn_number;
  @override
  _OtpclassState createState() => _OtpclassState();
}

class _OtpclassState extends State<Otpclass> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;

  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();
  final TextEditingController _fifthController = TextEditingController();
  final TextEditingController _sixthController = TextEditingController();

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
                          controller: _firstController,
                          maxLength: 1,
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            counterText: "",
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
                          controller: _secondController,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          maxLength: 1,
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            counterText: "",
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
                          controller: _thirdController,
                          maxLength: 1,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            counterText: "",
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
                          controller: _fourthController,
                          maxLength: 1,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            counterText: "",
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
                          controller: _fifthController,
                          maxLength: 1,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            nextField(value, pin6FocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: TextFormField(
                          focusNode: pin6FocusNode,
                          controller: _sixthController,
                          maxLength: 1,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            pin6FocusNode.unfocus();
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
                    print(_firstController.text);
                    verifyUser();
                    //Navigator.push(
                    //  context, SlideLeftRoute(page: Setpassword()));
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
              Center(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            new EdgeInsets.only(bottom: 30, top: 4.0, left: 85),
                        child: Text(
                          "- Resend Otp -",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF707070), fontSize: 16.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          reSendOtp();
                          //Navigator.push(
                          //context, SlideLeftRoute(page: ForgotPassword()));
                        },
                        child: Container(
                          margin: new EdgeInsets.only(
                            bottom: 30,
                            top: 4.0,
                          ),
                          child: Text(
                            " Click Here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF27DEBF),
                                fontSize: 16.0,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> verifyUser() async {
    String code = _firstController.text +
        _secondController.text +
        _thirdController.text +
        _fourthController.text +
        _fifthController.text +
        _sixthController.text;

    //Navigator.push(context, SlideLeftRoute(page: Otpclass()));
    //Navigator.push(context, SlideLeftRoute(page: SetPassword()));

    //String body = json.encode(data);

    http.Response res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/forgot_password_verify_otp.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'phn_number': widget.phn_number,
        'otp': code,
      },
    );

    print(res.body);
    var responseData = json.decode(res.body);
    if (responseData['status'] == 200) {
      Navigator.push(context,
          SlideLeftRoute(page: Setpassword(phn_number: widget.phn_number)));
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", responseData['message'], "Cancel"));
    }
    return res;
  }

  Future<http.Response> reSendOtp() async {
    String phonNo = widget.phn_number;
    print(phonNo);
    //Navigator.push(context, SlideLeftRoute(page: Otpclass()));
    //Navigator.push(context, SlideLeftRoute(page: SetPassword()));

    Map data = {"phn_number": phonNo};

    //String body = json.encode(data);

    http.Response res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/forgot_password.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'phn_number': phonNo,
      },
    );

    print(res.body);
    var responseData = json.decode(res.body);
    if (responseData['status'] == 200) {
      CustomDialog("Success", "Resended successfully", "Okay", 1);
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", "User does not exists", "Cancel"));
    }
    return res;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:postmaster/Screens/Set_New_pass.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _phnController = TextEditingController();
  var _formKey1 = GlobalKey<FormState>();
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
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: displayHeight(context) * 0.02,
                  left: displayWidth(context) * 0.05),
              child: Text(
                "Enter your registered phone number",
                style: TextStyle(
                    fontFamily: "RobotoBold",
                    fontSize: displayWidth(context) * 0.07,
                    color: Color(0xFF465A64)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: displayHeight(context) * 0.03,
                left: displayWidth(context) * 0.05,
                right: displayWidth(context) * 0.04,
              ),
              child: Text(
                '''You will get an OTP on that phone number.''',
                style: TextStyle(
                    fontFamily: "RobotoBold",
                    fontSize: displayWidth(context) * 0.035,
                    color: Color(0xFF465A64)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: displayHeight(context) * 0.05,
                left: displayWidth(context) * 0.05,
                right: displayWidth(context) * 0.04,
              ),
              child: Form(
                key: _formKey1,
                child: TextFormField(
                  controller: _phnController,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Enter phone number";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter phone no',
                  ),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF2BCDB4),
          onPressed: () {
            if (_formKey1.currentState.validate()) {
              cheakUser();
            }
          },
          child: Container(
            width: 25,
            height: 25,
            child: SvgPicture.asset(
              arrow,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void /*http.Response*/ > cheakUser() async {
    String phonNo = _phnController.text;
    print(phonNo);
    Navigator.push(context, SlideLeftRoute(page: SetPassword()));

    /*Map data = {
      "phn_number": phonNo
    };
    
    //String body = json.encode(data);

    http.Response res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/register.php',
      /* headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },*/
      body: body,
    );*/

    //print(res.body);
    /*var responseData = json.decode(res.body);
    if (responseData['success'] == 1) {
      Navigator.push(context, SlideLeftRoute(page: Otpclass()));
    } else if (responseData['status'] == 500) {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", "User already Exists", "Cancel"));
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", responseData['message'], "Cancel"));
    }*/
    //return res;
  }
}

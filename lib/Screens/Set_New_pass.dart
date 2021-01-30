import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';
import 'package:postmaster/Screens/Homepage.dart';

import 'package:postmaster/Components/animate.dart';

import 'package:postmaster/Screens/Forgot_pass.dart';
//import 'package:http/http.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, SlideRightRoute(page: Homepage()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: new EdgeInsets.only(top: 1, right: 35, left: 35),
                  child: Image(
                    image: AssetImage('assets/images/logins.png'),
                    height: 266.0,
                    width: 266.0,
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(left: 30, right: 30),
                  child: ListTile(
                    title: TextFormField(
                      controller: passController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter password.";
                        }

                        //return "";
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter password',
                      ),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: ListTile(
                    title: TextFormField(
                      controller: confirmpassController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter the Confirm Password";
                        }
                        //return "";
                      },
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(left: 75, right: 75, top: 40),
                  child: MaterialButton(
                    // color: Color(0xFF27DEBF),
                    onPressed: () {
                      print("login clicked..");
                      if (_formKey.currentState.validate()) {
                        setforgotPassword();
                      }
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
                        fontFamily: 'RobotoBold',
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
      ),
    );
  }

  Future<void /*http.Response*/ > setforgotPassword() async {
    String pass = passController.text;
    String confirmPass = confirmpassController.text;

    if (pass == confirmPass) {
      print("done");
      Navigator.pushReplacement(context, SlideLeftRoute(page: SetPassword()));
    } else {
      showDialog(
          context: context,
          builder: (context) => CustomDialogError("Error",
              "Confirm Password should be same as  Password!", "Cancel"));
    }

    /*http.Response res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/login.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "user_id": user_id,
        "password": user_pass,
      },
    );
    print(res.body);
    var responseData = json.decode(res.body);

    if (responseData['success'] == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['token']);
      //SharedPreferences prefs = await SharedPreferences.getInstance();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", responseData['message'], "Cancel"));
    }*/
    //return res;
  }
}

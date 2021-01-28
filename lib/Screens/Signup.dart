import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Homepage.dart';
import 'package:postmaster/Screens/Otp.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:email_validator/email_validator.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          backgroundColor: Colors.white,
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
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin:
                        new EdgeInsets.only(right: 35, left: 35, bottom: 10),
                    child: Image(
                      image: AssetImage('assets/images/signup.png'),
                      height: 220.0,
                      width: 220.0,
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: firstNameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the first name.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'First Name',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: lastNameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the last name.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'Last Name',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: emailController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the email.";
                          }
                          if (!EmailValidator.validate(value)) {
                            return "Enter valid email";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'Email',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the phone no.";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: 'Phone Number',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 75, right: 75, top: 25),
                    child: MaterialButton(
                      // color: Color(0xFF27DEBF),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          createUser();
                        }
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
                    margin: new EdgeInsets.only(top: 25.0, bottom: 25),
                    child: Text(
                      "- Or Sign Up with -",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color(0xFF707070), fontSize: 16.0),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 120),
                        child: FloatingActionButton(
                          heroTag: 'btn3',
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
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
                  ),
                ],
              ),
            ),
          )),
    );
  }

  /* Future<http.Response> createUser() {
    return http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/register.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "first_name": "mieethvhg",
        "last_name": "teceeehbjhghj",
        "email": "acbdevcdtc@t.com",
        "password": "dev12345",
        "phn_number": "9012101240"
      }),
    );
  }*/

  Future<http.Response> createUser() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String phn_number = phoneController.text;

    Map data = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": "dev12345",
      "phn_number": phn_number
    };
    String body = json.encode(data);

    http.Response res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/register.php',
      /* headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },*/
      body: body,
    );

    print(res.body);
    var responseData = json.decode(res.body);
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
    }
    return res;
  }
}

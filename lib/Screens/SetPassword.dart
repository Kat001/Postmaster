import 'package:flutter/material.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Screens/Otp.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Setpassword extends StatefulWidget {
  Setpassword({
    Key key,
    this.phn_number,
  }) : super(key: key);

  final String phn_number;
  @override
  _SetpasswordState createState() => _SetpasswordState();
}

class _SetpasswordState extends State<Setpassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  var _formKey = GlobalKey<FormState>();

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
                //Navigator.push(context, SlideRightRoute(page: Otpclass()));
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
                      image: AssetImage('assets/images/setpass.jpg'),
                      height: 220.0,
                      width: 220.0,
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: ListTile(
                      title: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          labelText: 'Enter Password',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: ListTile(
                      title: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          labelText: 'Confirm Password',
                        ),
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.only(left: 70, right: 70, top: 35),
                    child: MaterialButton(
                      // color: Color(0xFF27DEBF),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            savePassword();
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialogError("Error",
                                    "password must be same", "Cancel"));
                          }
                        }
                      },
                      minWidth: 250.0,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(8.0)),
                      height: 45.0,
                      child: Text(
                        "Save",
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
          )),
    );
  }

  Future<http.Response> savePassword() async {
    //Navigator.push(context, SlideLeftRoute(page: Otpclass()));
    //Navigator.push(context, SlideLeftRoute(page: SetPassword()));

    //String body = json.encode(data);

    http.Response res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/forgot_password_update.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'phn_number': widget.phn_number,
        'new_password': _passwordController.text,
      },
    );

    print(res.body);
    var responseData = json.decode(res.body);
    if (responseData['status'] == 200) {
      Navigator.push(context, SlideLeftRoute(page: Login()));
      showDialog(
        context: context,
        builder: (context) =>
            CustomDialog("Success", responseData['message'], "Okay", 3),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", responseData['message'], "Cancel"));
    }
    return res;
  }
}

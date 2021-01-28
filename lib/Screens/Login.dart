import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login/Screens/BottomAppbar.dart';
import 'package:login/Screens/Homepage.dart';
import 'package:login/Components/animate.dart';
import 'package:http/http.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter the first name.";
                        }
                        if (!EmailValidator.validate(value)) {
                          return "Enter valid email";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email or Phone Numbers',
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter the Password";
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
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
                      if (_formKey.currentState.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Dashboard();
                        }));
                      }
                    },
                    minWidth: 250.0,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0)),
                    height: 45.0,
                    child: Text(
                      "Sign In",
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
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: new EdgeInsets.only(
                            bottom: 30, top: 40.0, left: 75),
                        child: Text(
                          "- Forgot Password -",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF707070), fontSize: 16.0),
                        ),
                      ),
                      Container(
                        margin: new EdgeInsets.only(
                          bottom: 30,
                          top: 40.0,
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

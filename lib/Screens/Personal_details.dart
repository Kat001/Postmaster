import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Screens/Refer.dart';
import 'package:postmaster/Screens/privacy.dart';
import 'package:postmaster/Screens/faq.dart';
import 'package:postmaster/Screens/terms.dart';
import 'package:postmaster/Screens/Topup.dart';
import 'package:sizer/sizer.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchInformation();
  }

  Future fetchInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //firstName = prefs.getString("first_name");
    //print("first:" + firstName);

    setState(() {
      _firstNameController.text = prefs.getString("first_name");
      _lastNameController.text = prefs.getString("last_name");
      _emailController.text = prefs.getString("email");
      _phoneController.text = "+91 " + prefs.getString("phn_number");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Personal details",
            style: TextStyle(
                fontFamily: "RobotoBold",
                fontSize: 20.0,
                color: Color(0xFF2AD0B5)),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          )),
      body: Container(
        margin: EdgeInsets.only(
          left: displayWidth(context) * 0.10,
          right: displayWidth(context) * 0.10,
          top: displayHeight(context) * 0.02,
        ),
        child: Column(children: <Widget>[
          TextFormField(
            controller: _firstNameController,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            //initialValue: "data(1)",
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'First name',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _lastNameController,
            //initialValue: "lastName",
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'Last name',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _phoneController,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'Phone number',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _emailController,
            /*controller: emailController,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter the email.";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter valid email";
              }
            },*/
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: 'Email for authorisation',
            ),
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 18,
            ),
          ),
          Center(
            child: Container(
              margin: new EdgeInsets.only(top: 40),
              child: MaterialButton(
                // color: Color(0xFF27DEBF),
                onPressed: () {},
                minWidth: 250.0,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8.0)),
                height: 45.0,
                child: Text(
                  "Save",
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
          ),
          Center(
            child: Row(
              children: [
                Container(
                  margin: new EdgeInsets.only(bottom: 30, top: 30.0, left: 50),
                  child: Text(
                    "- Change Password -",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF707070), fontSize: 16.0),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //Navigator.push(
                    //context, SlideLeftRoute(page: ForgotPassword()));
                  },
                  child: Container(
                    margin: new EdgeInsets.only(
                      bottom: 30,
                      top: 30.0,
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
        ]),
      ),
    );
  }
}

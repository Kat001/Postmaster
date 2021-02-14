import 'package:flutter/material.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Otp.dart';

class Setpassword extends StatefulWidget {
  @override
  _SetpasswordState createState() => _SetpasswordState();
}

class _SetpasswordState extends State<Setpassword> {
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
                Navigator.push(context, SlideRightRoute(page: Otpclass()));
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: new EdgeInsets.only(right: 35, left: 35, bottom: 10),
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
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog("Success",
                            "Password Created Successfully", "Okay", 1),
                      );
                    },
                    minWidth: 250.0,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0)),
                    height: 45.0,
                    child: Text(
                      "Confirm Password",
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
          )),
    );
  }
}

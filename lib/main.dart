import 'package:flutter/material.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';
<<<<<<< HEAD
import 'package:postmaster/Screens/NewOrdertest.dart';
=======
import 'package:postmaster/Screens/Forgot_pass.dart';
import 'package:postmaster/Screens/Location.dart';
>>>>>>> 38b84f1c863a9b91de25f8cd50facac55341ca92
//import 'package:postmaster/Screens/faq.dart';
//import 'package:postmaster/Screens/privacy.dart';
//import 'package:postmaster/Screens/terms.dart';
import 'Screens/Homepage.dart';
//import 'Screens/Login.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:postmaster/Components/animate.dart';
//import 'package:flutter/scheduler.dart';

void main() => runApp(Myapp());

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if (token != null) {
      setState(() {
        isLoggedIn = true;
      });

      return;
    } else {
      setState(() {
        isLoggedIn = false;
      });

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //return LayoutBuilder
      builder: (context, constraints) {
        return OrientationBuilder(
          //return OrientationBuilder
          builder: (context, orientation) {
            //initialize SizerUtil()
            SizerUtil().init(constraints, orientation); //initialize SizerUtil
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Postman",
              theme: ThemeData(primaryColor: Color(0xFF27DEBF)),
              home: isLoggedIn ? Dashboard() : Homepage(),
            );
          },
        );
      },
    );
  }

  /*void cheak_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    var token = logindata.getString("token");
    print(token);

    if (token != null) {
    } else {
      print("nahi hain");
    }
  }*/
}

/*// Widget build(BuildContext context) {
//     return LayoutBuilder(                           //return LayoutBuilder
//       builder: (context, constraints) {
//         return OrientationBuilder(                  //return OrientationBuilder
//           builder: (context, orientation) {
//             //initialize SizerUtil()
//             SizerUtil().init(constraints, orientation);  //initialize SizerUtil
//             return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               title: "Login",
//               theme: ThemeData(primaryColor: Color(0xFF27DEBF)),
//               home: Homepage(),
//             );
//           },
//         );
//       },
//     );
//   }*/

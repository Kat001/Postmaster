import 'package:flutter/material.dart';
import 'Screens/Homepage.dart';
import 'Screens/Login.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
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
              title: "Login",
              theme: ThemeData(primaryColor: Color(0xFF27DEBF)),
              home: Homepage(),
            );
          },
        );
      },
    );
  }
}

// Widget build(BuildContext context) {
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
//   }

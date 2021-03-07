/*import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/l10n.dart'
    as location_picker;
import 'package:google_map_location_picker/google_map_location_picker.dart';
//import 'package:google_map_location_picker_example/keys.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'generated/i18n.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LocationResult _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      theme: ThemeData.dark(),
      title: 'location picker',
      localizationsDelegates: const [
        location_picker.S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', ''),
        Locale('ar', ''),
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('location picker'),
        ),
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    LocationResult result = await showLocationPicker(
                      context,
                      "AIzaSyCy2iHXEQ9U4c77tJSBW5WPD5vRA8EEH94",
                      initialCenter: LatLng(31.1975844, 29.9598339),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                      myLocationButtonEnabled: true,
                      // requiredGPS: true,
                      layersButtonEnabled: true,
                      // countries: ['AE', 'NG']

//                      resultCardAlignment: Alignment.bottomCenter,
                      desiredAccuracy: LocationAccuracy.best,
                    );
                    print("result = $result");
                    setState(() => _pickedLocation = result);
                  },
                  child: Text('Pick location'),
                ),
                Text(_pickedLocation.toString()),
              ],
            ),
          );
        }),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:postmaster/Screens/Favroite_store.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';
import 'package:postmaster/Screens/Mysubscription.dart';
import 'package:postmaster/Screens/NewOrderrest.dart';
import 'package:postmaster/Screens/Forgot_pass.dart';
import 'package:postmaster/Screens/Location.dart';
import 'package:postmaster/Screens/Neworderstore.dart';
import 'package:postmaster/Screens/Otp.dart';
import 'package:postmaster/Screens/Region.dart';
import 'package:postmaster/Screens/SetPassword.dart';
import 'package:postmaster/Screens/example.dart';
import 'package:postmaster/Screens/signupotp.dart';
import 'package:postmaster/Screens/signupsetpassword.dart';
//import 'package:postmaster/Screens/faq.dart';
//import 'package:postmaster/Screens/privacy.dart';
//import 'package:postmaster/Screens/terms.dart';
import 'package:google_map_location_picker/generated/l10n.dart'
    as location_picker;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/Homepage.dart';
//import 'Screens/Login.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Subscription.dart';
import 'package:postmaster/Screens/Profile.dart';
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
              localizationsDelegates: const [
                location_picker.S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const <Locale>[
                Locale('en', ''),
                Locale('ar', ''),
              ],
              debugShowCheckedModeBanner: false,
              title: "Postman",
              theme: ThemeData(
                primaryColor: Color(0xFF27DEBF),
                dividerColor: Colors.transparent,
              ),
              home: isLoggedIn ? Dashboard() : Homepage(), //Mysubscription(),
            );
          },
        );
      },
    );
  }
}

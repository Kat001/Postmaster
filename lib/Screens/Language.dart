import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Language",
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
      body: Container(),
    );
  }
}

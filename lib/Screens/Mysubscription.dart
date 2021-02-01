import 'package:flutter/material.dart';

class Mysubscription extends StatefulWidget {
  @override
  _MysubscriptionState createState() => _MysubscriptionState();
}

class _MysubscriptionState extends State<Mysubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "My Subscriptions",
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  double data = 0;
  var textdata = "";
  bool isApply = true;
  TextEditingController _dataController = TextEditingController();
  TextEditingController _itemController = TextEditingController();
  TextEditingController _promoCodeController = TextEditingController();
  List<String> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchInitialData();
  }

  String _name(dynamic user) {
    return user['item'];
  }

  String _age(Map<dynamic, dynamic> user) {
    return user['id'].toString();
  }

  Future<List<dynamic>> fetchInitialData() async {
    http.Response res = await http.get(
      'https://www.mitrahtechnology.in/apis/mitrah-api/order/getdetail.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "user": "admin",
        "password": "1234",
        "table_name": "item"
      },
    );
    //print(res.body);
    //var responseData = json.decode(res.body);

    //print(responseData);
    /*
    */

    return json.decode(res.body)['message'];
  }

  Widget item(String itemtype) {
    return InkWell(
      onTap: () {
        setState(() {
          _itemController.text = itemtype;
        });
      },
      child: Container(
        //height: 50.0,
        //width: 100.0,
        //color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(itemtype),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.cyan,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Add entries'),
          onPressed: () async {
            String persons = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Locaton(),
              ),
            );
            if (persons != null) print(persons);
          },
        ),
      ),
    );
  }
}

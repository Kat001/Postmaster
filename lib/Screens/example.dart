import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postmaster/Components/animate.dart';
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
      appBar: AppBar(
        title: Text("Just for Cheaking"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _promoCodeController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 0),
                labelText: "Promocode",
                suffixIcon: InkWell(
                  onTap: () async {
                    setState(() {
                      if (_promoCodeController.text.isEmpty) {
                        return;
                      } else {
                        isApply = false;
                      }
                    });
                    var promodata = _promoCodeController.text;
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    String token = prefs.getString("token");
                    Map data = {
                      "promo_code": promodata,
                    };
                    var body = json.encode(data);

                    http.Response res = await http.post(
                      'https://www.mitrahtechnology.in/apis/mitrah-api/order/getpromoamount.php',
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        "Authorization": token,
                      },
                      body: body,
                    );
                    print(res.body);
                    var responseData = json.decode(res.body);
                    if (responseData['success'] == 1) {
                      setState(() {
                        isApply = true;
                        CustomDialog("Success",
                            "You saved $responseData['amount']", "Cancel", 3);
                      });
                    }
                  },
                  child: Container(
                    width: 80.0,
                    height: 20.0,
                    margin: EdgeInsets.only(bottom: 5.0, top: 5.0, right: 5.0),
                    child: isApply
                        ? Center(child: Text("Apply"))
                        : Center(
                            child: SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator())),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Colors.greenAccent,
                    ),
                  ),
                )),
          ),
          SizedBox(height: 5.0),
          TextFormField(
            readOnly: true,
            controller: _itemController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 0),
              labelText: "What are you sending?",
            ),
          ),
          SizedBox(height: 5.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Container(
              height: 80.0,
              decoration: BoxDecoration(
                  //color: const Color(0xff7c94b6),
                  ),
              child: Wrap(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 20,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: displayWidth(context) * 0.02,
                        top: displayHeight(context) * 0.01),
                    height: displayHeight(context) * 0.05,
                    width: displayWidth(context) * 0.3,
                    child: Text(
                      "Up to 100 kg ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'RobotoBold',
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.05,
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Color(0xFF27DEBF)),
                  ),
                  item("bu"),
                  item("butvhgfdwqeweeawreawreawreawrerere"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                  item("button3"),
                ],
              ),
            ),
          ),
          /* Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: FutureBuilder<List<dynamic>>(
                future: fetchInitialData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    //print(_age(snapshot.data[0]));
                    return SizedBox(
                      height: 500.0,
                      child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      print(snapshot.data[index]["item"]);
                                      setState(() {
                                        _itemController.text =
                                            snapshot.data[index]["item"];
                                      });
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data[index]["item"]),
                                      subtitle: Text("hiii"),
                                      trailing:
                                          Text(_age(snapshot.data[index])),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

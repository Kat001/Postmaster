import 'package:flutter/material.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/models/activeorders.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  final _formKey = GlobalKey<FormState>();
  List<Sendactiveorders> _sendactiveorders = List<Sendactiveorders>();
  List<Sendactiveorders> _sendactiveordersForDisplay = List<Sendactiveorders>();

  List<Shopactiveorders> _sendactiveshoporders = List<Shopactiveorders>();
  List<Shopactiveorders> _sendactiveshopordersForDisplay =
      List<Shopactiveorders>();

  List<Restaurantactiveorders> _restaurantactiveorders =
      List<Restaurantactiveorders>();
  List<Restaurantactiveorders> _restaurantactiveordersForDisplay =
      List<Restaurantactiveorders>();

  bool _isdata = false;

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        _sendactiveorders.addAll(value);

        _sendactiveordersForDisplay = _sendactiveorders;
      });
    });

    getShopData().then((value) {
      setState(() {
        _sendactiveshoporders.addAll(value);

        _sendactiveshopordersForDisplay = _sendactiveshoporders;
      });
    });

    getRestaurantData().then((value) {
      setState(() {
        _restaurantactiveorders.addAll(value);

        _restaurantactiveordersForDisplay = _restaurantactiveorders;
        _isdata = true;
      });
    });
  }

  Future<List<Sendactiveorders>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res = await http.get(
      'https://www.mitrahtechnology.in/apis/mitrah-api/active_order.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token
      },
    );
    //print(res.body);
    var responseData = json.decode(res.body);

    var sendactiveorders = List<Sendactiveorders>();

    if (responseData["status"] == 200) {
      var notesJson = responseData["message"];
      for (var noteJson in notesJson) {
        sendactiveorders.add(Sendactiveorders.fromJson(noteJson));
        //print(Sendactiveorders.fromJson(noteJson));
      }
    }

    return sendactiveorders;
  }

  Future<List<Shopactiveorders>> getShopData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res = await http.get(
      'https://www.mitrahtechnology.in/apis/mitrah-api/active_order_shop.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token
      },
    );

    var responseData = json.decode(res.body);

    var sendactiveshoporders = List<Shopactiveorders>();

    if (responseData["status"] == 200) {
      var notesJson = responseData["message"];
      for (var noteJson in notesJson) {
        sendactiveshoporders.add(Shopactiveorders.fromJson(noteJson));
        //print(Sendactiveorders.fromJson(noteJson));
      }
    }

    return sendactiveshoporders;
  }

  Future<List<Restaurantactiveorders>> getRestaurantData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res = await http.get(
      'https://www.mitrahtechnology.in/apis/mitrah-api/active_order_restaurant.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token
      },
    );

    var responseData = json.decode(res.body);

    var sendactivrestaurantorders = List<Restaurantactiveorders>();

    if (responseData["status"] == 200) {
      var notesJson = responseData["message"];
      for (var noteJson in notesJson) {
        sendactivrestaurantorders
            .add(Restaurantactiveorders.fromJson(noteJson));
        //print(Sendactiveorders.fromJson(noteJson));
      }
    }

    return sendactivrestaurantorders;
  }

  Widget orderWidget(String orderid, String orderTotal, String pickUpAddress,
      String dropAddress) {
    return new Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFF0F0F0),
              blurRadius: 5.0,
              spreadRadius: 5.0,
            )
          ]),
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order-id:#" + orderid,
              style: TextStyle(
                fontFamily: "RobotoBold",
                fontSize: displayWidth(context) * 0.04,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "₹" + orderTotal,
                  style: TextStyle(
                    fontFamily: 'RobotoBold',
                    color: Color(0xFF27DEBF),
                    fontSize: displayWidth(context) * 0.05,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Positioned(
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.close),
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("NEED SUPPORT FOR"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          child: Text("CALL ME"),
                                          onPressed: () {
                                            _makePhoneCall('tel:8647843');
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                      //alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          //right: displayWidth(context) * 0.07,
                          bottom: displayWidth(context) * 0.05,
                          top: displayHeight(context) * 0.01),
                      //height: displayHeight(context) * 0.07,
                      //width: displayWidth(context) * 0.35,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 7, bottom: 7),
                        child: Text(
                          "Raise an issue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: displayWidth(context) * 0.03,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.deepOrange[700],
                      )),
                ),
                Container(
                    //alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        //right: displayWidth(context) * 0.07,
                        bottom: displayWidth(context) * 0.05,
                        top: displayHeight(context) * 0.01),
                    //height: displayHeight(context) * 0.07,
                    //width: displayWidth(context) * 0.35,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 7, bottom: 7),
                      child: Text(
                        "Awaiting",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: displayWidth(context) * 0.03,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.orange[600],
                    )),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Container(
                width: 100,
                height: 25,
                child: SvgPicture.asset(
                  point,
                  //color: Colors.green,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    pickUpAddress,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: displayWidth(context) * 0.03,
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: Text(
                    dropAddress,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: displayWidth(context) * 0.03,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isdata
            ? _sendactiveorders.isEmpty &&
                    _sendactiveshoporders.isEmpty &&
                    _restaurantactiveorders.isEmpty
                ? Text("No active order available")
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: <Widget>[
                            ListView.builder(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    print("Order-id:#" +
                                        _sendactiveorders[index].id);
                                  },
                                  child: new Container(
                                    margin: const EdgeInsets.all(15),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFF0F0F0),
                                            blurRadius: 5.0,
                                            spreadRadius: 5.0,
                                          )
                                        ]),
                                    child: Container(
                                      margin: EdgeInsets.all(8.0),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order-id:#" +
                                                _sendactiveorders[index].id,
                                            style: TextStyle(
                                              fontFamily: "RobotoBold",
                                              fontSize:
                                                  displayWidth(context) * 0.04,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "₹" +
                                                    _sendactiveorders[index]
                                                        .ordertotal,
                                                style: TextStyle(
                                                  fontFamily: 'RobotoBold',
                                                  color: Color(0xFF27DEBF),
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.05,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: Stack(
                                                            overflow: Overflow
                                                                .visible,
                                                            children: <Widget>[
                                                              Positioned(
                                                                right: -40.0,
                                                                top: -40.0,
                                                                child:
                                                                    InkResponse(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .close),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ),
                                                              Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          "NEED SUPPORT FOR"),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextFormField(),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          RaisedButton(
                                                                        child: Text(
                                                                            "CALL ME"),
                                                                        onPressed:
                                                                            () {
                                                                          if (_formKey
                                                                              .currentState
                                                                              .validate()) {
                                                                            _makePhoneCall('tel:8633746772');
                                                                            ;
                                                                          }
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                    //alignment: Alignment.center,
                                                    margin: EdgeInsets.only(
                                                        //right: displayWidth(context) * 0.07,
                                                        bottom: displayWidth(
                                                                context) *
                                                            0.05,
                                                        top: displayHeight(
                                                                context) *
                                                            0.01),
                                                    //height: displayHeight(context) * 0.07,
                                                    //width: displayWidth(context) * 0.35,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 7,
                                                          bottom: 7),
                                                      child: Text(
                                                        "Raise an issue",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          fontSize:
                                                              displayWidth(
                                                                      context) *
                                                                  0.03,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      color: Colors
                                                          .deepOrange[700],
                                                    )),
                                              ),
                                              Container(
                                                  //alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      //right: displayWidth(context) * 0.07,
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.05,
                                                      top: displayHeight(
                                                              context) *
                                                          0.01),
                                                  //height: displayHeight(context) * 0.07,
                                                  //width: displayWidth(context) * 0.35,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 7,
                                                        bottom: 7),
                                                    child: Text(
                                                      "Awaiting",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.white,
                                                        fontSize: displayWidth(
                                                                context) *
                                                            0.03,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    color: Colors.orange[600],
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Center(
                                            child: Container(
                                              width: 100,
                                              height: 25,
                                              child: SvgPicture.asset(
                                                point,
                                                //color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  _sendactiveorders[index]
                                                      .pickupaddress,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.03,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15.0),
                                              Expanded(
                                                child: Text(
                                                  _sendactiveorders[index]
                                                      .deliveryaddress,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.03,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: _sendactiveorders.length,
                              shrinkWrap:
                                  true, // todo comment this out and check the result
                              physics:
                                  ClampingScrollPhysics(), // todo comment this out and check the result
                            ),
                            ListView.builder(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    print(_sendactiveshoporders[index]
                                        .pickupaddress);
                                  },
                                  child: new Container(
                                    margin: const EdgeInsets.all(15),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFF0F0F0),
                                            blurRadius: 5.0,
                                            spreadRadius: 5.0,
                                          )
                                        ]),
                                    child: Container(
                                      margin: EdgeInsets.all(8.0),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order-id:#" +
                                                _sendactiveshoporders[index]
                                                    .shoporderid,
                                            style: TextStyle(
                                              fontFamily: "RobotoBold",
                                              fontSize:
                                                  displayWidth(context) * 0.04,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "₹" +
                                                    _sendactiveshoporders[index]
                                                        .orderamount,
                                                style: TextStyle(
                                                  fontFamily: 'RobotoBold',
                                                  color: Color(0xFF27DEBF),
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.05,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: Stack(
                                                            overflow: Overflow
                                                                .visible,
                                                            children: <Widget>[
                                                              Positioned(
                                                                right: -40.0,
                                                                top: -40.0,
                                                                child:
                                                                    InkResponse(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .close),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ),
                                                              Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          "NEED SUPPORT FOR"),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextFormField(),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          RaisedButton(
                                                                        child: Text(
                                                                            "CALL ME"),
                                                                        onPressed:
                                                                            () {
                                                                          if (_formKey
                                                                              .currentState
                                                                              .validate()) {
                                                                            _makePhoneCall('tel:8630653477');
                                                                            ;
                                                                          }
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                    //alignment: Alignment.center,
                                                    margin: EdgeInsets.only(
                                                        //right: displayWidth(context) * 0.07,
                                                        bottom: displayWidth(
                                                                context) *
                                                            0.05,
                                                        top: displayHeight(
                                                                context) *
                                                            0.01),
                                                    //height: displayHeight(context) * 0.07,
                                                    //width: displayWidth(context) * 0.35,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 7,
                                                          bottom: 7),
                                                      child: Text(
                                                        "Raise an issue",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          fontSize:
                                                              displayWidth(
                                                                      context) *
                                                                  0.03,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      color: Colors
                                                          .deepOrange[700],
                                                    )),
                                              ),
                                              Container(
                                                  //alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      //right: displayWidth(context) * 0.07,
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.05,
                                                      top: displayHeight(
                                                              context) *
                                                          0.01),
                                                  //height: displayHeight(context) * 0.07,
                                                  //width: displayWidth(context) * 0.35,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 7,
                                                        bottom: 7),
                                                    child: Text(
                                                      "Awaiting",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.white,
                                                        fontSize: displayWidth(
                                                                context) *
                                                            0.03,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    color: Colors.orange[600],
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Center(
                                            child: Container(
                                              width: 100,
                                              height: 25,
                                              child: SvgPicture.asset(
                                                point,
                                                //color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  _sendactiveshoporders[index]
                                                      .pickupaddress,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.03,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15.0),
                                              Expanded(
                                                child: Text(
                                                  _sendactiveshoporders[index]
                                                      .deliveryaddress,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.03,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                /*orderWidget(
                        _sendactiveshoporders[index].shoporderid,
                        _sendactiveshoporders[index].orderamount,
                        _sendactiveshoporders[index].pickupaddress,
                        _sendactiveshoporders[index].deliveryaddress);*/
                              },
                              itemCount: _sendactiveshoporders.length,
                              shrinkWrap:
                                  true, // todo comment this out and check the result
                              physics:
                                  ClampingScrollPhysics(), // todo comment this out and check the result
                            ),
                            ListView.builder(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    print("Order-id:#" +
                                        _restaurantactiveorders[index].id);
                                  },
                                  child: new Container(
                                    margin: const EdgeInsets.all(15),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFF0F0F0),
                                            blurRadius: 5.0,
                                            spreadRadius: 5.0,
                                          )
                                        ]),
                                    child: Container(
                                      margin: EdgeInsets.all(8.0),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order-id:#" +
                                                _restaurantactiveorders[index]
                                                    .id,
                                            style: TextStyle(
                                              fontFamily: "RobotoBold",
                                              fontSize:
                                                  displayWidth(context) * 0.04,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "₹" +
                                                    _restaurantactiveorders[
                                                            index]
                                                        .orderamount,
                                                style: TextStyle(
                                                  fontFamily: 'RobotoBold',
                                                  color: Color(0xFF27DEBF),
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.05,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: Stack(
                                                            overflow: Overflow
                                                                .visible,
                                                            children: <Widget>[
                                                              Positioned(
                                                                right: -40.0,
                                                                top: -40.0,
                                                                child:
                                                                    InkResponse(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .close),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ),
                                                              Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextFormField(),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          "NEED SUPPORT FOR"),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          RaisedButton(
                                                                        child: Text(
                                                                            "CALL ME"),
                                                                        onPressed:
                                                                            () {
                                                                          if (_formKey
                                                                              .currentState
                                                                              .validate())
                                                                            _makePhoneCall('tel:9080652772');
                                                                          ;
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                    //alignment: Alignment.center,
                                                    margin: EdgeInsets.only(
                                                        //right: displayWidth(context) * 0.07,
                                                        bottom: displayWidth(
                                                                context) *
                                                            0.05,
                                                        top: displayHeight(
                                                                context) *
                                                            0.01),
                                                    //height: displayHeight(context) * 0.07,
                                                    //width: displayWidth(context) * 0.35,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 7,
                                                          bottom: 7),
                                                      child: Text(
                                                        "Raise an issue",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          fontSize:
                                                              displayWidth(
                                                                      context) *
                                                                  0.03,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      color: Colors
                                                          .deepOrange[700],
                                                    )),
                                              ),
                                              Container(
                                                  //alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      //right: displayWidth(context) * 0.07,
                                                      bottom: displayWidth(
                                                              context) *
                                                          0.05,
                                                      top: displayHeight(
                                                              context) *
                                                          0.01),
                                                  //height: displayHeight(context) * 0.07,
                                                  //width: displayWidth(context) * 0.35,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 7,
                                                        bottom: 7),
                                                    child: Text(
                                                      "Awaiting",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.white,
                                                        fontSize: displayWidth(
                                                                context) *
                                                            0.03,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    color: Colors.orange[600],
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Center(
                                            child: Container(
                                              width: 100,
                                              height: 25,
                                              child: SvgPicture.asset(
                                                point,
                                                //color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  _restaurantactiveorders[index]
                                                      .pickupaddress,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.03,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15.0),
                                              Expanded(
                                                child: Text(
                                                  _sendactiveorders[index]
                                                      .deliveryaddress,
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.03,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: _restaurantactiveorders.length,
                              shrinkWrap:
                                  true, // todo comment this out and check the result
                              physics:
                                  ClampingScrollPhysics(), // todo comment this out and check the result
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: 1,
                  )
            : Center(child: CircularProgressIndicator()));
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

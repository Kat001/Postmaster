import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  Color _textColor = Colors.green;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pickupAddressController =
      TextEditingController();
  final TextEditingController _pickupPhoneController = TextEditingController();
  final TextEditingController _pickupArrivalController =
      TextEditingController();
  final TextEditingController _pickupCommentController =
      TextEditingController();

  final TextEditingController _dropAddressController = TextEditingController();
  final TextEditingController _dropPhoneController = TextEditingController();
  final TextEditingController _dropArrivalController = TextEditingController();
  final TextEditingController _dropCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Pickup Point
            ExpansionTile(
                onExpansionChanged: (Expanded) {
                  setState(() {
                    if (Expanded) {
                      _textColor = Color(0xFF2BCDB4);
                    } else {
                      _textColor = Color(0xFF465A64);
                    }
                  });
                },
                leading: Container(
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    pickuppoint,
                    color: _textColor,
                  ),
                ),
                maintainState: true,
                key: PageStorageKey("test"),
                title: Text(
                  "Pickup Point",
                  style: TextStyle(color: _textColor),
                  textAlign: TextAlign.start,
                ),
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.01,
                        left: displayWidth(context) * 0.15,
                        right: displayWidth(context) * 0.05),
                    child: TextFormField(
                      controller: _pickupAddressController,
                      decoration: InputDecoration(
                        hintText: "Address",
                      ),
                      key: PageStorageKey("test2"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.01,
                        left: displayWidth(context) * 0.15,
                        right: displayWidth(context) * 0.05),
                    child: TextFormField(
                      controller: _pickupCommentController,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                      ),
                      key: PageStorageKey("test3"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.01,
                        left: displayWidth(context) * 0.15,
                        right: displayWidth(context) * 0.05),
                    child: TextFormField(
                      controller: _pickupArrivalController,
                      decoration: InputDecoration(
                        hintText: "Arrival",
                      ),
                      key: PageStorageKey("test4"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: displayWidth(context) * 0.15,
                        right: displayWidth(context) * 0.05,
                        top: displayHeight(context) * 0.01),
                    child: TextFormField(
                      controller: _pickupCommentController,
                      decoration: InputDecoration(
                        hintText: "Comment",
                      ),
                      key: PageStorageKey("test5"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ]),
            //Droppoint
            ExpansionTile(
                onExpansionChanged: (Expanded) {
                  setState(() {
                    if (Expanded) {
                      _textColor = Color(0xFF2BCDB4);
                    } else {
                      _textColor = Color(0xFF465A64);
                    }
                  });
                },
                leading: Container(
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    droppoint,
                    color: _textColor,
                  ),
                ),
                maintainState: true,
                key: PageStorageKey("test6"),
                title: Text(
                  "Drop Point",
                  style: TextStyle(color: _textColor),
                  textAlign: TextAlign.start,
                ),
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.01,
                        left: displayWidth(context) * 0.15,
                        right: displayWidth(context) * 0.05),
                    child: TextFormField(
                      controller: _dropAddressController,
                      decoration: InputDecoration(
                        hintText: "Address",
                      ),
                      key: PageStorageKey("test7"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.01,
                        left: displayWidth(context) * 0.15,
                        right: displayWidth(context) * 0.05),
                    child: TextFormField(
                      controller: _dropPhoneController,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                      ),
                      key: PageStorageKey("test8"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: displayHeight(context) * 0.01,
                        left: displayWidth(context) * 0.15,
                        right: displayWidth(context) * 0.05),
                    child: TextFormField(
                      controller: _dropArrivalController,
                      decoration: InputDecoration(
                        hintText: "Arrival",
                      ),
                      key: PageStorageKey("test9"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: displayWidth(context) * 0.15,
                        right: displayWidth(context) * 0.05,
                        top: displayHeight(context) * 0.01),
                    child: TextFormField(
                      controller: _dropCommentController,
                      decoration: InputDecoration(
                        hintText: "Comment",
                      ),
                      key: PageStorageKey("test0"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    print("on submiy");
                    sendPackage();
                    // If the form is valid, display a Snackbar.
                    //Scaffold.of(context).showSnackBar(
                    //  SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<http.Response> sendPackage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map data = {
      "weight": "12.00",
      "pickup_point": [
        {
          "address": _pickupAddressController.text,
          "phn_number": _pickupPhoneController.text,
          "arrive_time": _pickupArrivalController.text,
          "comment": _pickupCommentController.text,
        }
      ],
      "delivery_point": [
        {
          "address": _dropAddressController.text,
          "phn_number": _dropPhoneController.text,
          "arrive_time": _dropArrivalController.text,
          "comment": _dropCommentController.text,
        },
        {
          "address": "d2",
          "phn_number": "789654",
          "arrive_time": "d21:21",
          "comment": "d2222222"
        }
      ],
      "item_type": "test",
      "item_description": "testing is important",
      "parcel_value": "15.00",
      "promo_code": "TTTT",
      "contact_number": "2020202",
      "is_notified": 1,
      "is_accept": 0
    };
    var body = json.encode(data);

    http.Response res = await http.post(
        'https://www.mitrahtechnology.in/apis/mitrah-api/send_package.php',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token,
        },
        body: body);
    print(res.body);
    var responseData = json.decode(res.body);
    if (responseData["success"] == 1) {
    } else {
      //
    }
    return res;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:postmaster/Components/animate.dart';

class NewOrderStore extends StatefulWidget {
  NewOrderStore({
    Key key,
    this.weightData,
    this.itemData,
    this.rate,
  }) : super(key: key);

  final Future<List<dynamic>> weightData;
  final Future<List<dynamic>> itemData;
  final Future<String> rate;

  @override
  _NewOrderStoreState createState() => _NewOrderStoreState();
}

class _NewOrderStoreState extends State<NewOrderStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Buy from your favorite store",
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
        ),
      ),
      body: MyCustomForm(
          weightData: widget.weightData,
          itemData: widget.itemData,
          rate: widget.rate),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  MyCustomForm({
    Key key,
    this.weightData,
    this.itemData,
    this.rate,
  }) : super(key: key);

  final Future<List<dynamic>> weightData;
  final Future<List<dynamic>> itemData;
  final Future<String> rate;
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
  TimeOfDay _time = TimeOfDay.now();
  DateTime _dateTime;

  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  bool isApply = true;
  double _totalPayment = 0;

  int _weightPayment = 0;
  double _parcelValuePayment = 0;
  int _promoCodePayment = 0;
  double ratePercent;

  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _pickupAddressController =
      TextEditingController();
  final TextEditingController _costOfItemController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();

  final TextEditingController _dropAddressController = TextEditingController();
  final TextEditingController _dropPhoneNumberController =
      TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _parcelValueController = TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _parcelValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _parcelValueController.addListener(_printLatestValue);

    widget.rate.then((data) {
      String rate = data;

      setState(() {
        String price = rate.substring(0, rate.length - 1);
        ratePercent = double.parse(price);
      });
    }, onError: (e) {
      print(e);
    });
  }

  _printLatestValue() {
    //print(widget.rate);
    setState(() {
      if (_parcelValueController.text.isEmpty) {
        _parcelValuePayment = 0;
        _totalPayment =
            _weightPayment + _parcelValuePayment - _promoCodePayment;
      } else {
        double data = double.parse(_parcelValueController.text);
        _parcelValuePayment = ((data * ratePercent) / 100) +
            (((data * ratePercent) / 100) * 18) / 100;

        _totalPayment =
            _weightPayment + _parcelValuePayment - _promoCodePayment;
      }
    });
  }

  void _changeWeightPrice(String weight, String price) {
    _weightController.text = weight + price;
    print(price);

    setState(() {
      _weightPayment = int.parse(price);
      _totalPayment = _weightPayment + _parcelValuePayment - _promoCodePayment;
    });
  }

  Widget projectWidget() {
    return FutureBuilder<List<dynamic>>(
        future: widget.weightData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 80.0,
              //width: 500.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            String weight = snapshot.data[index]["weight"];
                            String price = snapshot.data[index]["price"];
                            _changeWeightPrice(weight, price);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: displayWidth(context) * 0.02,
                                top: displayHeight(context) * 0.01),
                            height: displayHeight(context) * 0.05,
                            width: displayWidth(context) * 0.3,
                            child: Text(
                              snapshot.data[index]["weight"],
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
                        )
                      ],
                    );
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget itemWidget() {
    return FutureBuilder<List<dynamic>>(
        future: widget.itemData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 80.0,
              //width: 500.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _itemController.text = snapshot.data[index]["item"];
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: displayWidth(context) * 0.02,
                                top: displayHeight(context) * 0.01),
                            height: displayHeight(context) * 0.05,
                            width: displayWidth(context) * 0.3,
                            child: Text(
                              snapshot.data[index]["item"],
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
                        )
                      ],
                    );
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 8.0,
                    ),
                    child: TextFormField(
                      controller: _weightController,
                      readOnly: true,
                      /*controller: emailController,*/
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please select the weight";
                        }
                      },
                      //initialValue: "data(1)",
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 0),
                        labelText: 'Select weight',
                      ),
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 18,
                      ),
                    ),
                  ),

                  projectWidget(),

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
                      key: PageStorageKey("tests"),
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
                            controller: _shopNameController,
                            decoration: InputDecoration(
                              hintText: "Shop name",
                            ),
                            key: PageStorageKey("tests2"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the shop name';
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
                            controller: _pickupAddressController,
                            decoration: InputDecoration(
                              hintText: "Address",
                            ),
                            key: PageStorageKey("tests3"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the address';
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
                            controller: _costOfItemController,
                            decoration: InputDecoration(
                              hintText: "Cost of item",
                            ),
                            key: PageStorageKey("tests4"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the cost of item';
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
                            controller: _itemNameController,
                            decoration: InputDecoration(
                              hintText: "Item name",
                            ),
                            key: PageStorageKey("tests5"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter item name';
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
                      key: PageStorageKey("tests6"),
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
                            key: PageStorageKey("tests7"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter drop address';
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
                            controller: _dropPhoneNumberController,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                            ),
                            key: PageStorageKey("tests8"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter phone number';
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
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: _dateTime == null
                                          ? DateTime.now()
                                          : _dateTime,
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2022))
                                  .then((date) {
                                setState(() {
                                  //_dateTime = date;
                                  if (date != null) {
                                    _deliveryDateController.text =
                                        date.toString().substring(0, 10);
                                  }
                                });
                              });
                            },
                            controller: _deliveryDateController,
                            decoration: InputDecoration(
                              hintText: "Delivery date",
                            ),
                            key: PageStorageKey("tests9"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please select delivery date';
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
                            readOnly: true,
                            onTap: () async {
                              TimeOfDay picked = await showTimePicker(
                                  context: context, initialTime: _time);
                              if (picked != null) {
                                setState(() {
                                  _deliveryTimeController.text =
                                      picked.toString().substring(10, 15);
                                });
                              }
                            },
                            controller: _deliveryTimeController,
                            decoration: InputDecoration(
                              hintText: "Delivery time",
                            ),
                            key: PageStorageKey("tests0"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please select delivery time';
                              }
                              return null;
                            },
                          ),
                        ),
                      ]),
                  //Store Detailes
                  /*ExpansionTile(
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
                      key: PageStorageKey("tests11"),
                      title: Text(
                        "Store details",
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
                            decoration: InputDecoration(
                              hintText: "Address",
                            ),
                            key: PageStorageKey("tests12"),
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
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                            ),
                            key: PageStorageKey("tests13"),
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
                            decoration: InputDecoration(
                              hintText: "Arrival",
                            ),
                            key: PageStorageKey("tests14"),
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
                            decoration: InputDecoration(
                              hintText: "Delivery time",
                            ),
                            key: PageStorageKey("tests15"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ]),*/
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 2.0),
                    child: TextFormField(
                      controller: _itemController,
                      readOnly: true,
                      /*controller: emailController,*/
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please select the item";
                        }
                      },
                      //initialValue: "data(1)",
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 0),
                        labelText: 'What are you sending?',
                      ),
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  itemWidget(),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 2.0),
                    child: TextFormField(
                      controller: _parcelValueController,

                      /*controller: emailController,*/
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter parcel value";
                        }
                      },
                      //initialValue: "data(1)",
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 0),
                        labelText: 'Parcel value',
                      ),
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 2.0, top: 8.0),
                    child: TextFormField(
                      controller: _promoCodeController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: "Promocode",
                          suffixIcon: InkWell(
                            onTap: () async {
                              if (_promoCodeController.text.isEmpty) {
                                return;
                              }
                              setState(() {
                                isApply = false;
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
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                  "Authorization": token,
                                },
                                body: body,
                              );
                              print(res.body);
                              var responseData = json.decode(res.body);
                              if (responseData['status'] == 200) {
                                setState(() {
                                  isApply = true;
                                  var amount = int.parse(
                                      responseData["message"][0]["amount"]);
                                  _promoCodePayment = amount;
                                  _totalPayment = _weightPayment +
                                      _parcelValuePayment -
                                      _promoCodePayment;
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(
                                      "Success",
                                      "Hey you saved ₹$_promoCodePayment ",
                                      "Okay",
                                      3),
                                );
                              }
                              if (responseData['status'] == 404) {
                                setState(() {
                                  isApply = true;
                                  _promoCodeController.text = "";

                                  //print(responseData["message"][0]["amount"]);
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) => CustomDialogError(
                                        "Error",
                                        responseData['message'],
                                        "Cancel"));
                              }
                            },
                            child: Container(
                              width: 80.0,
                              height: 20.0,
                              margin: EdgeInsets.only(
                                  bottom: 5.0, top: 5.0, right: 5.0),
                              child: isApply
                                  ? Center(child: Text("Apply"))
                                  : Center(
                                      child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: CircularProgressIndicator())),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                color: Colors.greenAccent,
                              ),
                            ),
                          )),
                    ),
                  ),
                  /*Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: displayHeight(context) * 0.03,
                            left: displayWidth(context) * 0.03,
                          ),
                          child: Text("Notify recipient by SMS",
                              style: TextStyle(
                                fontFamily: 'RobotoBold',
                                color: Colors.grey,
                                fontSize: displayWidth(context) * 0.05,
                              )),
                        ),
                        Container(
                          //padding: EdgeInsets.only(right: 0.01),
                          margin: EdgeInsets.only(
                              //left: displayWidth(context) * 0.2,
                              top: displayHeight(context) * 0.03),
                          child: Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset(
                              money,
                              color: Color(0xFF465A64),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Cash",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset(
                              wallet,
                              color: Color(0xFF465A64),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Balance",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset(
                              mobilepayment,
                              color: Color(0xFF465A64),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Online",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 80.0,
          color: Colors.white30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    right: displayWidth(context) * 0.07,
                    bottom: displayWidth(context) * 0.05,
                    top: displayHeight(context) * 0.01),
                height: displayHeight(context) * 0.07,
                width: displayWidth(context) * 0.35,
                child: Text(
                  "amount: " + "₹" + _totalPayment.round().toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'RobotoBold',
                    color: Color(0xFF27DEBF),
                    fontSize: displayWidth(context) * 0.05,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    print("on submiy");
                    sendPackage();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      right: displayWidth(context) * 0.07,
                      bottom: displayWidth(context) * 0.05,
                      top: displayHeight(context) * 0.01),
                  height: displayHeight(context) * 0.07,
                  width: displayWidth(context) * 0.35,
                  child: Text(
                    "Create order",
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
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<http.Response> sendPackage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map data = {
      "weight": _weightController.text,
      "pickup_point": [
        {
          "shop_name": _shopNameController.text,
          "item_name": _itemNameController.text,
          "address": _pickupAddressController.text,
          "cost_of_item": _costOfItemController.text,
        }
      ],
      "delivery_point": [
        {
          "address": _dropAddressController.text,
          "phn_number": _dropPhoneNumberController.text,
          "delivery_date": _deliveryDateController.text,
          "delivery_time": _deliveryTimeController.text,
        }
      ],
      "promo_code": _promoCodeController.text,
      "comment": "jjjjjjjjjjjjjaaaaaaaaa",
      "parcel_value": _parcelValueController.text,
      "tax_amount": 0.80,
      "order_amount": _totalPayment.round().toString()
    };
    var body = json.encode(data);

    http.Response res = await http.post(
        'https://www.mitrahtechnology.in/apis/mitrah-api/buy_from_store.php',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token,
        },
        body: body);
    print(res.body);
    var responseData = json.decode(res.body);
    if (responseData["success"] == 1) {
      showDialog(
        context: context,
        builder: (context) =>
            CustomDialog("Success", "Order Created Successfully", "Okay", 2),
      );
    } else {
      //
    }
    return res;
  }
}

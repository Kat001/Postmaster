import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:http/http.dart' as http;

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:postmaster/Screens/Location.dart';

import 'package:contact_picker/contact_picker.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/l10n.dart'
    as location_picker;
import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewOrder extends StatefulWidget {
  NewOrder({
    Key key,
    this.weightData,
    this.itemData,
    this.rate,
  }) : super(key: key);

  final Future<List<dynamic>> weightData;
  final Future<List<dynamic>> itemData;
  final Future<String> rate;

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Send your package",
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
  static final kInitialPosition = LatLng(22.3110728, 73.1808008);
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm>
    with TickerProviderStateMixin {
  Color _textColor = Colors.green;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  var addressTECs = <TextEditingController>[];
  var phoneTECs = <TextEditingController>[];
  var arrivedateTECs = <TextEditingController>[];
  var arrivetimeTECs = <TextEditingController>[];
  var commentTECs = <TextEditingController>[];

  LocationResult _pickedLocation;
  FocusNode _phoneNumberFocusNode;

  //
  var cards = <Widget>[];
  var cardsnow = <Widget>[];
  //
  final ContactPicker _contactPicker = new ContactPicker();

  Contact _contact;
  // Note: This is a GlobalKey<FormState>,
  DateTime _dateTime;
  TimeOfDay _time = TimeOfDay.now();
  // not a GlobalKey<MyCustomFormState>.
  bool isApply = true;
  bool isSwitched = false;
  double _totalPayment = 0;
  double _weightPayment = 0;
  double _parcelValuePayment = 0;
  double _distanceFirstPayment = 0;
  double ratePercent;
  //--------------------------------------
  bool valuefirst = false;
  bool valuesecond = false;
  bool valuethird = false;
  double walletBalance = 0;
  //------------------------------------------
  Razorpay _razorpay;
  //----------------------------------------
  FocusNode pickup1FocusNode;

  double _promoCodePayment = 0;
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  final TextEditingController _pickupAddressController =
      TextEditingController();
  final TextEditingController _pickupPhoneController = TextEditingController();
  final TextEditingController _pickupDateController = TextEditingController();
  final TextEditingController _pickupTimeController = TextEditingController();
  final TextEditingController _pickupCommentController =
      TextEditingController();

  final TextEditingController _dropAddressController = TextEditingController();
  final TextEditingController _dropPhoneController = TextEditingController();
  final TextEditingController _dropDateController = TextEditingController();
  final TextEditingController _dropTimeController = TextEditingController();
  final TextEditingController _dropCommentController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _parcelValueController = TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();

  //TabController tabController;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _parcelValueController.dispose();
    //tabController.dispose();
    super.dispose();
    _razorpay.clear();
    pickup1FocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    pickup1FocusNode = FocusNode();

    _parcelValueController.addListener(_printLatestValue);
    // _pickupAddressController.addListener(_findPickUpDistance);

    widget.rate.then((data) {
      String rate = data;

      setState(() {
        String price = rate.substring(0, rate.length);
        ratePercent = double.parse(price);
      });
    }, onError: (e) {
      print(e);
    });
    fetchWalletBalance();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(int onlineMinusAmount) async {
    var options = {
      'key': 'rzp_test_eAO1C3UKqngmHc',
      'amount': onlineMinusAmount * 100,
      'name': 'Postmaster',
      'description': 'Send your Pacakages',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future<http.Response> fetchWalletBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res;

    res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/fetch_wallet_balance.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
    );
    print(res.body);
    var responseData = json.decode(res.body);

    if (responseData['status'] == 200) {
      var balance = responseData['wallet_balance'];
      double data = double.parse(balance);
      setState(() {
        walletBalance = data;
      });
    }

    return res;
  }

  _getLocation(TextEditingController _controller) async {
    Position position = await Geolocator.getCurrentPosition();
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    setState(() {
      _controller.text = first.addressLine;
    });
    var distance =
        Geolocator.distanceBetween(22.313863, 73.151014, 21.203510, 72.839230);
    print(distance.toDouble() / 1000);
  }

  String currentLocation() {
    return "hii";
  }

  Widget removeWidget() {
    if (cards.isEmpty) {
      return Container(
        height: 0,
        width: 0,
      );
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            cards.removeLast();
            cardsnow.removeLast();
            addressTECs.removeLast();
            phoneTECs.removeLast();
            arrivedateTECs.removeLast();
            arrivetimeTECs.removeLast();
            commentTECs.removeLast();
          });
        },
        child: Container(
          padding: const EdgeInsets.only(left: 140.0, right: 10.0),
          margin: EdgeInsets.only(
            bottom: 5.0,
            left: displayWidth(context) * 0.15,
            right: displayWidth(context) * 0.05,
          ),
          //top: displayHeight(context) * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(width: 3.0),
              Expanded(
                child: Text(
                  "",
                  style: TextStyle(
                      fontFamily: 'Robotobold',
                      fontSize: 17,
                      color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget expantionTile() {
    var addressController = TextEditingController();
    var phoneController = TextEditingController();
    var arrivedateController = TextEditingController();
    var arrivetimeController = TextEditingController();
    var commentController = TextEditingController();

    addressTECs.add(addressController);
    phoneTECs.add(phoneController);
    arrivedateTECs.add(arrivedateController);
    arrivetimeTECs.add(arrivetimeController);
    commentTECs.add(commentController);

    return ExpansionTile(
      initiallyExpanded: true,
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
        //textAlign: TextAlign.start,
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
            margin: EdgeInsets.only(
                top: displayHeight(context) * 0.01,
                left: displayWidth(context) * 0.15,
                right: displayWidth(context) * 0.05),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                TextFormField(
                  maxLines: null,
                  readOnly: true,
                  key: PageStorageKey('mytextfield'),

                  onTap: () async {
                    String address = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Locaton(address: addressController.text),
                      ),
                    );
                    setState(() {
                      addressController.text = address;
                    });

                    if (_pickupAddressController.text.isEmpty) {
                      addressController.text = "";
                      showDialog(
                          context: context,
                          builder: (context) => CustomDialogError(
                              "Error",
                              "Pickup Address is required fill it first",
                              "Cancel"));
                    } else {
                      print("---------------------------------------------");
                      var point1 = _pickupAddressController.text;
                      var point2 = _dropAddressController.text;
                      double price = 0;
                      for (int i = 0; i <= addressTECs.length; i++) {
                        if (point2.isEmpty) {
                          if (i == addressTECs.length) {
                          } else {
                            point2 = addressTECs[i].text;
                          }
                        } else {
                          var amount = await _givesDistance1(point1, point2);
                          print("---------------------------------------" +
                              amount);
                          price += double.parse(amount); //amount;
                          point1 = point2;
                          if (i == addressTECs.length) {
                          } else {
                            point2 = addressTECs[i].text;
                          }
                        }
                      }
                      setState(() {
                        _distanceFirstPayment = price;
                        _totalPayment = _weightPayment +
                            _distanceFirstPayment +
                            _parcelValuePayment -
                            _promoCodePayment +
                            ((_weightPayment * 18) / 100) +
                            ((_parcelValuePayment * 18) / 100);
                      });
                    }
                  },

                  controller: addressController,

                  /*controller: emailController,*/
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter address";
                    }
                  },
                  //initialValue: "data(1)",
                  style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 0, right: 28.0),
                    labelText: 'Address',
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    _getLocation(addressController);
                  },
                  icon: Icon(Icons.location_on),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
            margin: EdgeInsets.only(
                top: displayHeight(context) * 0.01,
                left: displayWidth(context) * 0.15,
                right: displayWidth(context) * 0.05),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  key: PageStorageKey('mytextfield'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  controller: phoneController,

                  /*controller: emailController,*/
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter the parcel value.";
                    }
                  },
                  //initialValue: "data(1)",
                  style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 0),
                    labelText: 'Phone number',
                    prefixText: "+91 ",
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      Contact contact = await _contactPicker.selectContact();
                      setState(() {
                        _contact = contact;
                        if (_contact.phoneNumber.number.contains("+")) {
                          phoneController.text = replaceWhitespacesUsingRegex(
                              _contact.phoneNumber.number.substring(3), '');
                        } else {
                          phoneController.text = replaceWhitespacesUsingRegex(
                              _contact.phoneNumber.number, '');
                        }
                      });
                    },
                    icon: Icon(Icons.contact_page)),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: displayHeight(context) * 0.01,
              left: displayWidth(context) * 0.15,
              right: displayWidth(context) * 0.05),
          child: TextFormField(
            controller: arrivedateController,
            readOnly: true,
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate:
                          _dateTime == null ? DateTime.now() : _dateTime,
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2022))
                  .then((date) {
                setState(() {
                  //_dateTime = date;
                  if (date != null) {
                    arrivedateController.text =
                        date.toString().substring(0, 10);
                  }
                });
              });
            },
            decoration: InputDecoration(
              labelText: 'Arrival date',
            ),
            key: PageStorageKey("test9"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter arrival date';
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
              TimeOfDay picked =
                  await showTimePicker(context: context, initialTime: _time);
              if (picked != null) {
                setState(() {
                  arrivetimeController.text =
                      picked.toString().substring(10, 15);
                });
              }
            },
            controller: arrivetimeController,
            decoration: InputDecoration(
              labelText: 'Arrival time',
            ),
            key: PageStorageKey("test11"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please select arrival time';
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
            //controller: _dropCommentController,
            decoration: InputDecoration(
              labelText: 'Comment',
            ),
            key: PageStorageKey("test10"),
            /*validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },*/
          ),
        ),
      ],
    );
  }

  Widget expantionTileNow() {
    return ExpansionTile(
      initiallyExpanded: true,
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
        //textAlign: TextAlign.start,
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
            margin: EdgeInsets.only(
                top: displayHeight(context) * 0.01,
                left: displayWidth(context) * 0.15,
                right: displayWidth(context) * 0.05),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                TextFormField(
                  maxLines: null,
                  readOnly: true,
                  key: PageStorageKey('mytextfield'),

                  onTap: () async {
                    String address = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Locaton(address: addressTECs.last.text),
                      ),
                    );
                    setState(() {
                      addressTECs.last.text = address;
                    });
                    setState(() {
                      if (addressTECs.last.text.isEmpty) {
                        addressTECs.last.text = "";
                        showDialog(
                            context: context,
                            builder: (context) => CustomDialogError(
                                "Error",
                                "Pickup Address is required fill it first",
                                "Cancel"));
                      }
                    });
                  },

                  controller: addressTECs.last,

                  /*controller: emailController,*/
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter address";
                    }
                  },
                  //initialValue: "data(1)",
                  style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 0, right: 28.0),
                    labelText: 'Address',
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    _getLocation(addressTECs.last);
                  },
                  icon: Icon(Icons.location_on),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
            margin: EdgeInsets.only(
                top: displayHeight(context) * 0.01,
                left: displayWidth(context) * 0.15,
                right: displayWidth(context) * 0.05),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  key: PageStorageKey('mytextfield'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  controller: phoneTECs.last,

                  /*controller: emailController,*/
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter the parcel value.";
                    }
                  },
                  //initialValue: "data(1)",
                  style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 0),
                    labelText: 'Phone number',
                    prefixText: "+91 ",
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      Contact contact = await _contactPicker.selectContact();
                      setState(() {
                        _contact = contact;
                        if (_contact.phoneNumber.number.contains("+")) {
                          phoneTECs.last.text = replaceWhitespacesUsingRegex(
                              _contact.phoneNumber.number.substring(3), '');
                        } else {
                          phoneTECs.last.text = replaceWhitespacesUsingRegex(
                              _contact.phoneNumber.number, '');
                        }
                      });
                    },
                    icon: Icon(Icons.contact_page)),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: displayWidth(context) * 0.15,
              right: displayWidth(context) * 0.05,
              top: displayHeight(context) * 0.01),
          child: TextFormField(
            controller: commentTECs.last,
            decoration: InputDecoration(
              labelText: 'Comment',
            ),
            key: PageStorageKey("test10"),
            /*validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },*/
          ),
        ),
      ],
    );
  }

  _printLatestValue() {
    //print(widget.rate);
    setState(() {
      if (_parcelValueController.text.isEmpty) {
        _parcelValuePayment = 0;
        /* _totalPayment = _weightPayment +
            _parcelValuePayment -
            _promoCodePayment +
            ((_parcelValuePayment * 100) / 100);*/
      } else {
        double data = double.parse(_parcelValueController.text);
        _parcelValuePayment = ((data * ratePercent) / 100);

        print(data);
        print(_parcelValuePayment);
        print(ratePercent);

        _totalPayment = _weightPayment +
            _distanceFirstPayment +
            _parcelValuePayment -
            _promoCodePayment +
            ((_parcelValuePayment * 18) / 100) +
            ((_weightPayment * 18) / 100);
      }
    });
  }

  String replaceWhitespacesUsingRegex(String s, String replace) {
    if (s == null) {
      return null;
    }

    // This pattern means "at least one space, or more"
    // \\s : space
    // +   : one or more
    final pattern = RegExp('\\s+');
    return s.replaceAll(pattern, replace);
  }

  void _changeWeightPrice(String weight, String price) {
    setState(() {
      _weightController.text = weight;
    });
    print(price);

    setState(() {
      _weightPayment = double.parse(price);
      _totalPayment = _weightPayment +
          _distanceFirstPayment +
          _parcelValuePayment -
          _promoCodePayment +
          ((_weightPayment * 18) / 100) +
          ((_parcelValuePayment * 18) / 100);
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
                    return index == 0
                        ? Container()
                        : Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  _itemController.text =
                                      snapshot.data[index]["item"];
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
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          location_picker.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('en', ''),
          Locale('ar', ''),
          Locale('pt', ''),
          Locale('tr', ''),
          Locale('es', ''),
          Locale('it', ''),
          Locale('ru', ''),
        ],
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
                child: Center(
                  child: TabBar(
                      //controller: tabController,
                      onTap: (value) {
                        print(value);
                      },
                      isScrollable: false,
                      indicatorColor: Color(0xFF2AD0B5),
                      indicator: BoxDecoration(
                        color: Color(0xFF2AD0B5),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      unselectedLabelColor: Color(0xFF465A64),
                      tabs: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.run_circle),
                              Expanded(
                                child: Tab(
                                  child: Text(
                                    "Delivery Now ",
                                    style: TextStyle(
                                        //color:
                                        //  Colors.white, //Color(0xFF465A64),
                                        fontFamily: "RobotoBold",
                                        fontSize: displayWidth(context) * 0.04),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Column(
                            children: [
                              Icon(Icons.schedule),
                              Expanded(
                                child: Tab(
                                  child: Text(
                                    "Schedule",
                                    style: TextStyle(
                                        //color:
                                        //  Colors.white, //Color(0xFF465A64),
                                        fontFamily: "RobotoBold",
                                        fontSize: displayWidth(context) * 0.04),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                preferredSize: Size.fromHeight(30.0)),
            body: Form(
              key: _formKey,
              child: TabBarView(
                  //controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //TextField(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 8.0,
                                    ),
                                    child: TextFormField(
                                      controller: _weightController,
                                      readOnly: true,

                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "Please select weight.";
                                        }
                                      },
                                      //initialValue: "data(1)",
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0),
                                        labelText: 'Select weight',
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),

                                  projectWidget(),
                                  //itemWidget(),

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
                                        Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: displayHeight(context) *
                                                    0.01,
                                                left: displayWidth(context) *
                                                    0.15,
                                                right: displayWidth(context) *
                                                    0.05),
                                            child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                TextFormField(
                                                  maxLines: null,
                                                  readOnly: true,
                                                  focusNode: pickup1FocusNode,
                                                  key: PageStorageKey(
                                                      'mytextfield'),

                                                  onTap: () async {
                                                    String address =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Locaton(
                                                                address:
                                                                    _pickupAddressController
                                                                        .text),
                                                      ),
                                                    );
                                                    setState(() {
                                                      _pickupAddressController
                                                          .text = address;
                                                    });
                                                    setState(() {
                                                      if (_dropAddressController
                                                          .text.isEmpty) {
                                                      } else {
                                                        _givesDistance(
                                                            _pickupAddressController
                                                                .text,
                                                            _dropAddressController
                                                                .text);
                                                      }
                                                    });
                                                  },

                                                  controller:
                                                      _pickupAddressController,

                                                  /*controller: emailController,*/
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return "Please enter address";
                                                    }
                                                  },
                                                  //initialValue: "data(1)",
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: 18,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 28,
                                                            bottom: 0),
                                                    labelText: 'Address',
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    pickup1FocusNode
                                                        .requestFocus();
                                                    _getLocation(
                                                        _pickupAddressController);
                                                  },
                                                  icon: Icon(Icons.location_on),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: displayHeight(context) *
                                                    0.01,
                                                left: displayWidth(context) *
                                                    0.15,
                                                right: displayWidth(context) *
                                                    0.05),
                                            child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                TextFormField(
                                                  key: PageStorageKey(
                                                      'mytextfield'),

                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller:
                                                      _pickupPhoneController,

                                                  /*controller: emailController,*/
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return "Please enter the parcel value.";
                                                    }
                                                  },
                                                  //initialValue: "data(1)",
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: 18,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0),
                                                    labelText: 'Phone number',
                                                    prefixText: "+91 ",
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      Contact contact =
                                                          await _contactPicker
                                                              .selectContact();
                                                      setState(() {
                                                        _contact = contact;
                                                        if (_contact
                                                            .phoneNumber.number
                                                            .contains("+")) {
                                                          _pickupPhoneController
                                                                  .text =
                                                              replaceWhitespacesUsingRegex(
                                                                  _contact
                                                                      .phoneNumber
                                                                      .number
                                                                      .substring(
                                                                          3),
                                                                  '');
                                                        } else {
                                                          _pickupPhoneController
                                                                  .text =
                                                              replaceWhitespacesUsingRegex(
                                                                  _contact
                                                                      .phoneNumber
                                                                      .number,
                                                                  '');
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.contact_page)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                            width: 0,
                                            height: 0,
                                            key: PageStorageKey("test4")),
                                        /*Container(
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
                                                _pickupDateController.text =
                                                    date
                                                        .toString()
                                                        .substring(0, 10);
                                              }
                                            });
                                          });
                                        },
                                        controller: _pickupDateController,
                                        decoration: InputDecoration(
                                          labelText: "Pickup date",
                                        ),
                                        key: PageStorageKey("test4"),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter pickup date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),*/
                                        Container(
                                            width: 0,
                                            height: 0,
                                            key: PageStorageKey("test6")),
                                        /*Container(
                                      margin: EdgeInsets.only(
                                          left: displayWidth(context) * 0.15,
                                          right: displayWidth(context) * 0.05,
                                          top: displayHeight(context) * 0.01),
                                      child: TextFormField(
                                        readOnly: true,
                                        onTap: () async {
                                          TimeOfDay picked =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: _time);
                                          if (picked != null) {
                                            setState(() {
                                              _pickupTimeController.text =
                                                  picked
                                                      .toString()
                                                      .substring(10, 15);
                                            });
                                          }
                                        },
                                        controller: _pickupTimeController,
                                        decoration: InputDecoration(
                                          labelText: 'Pickup time',
                                        ),
                                        key: PageStorageKey("test6"),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please select pickup time';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),*/
                                        Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  displayWidth(context) * 0.15,
                                              right:
                                                  displayWidth(context) * 0.05,
                                              top: displayHeight(context) *
                                                  0.01),
                                          child: TextFormField(
                                            controller:
                                                _pickupCommentController,
                                            decoration: InputDecoration(
                                              labelText: 'Comment',
                                            ),
                                            key: PageStorageKey("test5"),
                                            /*validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },*/
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
                                        Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: displayHeight(context) *
                                                    0.01,
                                                left: displayWidth(context) *
                                                    0.15,
                                                right: displayWidth(context) *
                                                    0.05),
                                            child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                TextFormField(
                                                  maxLines: null,
                                                  readOnly: true,
                                                  key: PageStorageKey(
                                                      'mytextfield'),

                                                  onTap: () async {
                                                    String address =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Locaton(
                                                                address:
                                                                    _dropAddressController
                                                                        .text),
                                                      ),
                                                    );
                                                    setState(() {
                                                      _dropAddressController
                                                          .text = address;
                                                    });
                                                    setState(() {
                                                      if (_pickupAddressController
                                                          .text.isEmpty) {
                                                      } else {
                                                        _givesDistance(
                                                            _pickupAddressController
                                                                .text,
                                                            _dropAddressController
                                                                .text);
                                                      }
                                                    });
                                                  },

                                                  controller:
                                                      _dropAddressController,

                                                  /*controller: emailController,*/
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return "Please enter address";
                                                    }
                                                  },
                                                  //initialValue: "data(1)",
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: 18,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0,
                                                            right: 28.0),
                                                    labelText: 'Address',
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    _getLocation(
                                                        _dropAddressController);
                                                  },
                                                  icon: Icon(Icons.location_on),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: displayHeight(context) *
                                                    0.01,
                                                left: displayWidth(context) *
                                                    0.15,
                                                right: displayWidth(context) *
                                                    0.05),
                                            child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                TextFormField(
                                                  key: PageStorageKey(
                                                      'mytextfield'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller:
                                                      _dropPhoneController,

                                                  /*controller: emailController,*/
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return "Please enter the parcel value.";
                                                    }
                                                  },
                                                  //initialValue: "data(1)",
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: 18,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0),
                                                    labelText: 'Phone number',
                                                    prefixText: "+91 ",
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      Contact contact =
                                                          await _contactPicker
                                                              .selectContact();
                                                      setState(() {
                                                        _contact = contact;
                                                        if (_contact
                                                            .phoneNumber.number
                                                            .contains("+")) {
                                                          _dropPhoneController
                                                                  .text =
                                                              replaceWhitespacesUsingRegex(
                                                                  _contact
                                                                      .phoneNumber
                                                                      .number
                                                                      .substring(
                                                                          3),
                                                                  '');
                                                        } else {
                                                          _dropPhoneController
                                                                  .text =
                                                              replaceWhitespacesUsingRegex(
                                                                  _contact
                                                                      .phoneNumber
                                                                      .number,
                                                                  '');
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.contact_page)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                            width: 0,
                                            height: 0,
                                            key: PageStorageKey("test9")),
                                        /*Container(
                                      margin: EdgeInsets.only(
                                          top: displayHeight(context) * 0.01,
                                          left: displayWidth(context) * 0.15,
                                          right: displayWidth(context) * 0.05),
                                      child: TextFormField(
                                        controller: _dropDateController,
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
                                                _dropDateController.text = date
                                                    .toString()
                                                    .substring(0, 10);
                                              }
                                            });
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Arrival date',
                                        ),
                                        key: PageStorageKey("test9"),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter arrival date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),*/
                                        Container(
                                            width: 0,
                                            height: 0,
                                            key: PageStorageKey("test11")),
                                        /*Container(
                                      margin: EdgeInsets.only(
                                          left: displayWidth(context) * 0.15,
                                          right: displayWidth(context) * 0.05,
                                          top: displayHeight(context) * 0.01),
                                      child: TextFormField(
                                        readOnly: true,
                                        onTap: () async {
                                          TimeOfDay picked =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: _time);
                                          if (picked != null) {
                                            setState(() {
                                              _dropTimeController.text = picked
                                                  .toString()
                                                  .substring(10, 15);
                                            });
                                          }
                                        },
                                        controller: _dropTimeController,
                                        decoration: InputDecoration(
                                          labelText: 'Arrival time',
                                        ),
                                        key: PageStorageKey("test11"),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please select arrival time';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),*/
                                        Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  displayWidth(context) * 0.15,
                                              right:
                                                  displayWidth(context) * 0.05,
                                              top: displayHeight(context) *
                                                  0.01),
                                          child: TextFormField(
                                            controller: _dropCommentController,
                                            decoration: InputDecoration(
                                              labelText: 'Comment',
                                            ),
                                            key: PageStorageKey("test10"),
                                            /*validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },*/
                                          ),
                                        ),
                                      ]),

                                  Container(
                                    child: ListView.builder(
                                        key: PageStorageKey('myScrollable'),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: cards.length,
                                        itemBuilder: (context, index) {
                                          return cardsnow[index];
                                        }),
                                  ),

                                  removeWidget(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        cards.add(expantionTile());
                                        cardsnow.add(expantionTileNow());
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Color(0xFF27DEBF),
                                        ),
                                        SizedBox(width: 3.0),
                                        Text(
                                          "Add Delivery Point",
                                          style: TextStyle(
                                              fontFamily: 'Robotobold',
                                              fontSize: 17,
                                              color: Color(0xFF27DEBF)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    height: 20.0,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0, bottom: 2.0),
                                    child: TextFormField(
                                      controller: _itemController,
                                      readOnly: true,
                                      /*controller: emailController,*/
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "Please select the item.";
                                        }
                                      },
                                      //initialValue: "data(1)",
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0),
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
                                        left: 12.0,
                                        right: 12.0,
                                        bottom: 2.0,
                                        top: 2.0),
                                    child: TextFormField(
                                      controller: _itemDescriptionController,

                                      /*controller: emailController,*/
                                      /*validator: (String value) {
                        if (value.isEmpty) {
                          return "Please select the item.";
                        }
                        },*/
                                      //initialValue: "data(1)",
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0),
                                        labelText: 'Item description',
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0, bottom: 2.0),
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter
                                                .digitsOnly
                                          ],
                                          controller: _parcelValueController,

                                          /*controller: emailController,*/
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Please enter the parcel value.";
                                            }
                                          },
                                          //initialValue: "data(1)",
                                          style: TextStyle(
                                            fontFamily: 'roboto',
                                            fontSize: 18,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(bottom: 0),
                                            labelText: 'Parcel value',
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Stack(
                                                        overflow:
                                                            Overflow.visible,
                                                        children: <Widget>[
                                                          Positioned(
                                                            right: -40.0,
                                                            top: -40.0,
                                                            child: InkResponse(
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
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          Form(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                    "We will compensate the value of los items with in three working days according to the rules. Maximum compensation - ₹50000",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Robotobold',
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                    "You may set your parcel value up Rs 50000/- To secure your order," +
                                                                        ratePercent
                                                                            .toString() +
                                                                        "% of declared Parcel Value plus GST will be added to the delivery cost.In casr of loss or damage,the declared parcel value of the order will be rembursed.",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: Icon(Icons.info_outline)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12.0,
                                        bottom: 2.0,
                                        top: 8.0),
                                    child: TextFormField(
                                      controller: _promoCodeController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 0),
                                          labelText: "Promocode",
                                          suffixIcon: InkWell(
                                            onTap: () async {
                                              if (_promoCodeController
                                                  .text.isEmpty) {
                                                return;
                                              }
                                              setState(() {
                                                isApply = false;
                                              });
                                              var promodata =
                                                  _promoCodeController.text;
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              String token =
                                                  prefs.getString("token");
                                              Map data = {
                                                "promo_code": promodata,
                                              };
                                              var body = json.encode(data);

                                              http.Response res =
                                                  await http.post(
                                                'https://www.mitrahtechnology.in/apis/mitrah-api/order/getpromoamount.php',
                                                headers: <String, String>{
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                  "Authorization": token,
                                                },
                                                body: body,
                                              );
                                              print(res.body);
                                              var responseData =
                                                  json.decode(res.body);
                                              if (responseData['status'] ==
                                                  200) {
                                                setState(() {
                                                  isApply = true;
                                                  var amount = double.parse(
                                                      responseData["message"][0]
                                                          ["amount"]);
                                                  _promoCodePayment = amount;
                                                  _totalPayment = _weightPayment +
                                                      _distanceFirstPayment +
                                                      _parcelValuePayment -
                                                      _promoCodePayment +
                                                      ((_parcelValuePayment *
                                                              18) /
                                                          100) +
                                                      ((_weightPayment * 18) /
                                                          100);
                                                });
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomDialog(
                                                          "Success",
                                                          "Hey you saved ₹$_promoCodePayment ",
                                                          "Okay",
                                                          3),
                                                );
                                              }
                                              if (responseData['status'] ==
                                                  404) {
                                                setState(() {
                                                  isApply = true;
                                                  _promoCodeController.text =
                                                      "";
                                                  //print(responseData["message"][0]["amount"]);
                                                });

                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomDialogError(
                                                            "Error",
                                                            responseData[
                                                                'message'],
                                                            "Cancel"));
                                              }
                                            },
                                            child: Container(
                                              width: 80.0,
                                              height: 20.0,
                                              margin: EdgeInsets.only(
                                                  bottom: 5.0,
                                                  top: 5.0,
                                                  right: 5.0),
                                              child: isApply
                                                  ? Center(child: Text("Apply"))
                                                  : Center(
                                                      child: SizedBox(
                                                          width: 20.0,
                                                          height: 20.0,
                                                          child:
                                                              CircularProgressIndicator())),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)),
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    height: 20.0,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            //top: displayHeight(context) * 0.03,
                                            left: displayWidth(context) * 0.03,
                                          ),
                                          child: Text("Notify recipient by SMS",
                                              style: TextStyle(
                                                fontFamily: 'RobotoBold',
                                                color: Colors.grey,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                              )),
                                        ),
                                        Container(
                                          //padding: EdgeInsets.only(right: 0.01),
                                          margin: EdgeInsets.only(
                                              //left: displayWidth(context) * 0.2,
                                              //top: displayHeight(context) *
                                              ),
                                          child: Switch(
                                            value: isSwitched,
                                            onChanged: (value) {
                                              setState(() {
                                                isSwitched = value;
                                                print(isSwitched);
                                              });
                                            },
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    height: 20.0,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 5.0),
                                  CheckboxListTile(
                                    secondary: Container(
                                      width: 25,
                                      height: 25,
                                      child: SvgPicture.asset(
                                        money,
                                        color: Color(0xFF465A64),
                                      ),
                                    ), //const Icon(Icons.money),
                                    title: const Text(
                                      'Cash',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),

                                    value: this.valuefirst,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valuefirst = value;
                                        this.valuesecond = false;
                                        this.valuethird = false;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    secondary: Container(
                                      width: 25,
                                      height: 25,
                                      child: SvgPicture.asset(
                                        wallet,
                                        color: Color(0xFF465A64),
                                      ),
                                    ),
                                    title: const Text(
                                      'Balance',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),
                                    value: this.valuesecond,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valuesecond = value;
                                        this.valuefirst = false;
                                        this.valuethird = false;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    secondary: Container(
                                      width: 25,
                                      height: 25,
                                      child: SvgPicture.asset(
                                        mobilepayment,
                                        color: Color(0xFF465A64),
                                      ),
                                    ),
                                    title: const Text(
                                      'Online',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),
                                    value: this.valuethird,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valuethird = value;
                                        this.valuefirst = false;
                                        this.valuesecond = false;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    height: 70.0,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 5.0),
                                ],
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
                                    "amount: " +
                                        "₹" +
                                        _totalPayment.round().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'RobotoBold',
                                      color: Color(0xFF27DEBF),
                                      fontSize: displayWidth(context) * 0.05,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      if (valuefirst == true) {
                                        sendPackage();
                                      } else if (valuesecond == true) {
                                        if (walletBalance >= _totalPayment) {
                                          _minusWalletBalanace(_totalPayment);
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomDialogError(
                                                      "Error",
                                                      "You do not have sufficient balance",
                                                      "Cancel"));
                                        }
                                      } else if (valuethird == true) {
                                        int value = _totalPayment.round();
                                        openCheckout(value);
                                      }
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
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: Color(0xFF27DEBF)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      //ActiveOrders(),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //TextField(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 8.0,
                                    ),
                                    child: TextFormField(
                                      controller: _weightController,
                                      readOnly: true,

                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "Please select weight.";
                                        }
                                      },
                                      //initialValue: "data(1)",
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0),
                                        labelText: 'Select weight',
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),

                                  projectWidget(),
                                  //itemWidget(),

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
                                        Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: displayHeight(context) *
                                                    0.01,
                                                left: displayWidth(context) *
                                                    0.15,
                                                right: displayWidth(context) *
                                                    0.05),
                                            child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                TextFormField(
                                                  maxLines: null,
                                                  readOnly: true,
                                                  focusNode: pickup1FocusNode,
                                                  key: PageStorageKey(
                                                      'mytextfield'),

                                                  onTap: () async {
                                                    String address =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Locaton(
                                                                address:
                                                                    _pickupAddressController
                                                                        .text),
                                                      ),
                                                    );
                                                    setState(() {
                                                      _pickupAddressController
                                                          .text = address;
                                                    });
                                                    setState(() {
                                                      if (_dropAddressController
                                                          .text.isEmpty) {
                                                      } else {
                                                        _givesDistance(
                                                            _pickupAddressController
                                                                .text,
                                                            _dropAddressController
                                                                .text);
                                                      }
                                                    });
                                                  },

                                                  controller:
                                                      _pickupAddressController,

                                                  /*controller: emailController,*/
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return "Please enter address";
                                                    }
                                                  },
                                                  //initialValue: "data(1)",
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: 18,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0,
                                                            right: 28.0),
                                                    labelText: 'Address',
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    _getLocation(
                                                        _pickupAddressController);
                                                  },
                                                  icon: Icon(Icons.location_on),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: displayHeight(context) *
                                                    0.01,
                                                left: displayWidth(context) *
                                                    0.15,
                                                right: displayWidth(context) *
                                                    0.05),
                                            child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                TextFormField(
                                                  key: PageStorageKey(
                                                      'mytextfield'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller:
                                                      _pickupPhoneController,

                                                  /*controller: emailController,*/
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return "Please enter phone number.";
                                                    }
                                                  },
                                                  //initialValue: "data(1)",
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: 18,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0),
                                                    labelText: 'Phone number',
                                                    prefixText: "+91 ",
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      Contact contact =
                                                          await _contactPicker
                                                              .selectContact();
                                                      setState(() {
                                                        _contact = contact;
                                                        if (_contact
                                                            .phoneNumber.number
                                                            .contains("+")) {
                                                          _pickupPhoneController
                                                                  .text =
                                                              replaceWhitespacesUsingRegex(
                                                                  _contact
                                                                      .phoneNumber
                                                                      .number
                                                                      .substring(
                                                                          3),
                                                                  '');
                                                        } else {
                                                          _pickupPhoneController
                                                                  .text =
                                                              replaceWhitespacesUsingRegex(
                                                                  _contact
                                                                      .phoneNumber
                                                                      .number,
                                                                  '');
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.contact_page)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top:
                                                  displayHeight(context) * 0.01,
                                              left:
                                                  displayWidth(context) * 0.15,
                                              right:
                                                  displayWidth(context) * 0.05),
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          _dateTime == null
                                                              ? DateTime.now()
                                                              : _dateTime,
                                                      firstDate: DateTime(2001),
                                                      lastDate: DateTime(2022))
                                                  .then((date) {
                                                setState(() {
                                                  //_dateTime = date;
                                                  if (date != null) {
                                                    _pickupDateController.text =
                                                        date
                                                            .toString()
                                                            .substring(0, 10);
                                                  }
                                                });
                                              });
                                            },
                                            controller: _pickupDateController,
                                            decoration: InputDecoration(
                                              labelText: "Pickup date",
                                            ),
                                            key: PageStorageKey("test4"),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter pickup date';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  displayWidth(context) * 0.15,
                                              right:
                                                  displayWidth(context) * 0.05,
                                              top: displayHeight(context) *
                                                  0.01),
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay picked =
                                                  await showTimePicker(
                                                      context: context,
                                                      initialTime: _time);
                                              if (picked != null) {
                                                setState(() {
                                                  _pickupTimeController.text =
                                                      picked
                                                          .toString()
                                                          .substring(10, 15);
                                                });
                                              }
                                            },
                                            controller: _pickupTimeController,
                                            decoration: InputDecoration(
                                              labelText: 'Pickup time',
                                            ),
                                            key: PageStorageKey("test6"),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please select pickup time';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  displayWidth(context) * 0.15,
                                              right:
                                                  displayWidth(context) * 0.05,
                                              top: displayHeight(context) *
                                                  0.01),
                                          child: TextFormField(
                                            controller:
                                                _pickupCommentController,
                                            decoration: InputDecoration(
                                              labelText: 'Comment',
                                            ),
                                            key: PageStorageKey("test5"),
                                            /*validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },*/
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
                                        Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: displayHeight(context) *
                                                    0.01,
                                                left: displayWidth(context) *
                                                    0.15,
                                                right: displayWidth(context) *
                                                    0.05),
                                            child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                TextFormField(
                                                  maxLines: null,
                                                  readOnly: true,
                                                  key: PageStorageKey(
                                                      'mytextfield'),

                                                  onTap: () async {
                                                    String address =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Locaton(
                                                                address:
                                                                    _dropAddressController
                                                                        .text),
                                                      ),
                                                    );
                                                    setState(() {
                                                      _dropAddressController
                                                          .text = address;
                                                    });
                                                    setState(() {
                                                      if (_pickupAddressController
                                                          .text.isEmpty) {
                                                      } else {
                                                        _givesDistance(
                                                            _pickupAddressController
                                                                .text,
                                                            _dropAddressController
                                                                .text);
                                                      }
                                                    });
                                                  },

                                                  controller:
                                                      _dropAddressController,

                                                  /*controller: emailController,*/
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return "Please enter address";
                                                    }
                                                  },
                                                  //initialValue: "data(1)",
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: 18,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0,
                                                            right: 28.0),
                                                    labelText: 'Address',
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    _getLocation(
                                                        _dropAddressController);
                                                  },
                                                  icon: Icon(Icons.location_on),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: displayHeight(context) *
                                                    0.01,
                                                left: displayWidth(context) *
                                                    0.15,
                                                right: displayWidth(context) *
                                                    0.05),
                                            child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                TextFormField(
                                                  key: PageStorageKey(
                                                      'mytextfield'),

                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller:
                                                      _dropPhoneController,

                                                  /*controller: emailController,*/
                                                  validator: (String value) {
                                                    if (value.isEmpty) {
                                                      return "Please enter the parcel value.";
                                                    }
                                                  },
                                                  //initialValue: "data(1)",
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: 18,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0),
                                                    labelText: 'Phone number',
                                                    prefixText: "+91 ",
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      Contact contact =
                                                          await _contactPicker
                                                              .selectContact();
                                                      setState(() {
                                                        _contact = contact;
                                                        if (_contact
                                                            .phoneNumber.number
                                                            .contains("+")) {
                                                          _dropPhoneController
                                                                  .text =
                                                              replaceWhitespacesUsingRegex(
                                                                  _contact
                                                                      .phoneNumber
                                                                      .number
                                                                      .substring(
                                                                          3),
                                                                  '');
                                                        } else {
                                                          _dropPhoneController
                                                                  .text =
                                                              replaceWhitespacesUsingRegex(
                                                                  _contact
                                                                      .phoneNumber
                                                                      .number,
                                                                  '');
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.contact_page)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top:
                                                  displayHeight(context) * 0.01,
                                              left:
                                                  displayWidth(context) * 0.15,
                                              right:
                                                  displayWidth(context) * 0.05),
                                          child: TextFormField(
                                            controller: _dropDateController,
                                            readOnly: true,
                                            onTap: () {
                                              showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          _dateTime == null
                                                              ? DateTime.now()
                                                              : _dateTime,
                                                      firstDate: DateTime(2001),
                                                      lastDate: DateTime(2022))
                                                  .then((date) {
                                                setState(() {
                                                  //_dateTime = date;
                                                  if (date != null) {
                                                    _dropDateController.text =
                                                        date
                                                            .toString()
                                                            .substring(0, 10);
                                                  }
                                                });
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Arrival date',
                                            ),
                                            key: PageStorageKey("test9"),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter arrival date';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  displayWidth(context) * 0.15,
                                              right:
                                                  displayWidth(context) * 0.05,
                                              top: displayHeight(context) *
                                                  0.01),
                                          child: TextFormField(
                                            readOnly: true,
                                            onTap: () async {
                                              TimeOfDay picked =
                                                  await showTimePicker(
                                                      context: context,
                                                      initialTime: _time);
                                              if (picked != null) {
                                                setState(() {
                                                  _dropTimeController.text =
                                                      picked
                                                          .toString()
                                                          .substring(10, 15);
                                                });
                                              }
                                            },
                                            controller: _dropTimeController,
                                            decoration: InputDecoration(
                                              labelText: 'Arrival time',
                                            ),
                                            key: PageStorageKey("test11"),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please select arrival time';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  displayWidth(context) * 0.15,
                                              right:
                                                  displayWidth(context) * 0.05,
                                              top: displayHeight(context) *
                                                  0.01),
                                          child: TextFormField(
                                            controller: _dropCommentController,
                                            decoration: InputDecoration(
                                              labelText: 'Comment',
                                            ),
                                            key: PageStorageKey("test10"),
                                            /*validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },*/
                                          ),
                                        ),
                                      ]),

                                  Container(
                                    child: ListView.builder(
                                        key: PageStorageKey('myScrollable'),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: cards.length,
                                        itemBuilder: (context, index) {
                                          return cards[index];
                                        }),
                                  ),

                                  removeWidget(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        cards.add(expantionTile());
                                        cardsnow.add(expantionTileNow());
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Color(0xFF27DEBF),
                                        ),
                                        SizedBox(width: 3.0),
                                        Text(
                                          "Add Delivery Point",
                                          style: TextStyle(
                                              fontFamily: 'Robotobold',
                                              fontSize: 17,
                                              color: Color(0xFF27DEBF)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    height: 20.0,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0, bottom: 2.0),
                                    child: TextFormField(
                                      controller: _itemController,
                                      readOnly: true,
                                      /*controller: emailController,*/
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "Please select the item.";
                                        }
                                      },
                                      //initialValue: "data(1)",
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0),
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
                                        left: 12.0,
                                        right: 12.0,
                                        bottom: 2.0,
                                        top: 2.0),
                                    child: TextFormField(
                                      controller: _itemDescriptionController,

                                      /*controller: emailController,*/
                                      /*validator: (String value) {
                        if (value.isEmpty) {
                          return "Please select the item.";
                        }
                        },*/
                                      //initialValue: "data(1)",
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0),
                                        labelText: 'Item description',
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0, bottom: 2.0),
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter
                                                .digitsOnly
                                          ],
                                          controller: _parcelValueController,

                                          /*controller: emailController,*/
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Please enter the parcel value.";
                                            }
                                          },
                                          //initialValue: "data(1)",
                                          style: TextStyle(
                                            fontFamily: 'roboto',
                                            fontSize: 18,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(bottom: 0),
                                            labelText: 'Parcel value',
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Stack(
                                                        overflow:
                                                            Overflow.visible,
                                                        children: <Widget>[
                                                          Positioned(
                                                            right: -40.0,
                                                            top: -40.0,
                                                            child: InkResponse(
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
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          Form(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                    "We will compensate the value of los items with in three working days according to the rules. Maximum compensation - ₹50000",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Robotobold',
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                    "You may set your parcel value up Rs 50000/- To secure your order," +
                                                                        ratePercent
                                                                            .toString() +
                                                                        "% of declared Parcel Value plus GST will be added to the delivery cost.In casr of loss or damage,the declared parcel value of the order will be rembursed.",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: Icon(Icons.info_outline)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12.0,
                                        bottom: 2.0,
                                        top: 8.0),
                                    child: TextFormField(
                                      controller: _promoCodeController,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 0),
                                          labelText: "Promocode",
                                          suffixIcon: InkWell(
                                            onTap: () async {
                                              if (_promoCodeController
                                                  .text.isEmpty) {
                                                return;
                                              }
                                              setState(() {
                                                isApply = false;
                                              });
                                              var promodata =
                                                  _promoCodeController.text;
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              String token =
                                                  prefs.getString("token");
                                              Map data = {
                                                "promo_code": promodata,
                                              };
                                              var body = json.encode(data);

                                              http.Response res =
                                                  await http.post(
                                                'https://www.mitrahtechnology.in/apis/mitrah-api/order/getpromoamount.php',
                                                headers: <String, String>{
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                  "Authorization": token,
                                                },
                                                body: body,
                                              );
                                              print(res.body);
                                              var responseData =
                                                  json.decode(res.body);
                                              if (responseData['status'] ==
                                                  200) {
                                                setState(() {
                                                  isApply = true;
                                                  var amount = double.parse(
                                                      responseData["message"][0]
                                                          ["amount"]);
                                                  _promoCodePayment = amount;
                                                  _totalPayment = _weightPayment +
                                                      _distanceFirstPayment +
                                                      _parcelValuePayment -
                                                      _promoCodePayment +
                                                      ((_parcelValuePayment *
                                                              18) /
                                                          100) +
                                                      ((_weightPayment * 18) /
                                                          100);
                                                });
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomDialog(
                                                          "Success",
                                                          "Hey you saved ₹$_promoCodePayment ",
                                                          "Okay",
                                                          3),
                                                );
                                              }
                                              if (responseData['status'] ==
                                                  404) {
                                                setState(() {
                                                  isApply = true;
                                                  _promoCodeController.text =
                                                      "";
                                                  //print(responseData["message"][0]["amount"]);
                                                });

                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomDialogError(
                                                            "Error",
                                                            responseData[
                                                                'message'],
                                                            "Cancel"));
                                              }
                                            },
                                            child: Container(
                                              width: 80.0,
                                              height: 20.0,
                                              margin: EdgeInsets.only(
                                                  bottom: 5.0,
                                                  top: 5.0,
                                                  right: 5.0),
                                              child: isApply
                                                  ? Center(child: Text("Apply"))
                                                  : Center(
                                                      child: SizedBox(
                                                          width: 20.0,
                                                          height: 20.0,
                                                          child:
                                                              CircularProgressIndicator())),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)),
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    height: 20.0,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            //top: displayHeight(context) * 0.03,
                                            left: displayWidth(context) * 0.03,
                                          ),
                                          child: Text("Notify recipient by SMS",
                                              style: TextStyle(
                                                fontFamily: 'RobotoBold',
                                                color: Colors.grey,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                              )),
                                        ),
                                        Container(
                                          //padding: EdgeInsets.only(right: 0.01),
                                          margin: EdgeInsets.only(
                                              //left: displayWidth(context) * 0.2,
                                              //top: displayHeight(context) *
                                              ),
                                          child: Switch(
                                            value: isSwitched,
                                            onChanged: (value) {
                                              setState(() {
                                                isSwitched = value;
                                                print(isSwitched);
                                              });
                                            },
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    height: 20.0,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 5.0),

                                  CheckboxListTile(
                                    secondary: Container(
                                      width: 25,
                                      height: 25,
                                      child: SvgPicture.asset(
                                        money,
                                        color: Color(0xFF465A64),
                                      ),
                                    ), //const Icon(Icons.money),
                                    title: const Text(
                                      'Cash',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),

                                    value: this.valuefirst,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valuefirst = value;
                                        this.valuesecond = false;
                                        this.valuethird = false;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    secondary: Container(
                                      width: 25,
                                      height: 25,
                                      child: SvgPicture.asset(
                                        wallet,
                                        color: Color(0xFF465A64),
                                      ),
                                    ),
                                    title: const Text(
                                      'Balance',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),
                                    value: this.valuesecond,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valuesecond = value;
                                        this.valuefirst = false;
                                        this.valuethird = false;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    secondary: Container(
                                      width: 25,
                                      height: 25,
                                      child: SvgPicture.asset(
                                        mobilepayment,
                                        color: Color(0xFF465A64),
                                      ),
                                    ),
                                    title: const Text(
                                      'Online',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 17,
                                      ),
                                    ),
                                    value: this.valuethird,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valuethird = value;
                                        this.valuefirst = false;
                                        this.valuesecond = false;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    height: 70.0,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(height: 5.0),
                                ],
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
                                    "amount: " +
                                        "₹" +
                                        _totalPayment.round().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'RobotoBold',
                                      color: Color(0xFF27DEBF),
                                      fontSize: displayWidth(context) * 0.05,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      if (valuefirst == true) {
                                        sendPackage();
                                      } else if (valuesecond == true) {
                                        if (walletBalance >= _totalPayment) {
                                          _minusWalletBalanace(_totalPayment);
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomDialogError(
                                                      "Error",
                                                      "You do not have sufficient balance",
                                                      "Cancel"));
                                        }
                                      } else if (valuethird == true) {
                                        int value = _totalPayment.round();
                                        openCheckout(value);
                                      }
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
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: Color(0xFF27DEBF)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      //ActiveOrders(),
                    ),
                  ]),
            )),
      ),
    );
  }

  Future<http.Response> sendPackage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    List<Map> dropData = [
      {
        "address": _dropAddressController.text,
        "phn_number": _dropPhoneController.text,
        "arrive_date": _dropDateController.text,
        "arrive_time": _dropTimeController.text,
        "comment": _dropCommentController.text,
      },
    ];

    for (var i = 0; i < addressTECs.length; i++) {
      var extraaddressdata = {
        "address": addressTECs[i].text,
        "phn_number": phoneTECs[i].text,
        "arrive_date": arrivedateTECs[i].text,
        "arrive_time": arrivetimeTECs[i].text,
        "comment": commentTECs[i].text,
      };
      dropData.add(extraaddressdata);
    }

    Map data = {
      "weight": _weightController.text,
      "pickup_point": [
        {
          "address": _pickupAddressController.text,
          "phn_number": _pickupPhoneController.text,
          "pickup_time": _pickupTimeController.text,
          "pickup_date": _pickupDateController.text,
          "comment": _pickupCommentController.text
        }
      ],
      "delivery_point": dropData,
      //------------------------------
      "item_type": _itemController.text,
      "item_description": _itemDescriptionController.text,
      "parcel_value": _parcelValueController.text,
      "promo_code": _promoCodeController.text,
      "promo_amount": _promoCodePayment,
      "contact_number": "2020202",
      "is_notified": isSwitched ? 1 : 0,
      "is_accept": 0,
      "tax_amount": ratePercent,
      "order_amount": _totalPayment,
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
    if (responseData["status"] == 200) {
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

  Future<http.Response> _minusWalletBalanace(double minusAmount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res;

    Map data = {
      "amount": minusAmount.round(),
      "type": "debit",
      "status": "success",
      "payment_mode": "UPI",
      "comment": "DONT KNOW"
    };

    var body = json.encode(data);

    res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/wallet_transaction.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    print(res.body);
    var responseData = json.decode(res.body);
    if (responseData['status'] == 200) {
      sendPackage();
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", responseData['message'], "Cancel"));
    }

    return res;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    sendPackage();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  Future<http.Response> _givesDistance(String address1, String address2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res;

    Map data = {
      "address_from": address1,
      "address_to": address2,
    };

    var body = json.encode(data);

    res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/calculate_distance.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    print(res.body);
    var responseData = json.decode(res.body);
    if (responseData['status'] == 200) {
      setState(() {
        _distanceFirstPayment = 100;
        _totalPayment = _weightPayment +
            _distanceFirstPayment +
            _parcelValuePayment -
            _promoCodePayment +
            ((_weightPayment * 18) / 100) +
            ((_parcelValuePayment * 18) / 100);
      });
    } else {
      setState(() {
        _distanceFirstPayment = 0;
        _totalPayment = _weightPayment +
            _distanceFirstPayment +
            _parcelValuePayment -
            _promoCodePayment +
            ((_weightPayment * 18) / 100) +
            ((_parcelValuePayment * 18) / 100);
      });
      showDialog(
          context: context,
          builder: (context) =>
              CustomDialogError("Error", "Address is required", "Cancel"));
    }

    return res;
  }

  Future<dynamic> _givesDistance1(String address1, String address2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    http.Response res;

    Map data = {
      "address_from": address1,
      "address_to": address2,
    };

    var body = json.encode(data);

    res = await http.post(
      'https://www.mitrahtechnology.in/apis/mitrah-api/calculate_distance.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token,
      },
      body: body,
    );
    print(res.body);
    var responseData = json.decode(res.body);

    if (responseData['status'] == 200) {
      return responseData['amount'];
    } else {
      return responseData['amount'];
    }
  }
}

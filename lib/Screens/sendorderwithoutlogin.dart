import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:postmaster/Components/animate.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'dart:io';
import 'package:contact_picker/contact_picker.dart';

class NewOrder1 extends StatefulWidget {
  NewOrder1({
    Key key,
    this.weightData,
    this.itemData,
    this.rate,
  }) : super(key: key);

  final Future<List<dynamic>> weightData;
  final Future<List<dynamic>> itemData;
  final Future<String> rate;

  @override
  _NewOrder1State createState() => _NewOrder1State();
}

class _NewOrder1State extends State<NewOrder1> {
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
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  //PickResult selectedPlace;
  Color _textColor = Colors.green;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
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
  double ratePercent;

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
        String price = rate.substring(0, rate.length);
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
    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                        Container(
                          margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.01,
                              left: displayWidth(context) * 0.15,
                              right: displayWidth(context) * 0.05),
                          child: TextFormField(
                            controller: _pickupAddressController,
                            //readOnly: true,
                            /*onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PlacePicker(
                                      apiKey:
                                          "AIzaSyCy2iHXEQ9U4c77tJSBW5WPD5vRA8EEH94",
                                      initialPosition:
                                          MyCustomForm.kInitialPosition,
                                      useCurrentLocation: true,
                                      selectInitialPosition: true,

                                      //usePlaceDetailSearch: true,
                                      onPlacePicked: (result) {
                                        selectedPlace = result;
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                      //forceSearchOnZoomChanged: true,
                                      //automaticallyImplyAppBarLeading: false,
                                      //autocompleteLanguage: "ko",
                                      //region: 'au',
                                      //selectInitialPosition: true,
                                      // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                                      //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                                      //   return isSearchBarFocused
                                      //       ? Container()
                                      //       : FloatingCard(
                                      //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                      //           leftPosition: 0.0,
                                      //           rightPosition: 0.0,
                                      //           width: 500,
                                      //           borderRadius: BorderRadius.circular(12.0),
                                      //           child: state == SearchingState.Searching
                                      //               ? Center(child: CircularProgressIndicator())
                                      //               : RaisedButton(
                                      //                   child: Text("Pick Here"),
                                      //                   onPressed: () {
                                      //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                      //                     //            this will override default 'Select here' Button.
                                      //                     print("do something with [selectedPlace] data");
                                      //                     Navigator.of(context).pop();
                                      //                   },
                                      //                 ),
                                      //         );
                                      // },
                                      // pinBuilder: (context, state) {
                                      //   if (state == PinState.Idle) {
                                      //     return Icon(Icons.favorite_border);
                                      //   } else {
                                      //     return Icon(Icons.favorite);
                                      //   }
                                      // },
                                    );
                                  },
                                ),
                              );
                            },*/
                            decoration: InputDecoration(
                              labelText: 'address',
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
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  controller: _pickupPhoneController,

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
                                      Contact contact =
                                          await _contactPicker.selectContact();
                                      setState(() {
                                        _contact = contact;
                                        if (_contact.phoneNumber.number
                                            .contains("+")) {
                                          _pickupPhoneController.text =
                                              replaceWhitespacesUsingRegex(
                                                  _contact.phoneNumber.number
                                                      .substring(3),
                                                  '');
                                        } else {
                                          _pickupPhoneController.text =
                                              replaceWhitespacesUsingRegex(
                                                  _contact.phoneNumber.number,
                                                  '');
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
                                        date.toString().substring(0, 10);
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
                                  _pickupTimeController.text =
                                      picked.toString().substring(10, 15);
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
                              left: displayWidth(context) * 0.15,
                              right: displayWidth(context) * 0.05,
                              top: displayHeight(context) * 0.01),
                          child: TextFormField(
                            controller: _pickupCommentController,
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
                        Container(
                          margin: EdgeInsets.only(
                              top: displayHeight(context) * 0.01,
                              left: displayWidth(context) * 0.15,
                              right: displayWidth(context) * 0.05),
                          child: TextFormField(
                            controller: _dropAddressController,
                            decoration: InputDecoration(
                              labelText: 'Address',
                            ),
                            key: PageStorageKey("test7"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please select the address';
                              }
                              return null;
                            },
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
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  controller: _dropPhoneController,

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
                                      Contact contact =
                                          await _contactPicker.selectContact();
                                      setState(() {
                                        _contact = contact;
                                        if (_contact.phoneNumber.number
                                            .contains("+")) {
                                          _dropPhoneController.text =
                                              replaceWhitespacesUsingRegex(
                                                  _contact.phoneNumber.number
                                                      .substring(3),
                                                  '');
                                        } else {
                                          _dropPhoneController.text =
                                              replaceWhitespacesUsingRegex(
                                                  _contact.phoneNumber.number,
                                                  '');
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
                                    _dropDateController.text =
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
                              TimeOfDay picked = await showTimePicker(
                                  context: context, initialTime: _time);
                              if (picked != null) {
                                setState(() {
                                  _dropTimeController.text =
                                      picked.toString().substring(10, 15);
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
                              left: displayWidth(context) * 0.15,
                              right: displayWidth(context) * 0.05,
                              top: displayHeight(context) * 0.01),
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
                        left: 12.0, right: 12.0, bottom: 2.0, top: 2.0),
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
                        contentPadding: EdgeInsets.only(bottom: 0),
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
                            WhitelistingTextInputFormatter.digitsOnly
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
                            contentPadding: EdgeInsets.only(bottom: 0),
                            labelText: 'Parcel value',
                          ),
                        ),
                        IconButton(
                            onPressed: () {
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
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "We will compensate the value of los items with in three working days according to the rules. Maximum compensation - ₹50000",
                                                    style: TextStyle(
                                                      fontFamily: 'Robotobold',
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "You may set your parcel value up Rs 50000/- To secure your order," +
                                                        ratePercent.toString() +
                                                        "% of declared Parcel Value plus GST will be added to the delivery cost.In casr of loss or damage,the declared parcel value of the order will be rembursed.",
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 17,
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
                                  var amount = double.parse(
                                      responseData["message"][0]["amount"]);
                                  _promoCodePayment = amount;
                                  _totalPayment = _weightPayment +
                                      _parcelValuePayment -
                                      _promoCodePayment +
                                      ((_parcelValuePayment * 18) / 100) +
                                      ((_weightPayment * 18) / 100);
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
                  Container(
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
          "address": _pickupAddressController.text,
          "phn_number": _pickupPhoneController.text,
          "pickup_time": _pickupTimeController.text,
          "pickup_date": _pickupDateController.text,
          "comment": _pickupCommentController.text
        }
      ],
      "delivery_point": [
        {
          "address": _dropAddressController.text,
          "phn_number": _dropPhoneController.text,
          "arrive_date": _dropDateController.text,
          "arrive_time": _dropTimeController.text,
          "comment": _dropCommentController.text,
        },
        {
          "address": "d2",
          "phn_number": "789654",
          "arrive_date": "10 Feb 2021",
          "arrive_time": "d21:21",
          "comment": "d2222222"
        }
      ],
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
}

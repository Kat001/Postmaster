import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';

class NewOrderStore extends StatelessWidget {
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
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: displayWidth(context) * 0.02,
                          top: displayHeight(context) * 0.01),
                      height: displayHeight(context) * 0.05,
                      width: displayWidth(context) * 0.3,
                      child: Text(
                        "Up to 1 kg",
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
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: displayWidth(context) * 0.02,
                          top: displayHeight(context) * 0.01),
                      height: displayHeight(context) * 0.05,
                      width: displayWidth(context) * 0.3,
                      child: Text(
                        "Up to 5 kg",
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
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: displayWidth(context) * 0.02,
                          top: displayHeight(context) * 0.01),
                      height: displayHeight(context) * 0.05,
                      width: displayWidth(context) * 0.3,
                      child: Text(
                        "Up to 10 kg",
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
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: displayWidth(context) * 0.02,
                          top: displayHeight(context) * 0.01),
                      height: displayHeight(context) * 0.05,
                      width: displayWidth(context) * 0.3,
                      child: Text(
                        "Up to 15 kg",
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
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: displayWidth(context) * 0.02,
                          top: displayHeight(context) * 0.01),
                      height: displayHeight(context) * 0.05,
                      width: displayWidth(context) * 0.3,
                      child: Text(
                        "Up to 20 kg",
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
                    )
                  ],
                ),
              ),
            ),
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
                      decoration: InputDecoration(
                        hintText: "Address",
                      ),
                      key: PageStorageKey("tests2"),
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
                      key: PageStorageKey("tests3"),
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
                      key: PageStorageKey("tests4"),
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
                        hintText: "Comment",
                      ),
                      key: PageStorageKey("tests5"),
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
                      decoration: InputDecoration(
                        hintText: "Address",
                      ),
                      key: PageStorageKey("tests7"),
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
                      key: PageStorageKey("tests8"),
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
                      key: PageStorageKey("tests9"),
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
                        hintText: "Comment",
                      ),
                      key: PageStorageKey("tests0"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ]),
            //Store Detailes
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
                        hintText: "Comment",
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
                ]),
            Column(children: [
              Container(
                margin: EdgeInsets.only(
                    left: displayWidth(context) * 0.15,
                    right: displayWidth(context) * 0.05,
                    top: displayHeight(context) * 0.01),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "What are you sending",
                  ),
                  key: PageStorageKey("tests16"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: displayWidth(context) * 0.15,
                            top: displayHeight(context) * 0.01),
                        height: displayHeight(context) * 0.05,
                        width: displayWidth(context) * 0.3,
                        child: Text(
                          "Documents",
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
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: displayWidth(context) * 0.02,
                            top: displayHeight(context) * 0.01),
                        height: displayHeight(context) * 0.05,
                        width: displayWidth(context) * 0.3,
                        child: Text(
                          "Food",
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
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: displayWidth(context) * 0.02,
                            top: displayHeight(context) * 0.01),
                        height: displayHeight(context) * 0.05,
                        width: displayWidth(context) * 0.3,
                        child: Text(
                          "Cloths",
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
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: displayWidth(context) * 0.02,
                            top: displayHeight(context) * 0.01),
                        height: displayHeight(context) * 0.05,
                        width: displayWidth(context) * 0.3,
                        child: Text(
                          "Groceries",
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
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: displayWidth(context) * 0.02,
                            top: displayHeight(context) * 0.01),
                        height: displayHeight(context) * 0.05,
                        width: displayWidth(context) * 0.3,
                        child: Text(
                          "Flowers",
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
                      )
                    ],
                  ),
                ),
              )
            ]),
            Container(
              margin: EdgeInsets.only(
                  left: displayWidth(context) * 0.15,
                  right: displayWidth(context) * 0.05,
                  top: displayHeight(context) * 0.01),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Parcel Value",
                ),
                key: PageStorageKey("tests16"),
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
                  hintText: "Promo Code",
                ),
                key: PageStorageKey("tests16"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: displayHeight(context) * 0.03,
                      left: displayWidth(context) * 0.15,
                    ),
                    child: Text("Notify recipient by SMS",
                        style: TextStyle(
                          fontFamily: 'RobotoBold',
                          color: Colors.grey,
                          fontSize: displayWidth(context) * 0.05,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
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
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 50),
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
                                fontFamily: 'RobotoBold',
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
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 50),
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
                                fontFamily: 'RobotoBold',
                                fontSize: 17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25, left: 50),
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
                                    "Onlne ",
                                    style: TextStyle(
                                      fontFamily: 'RobotoBold',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

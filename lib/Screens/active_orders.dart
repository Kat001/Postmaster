import 'package:flutter/material.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/animate.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print("hii in actkjkdas");
  }

  Widget orderWidget() {
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
              "Order-id:#580013",
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
                  "₹50000",
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
                                        child: TextFormField(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          child: Text("Submitß"),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
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
                    "Greator noida, Uttar Pradesh, india",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: displayWidth(context) * 0.03,
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: Text(
                    "Greator Kailash, New Delhi, Delhi 110048",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
            orderWidget(),
          ],
        ),
      ),
    );
  }
}

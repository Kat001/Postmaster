import 'package:flutter/material.dart';
import 'package:postmaster/Screens/Homepage.dart';
import 'package:postmaster/Components/animate.dart';

class CreateOrder extends StatefulWidget {
  @override
  _CreateOrderState createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Create order",
            style: TextStyle(
                fontFamily: "RobotoBold",
                fontSize: 20.0,
                color: Color(0xFF2AD0B5),
                letterSpacing: 2),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, SlideRightRoute(page: Homepage()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: new EdgeInsets.only(left: 30, right: 30, top: 20),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 30, right: 30, top: 0),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Select PichUp Address',
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 30, right: 30, top: 0),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Select weight',
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 30, right: 30, top: 0),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Items',
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 30, right: 30, top: 0),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Parcel Value',
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 30, right: 30, top: 0),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Promo Code',
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 30, right: 30, top: 0),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Payment Options',
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(left: 75, right: 75, top: 20),
                child: MaterialButton(
                  // color: Color(0xFF27DEBF),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                          "Success", "Order Placed Successfully", "Okay", 1),
                    );
                  },
                  minWidth: 250.0,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8.0)),
                  height: 45.0,
                  child: Text(
                    "Create Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontFamily: 'RobotoBold',
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    gradient: RadialGradient(
                        radius: 15,
                        colors: [Color(0xFF27DEBF), Color(0xFF465A64)])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

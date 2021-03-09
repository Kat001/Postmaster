import 'package:flutter/material.dart';

import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:postmaster/Screens/Location.dart';

class Locaton extends StatefulWidget {
  @override
  _LocatonState createState() => _LocatonState();
}

class _LocatonState extends State<Locaton> {
  TextEditingController addressController = TextEditingController();

  void findLocationFromMap() async {
    LocationResult _pickedLocation;
    LocationResult result = await showLocationPicker(
      context,
      "AIzaSyA0tKe1TVWfYekFFY0WisJc6WQkI-6gXEs",
      initialCenter: LatLng(22.311199, 73.181976),
      automaticallyAnimateToCurrentLocation: true,
      mapStylePath: 'assets/mapStyle.json',
      myLocationButtonEnabled: true,
      // requiredGPS: true,
      layersButtonEnabled: true,
      // countries: ['AE', 'NG']

//                      resultCardAlignment: Alignment.bottomCenter,
      desiredAccuracy: LocationAccuracy.best,
    );
    print("result = $result");
    setState(() {
      _pickedLocation = result;
      addressController.text = result.address;
    });
    Navigator.pop(context, addressController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Address selection",
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 20.0),
            child: Row(
              children: [
                Container(
                  child: Flexible(
                    child: TextFormField(
                      maxLines: null,
                      autofocus: true,
                      controller: addressController,
                      decoration: new InputDecoration(hintText: 'Address'),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.location_on,
                  color: Color(0xFF2AD0B5),
                ),
                InkWell(
                  onTap: () {
                    findLocationFromMap();
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      "Map",
                      style: TextStyle(
                          fontFamily: "RobotoBold",
                          fontSize: 20.0,
                          color: Color(0xFF2AD0B5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: new EdgeInsets.only(top: 40),
              child: MaterialButton(
                // color: Color(0xFF27DEBF),
                onPressed: () {
                  Navigator.pop(context, addressController.text);
                },
                minWidth: 250.0,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8.0)),
                height: 45.0,
                child: Text(
                  "Done",
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
          ),
        ],
      ),
    );
  }
}

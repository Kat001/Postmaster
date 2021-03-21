import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:location/location.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  List<String> items;

  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

  var lat = 22.307159;
  var lang = 73.181221;

  LatLng _initialcameraposition = LatLng(22.307159, 73.181221);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  void setCustomMarker() {
    //mapMarker = BitmapDescriptor.fromAssetImage(configuration, assetName);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _markers.add(Marker(
      markerId: MarkerId("id-1"),
      position: LatLng(lat, lang),
      //icon:Icon(Icons.add),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
        child: Center(child: Text("Click yrr")),
        onPressed: () async {
          try {
            var address = await Geocoder.local
                .findAddressesFromQuery("Shyamal County Vadodara,India");
            //print(address.first.coordinates);
            print(address.last.coordinates);
          } on Exception catch (exception) {
            print(exception);
          } catch (error) {
            // executed for errors of all types other than Exception
          }
        },
      ), /*Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                //mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                  zoom: 12,
                ),
                markers: _markers,

                onCameraMove: (_position) {
                  print(_position);
                },
                onCameraIdle: () {
                  print("Donemlkdsjfkldsfds");
                },
              ),
              Container(
                child: Icon(
                  Icons.location_on,
                  color: Colors.pink[400],
                  size: 20.0,
                ),
              )
            ],
          ),
        ),
      ),*/
    );
  }
}

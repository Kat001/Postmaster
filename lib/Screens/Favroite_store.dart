import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Screens/Favorite_resto.dart';
//import 'package:postmaster/Screens/Createorder.dart';
//import 'package:postmaster/Screens/Homepage.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Profile.dart';
import 'package:postmaster/Screens/New_Orders.dart';
import 'package:postmaster/models/restaurant.dart';
import 'package:sizer/sizer.dart';
import 'package:postmaster/Screens/Info.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteStore extends StatefulWidget {
  FavoriteStore({
    Key key,
    this.weightData,
    this.itemData,
    this.rate,
  }) : super(key: key);

  final Future<List<dynamic>> weightData;
  final Future<List<dynamic>> itemData;
  final Future<String> rate;
  @override
  _FavoriteStoreState createState() => _FavoriteStoreState();
}

class _FavoriteStoreState extends State<FavoriteStore> {
  bool _isdata = true;
  List<Restaurant> _restaurants = List<Restaurant>();
  List<Restaurant> _restaurantsForDisplay = List<Restaurant>();

  List<String> restoData = [];

  TextEditingController _searchcontroller = TextEditingController();
  Restaurant obj = Restaurant();

  @override
  void initState() {
    super.initState();
    fetchrestoData().then((value) {
      setState(() {
        _restaurants.addAll(value);

        _restaurantsForDisplay = _restaurants;
        //print(_restaurants);
      });
    });
  }

  Future<List<Restaurant>> fetchrestoData() async {
    http.Response res = await http.get(
      'https://www.mitrahtechnology.in/apis/mitrah-api/order/getdetail.php',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "user": "admin",
        "password": "1234",
        "table_name": "restaurant"
      },
    );
    print(res.body);
    var responseData = json.decode(res.body);

    var restaurants = List<Restaurant>();

    if (responseData["status"] == 200) {
      var notesJson = responseData["message"];
      for (var noteJson in notesJson) {
        restaurants.add(Restaurant.fromJson(noteJson));
        //print(Restaurant.fromJson(noteJson));
      }
    }

    //print(responseData);
    /*
    */
    setState(() {
      _isdata = false;
    });

    return restaurants;
  }

  Widget restaurant() {
    return ListView.builder(
      itemCount: _restaurantsForDisplay.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return index == 0 ? Container() : _listItem(index - 1);
      },
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchcontroller,
        decoration: InputDecoration(hintText: 'Search...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _restaurantsForDisplay = _restaurants.where((note) {
              var restaurantName = note.name.toLowerCase();
              return restaurantName.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return InkWell(
      onTap: () {
        setState(() {
          _searchcontroller.text = _restaurantsForDisplay[index].name;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _restaurantsForDisplay[index].name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                _restaurantsForDisplay[index].contact,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _searchcontroller,
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              _restaurantsForDisplay = _restaurants.where((note) {
                var restaurantName = note.name.toLowerCase();
                return restaurantName.contains(text);
              }).toList();
            });
          },
          decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: Color(0xFF757575), fontSize: 16),
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFF757575),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              fillColor: Color(0xFFEEEEEE),
              filled: true),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2BCDB4),
        onPressed: () {
          String retname = _searchcontroller.text;

          bool flag;
          for (var resturant in _restaurants) {
            if (resturant.name == retname) {
              obj = resturant;
              flag = true;
              break;
            } else {
              flag = false;
            }
          }
          if (flag == true) {
            Navigator.push(
                context,
                SlideLeftRoute(
                    page: FavoriteResto(
                  weightData: widget.weightData,
                  itemData: widget.itemData,
                  rate: widget.rate,
                  restoName: _searchcontroller.text,
                  obj: obj,
                )));
          } else {
            showDialog(
                context: context,
                builder: (context) => CustomDialogError(
                    "Error", "Restaurant not available", "Cancel"));
          }
        },
        child: Container(
          width: 25,
          height: 25,
          child: SvgPicture.asset(
            arrow,
            color: Colors.white,
          ),
        ),
      ),
      body: _isdata
          ? Center(child: CircularProgressIndicator())
          : restaurant(), /*Column(
        children: [
          Container(
            width: 400.0,
            height: 300.0,
            child: Image.asset('assets/images/mapp.jpg'),
          ),
        ],
      ),*/ //_isdata ? Center(child: CircularProgressIndicator()) : restaurant(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:postmaster/Screens/Createorder.dart';
//import 'package:postmaster/Screens/Homepage.dart';
import 'package:postmaster/Screens/Login.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/Profile.dart';
import 'package:postmaster/Screens/New_Orders.dart';
import 'package:postmaster/Screens/Chat.dart';
import 'package:sizer/sizer.dart';
import 'package:postmaster/Screens/Info.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class FavoriteStore extends StatefulWidget {
  @override
  _FavoriteStoreState createState() => _FavoriteStoreState();
}

class _FavoriteStoreState extends State<FavoriteStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
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
    );
  }
}

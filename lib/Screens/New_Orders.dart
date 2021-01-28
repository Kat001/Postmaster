import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Neworder extends StatefulWidget {
  @override
  _NeworderState createState() => _NeworderState();
}

class _NeworderState extends State<Neworder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Container(
            margin: EdgeInsets.only(top: 15.0.h, left: 8.0.w, right: 8.0.w),
            width: 120.0.w,
            height: 13.0.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFF0F0F0),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ),
                ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0.h, left: 8.0.w, right: 8.0.w),
            width: 120.0.w,
            height: 13.0.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFF0F0F0),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ),
                ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0.h, left: 8.0.w, right: 8.0.w),
            width: 120.0.w,
            height: 13.0.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFF0F0F0),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ),
                ]),
          ),
        ]));
  }
}

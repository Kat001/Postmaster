import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Screens/NewOrderrest.dart';
import 'package:postmaster/Screens/Profile.dart';
import 'package:postmaster/Screens/payment.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment {
  Razorpay _razorpay;
}

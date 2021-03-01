import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';
import 'package:postmaster/Components/sizes_helpers.dart';
import 'package:postmaster/Components/customicons.dart';
import 'package:postmaster/Screens/payment.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class Topup extends StatefulWidget {
  @override
  _TopupState createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  Razorpay _razorpay;

  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_eAO1C3UKqngmHc',
      'amount': double.parse(_amountController.text) * 100,
      'name': 'Postmaster',
      'description': 'Postmaster',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: displayHeight(context) * 0.02,
                  left: displayWidth(context) * 0.05),
              child: Text(
                "Enter the topup amount",
                style: TextStyle(
                    fontFamily: "RobotoBold",
                    fontSize: displayWidth(context) * 0.07,
                    color: Color(0xFF465A64)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: displayHeight(context) * 0.03,
                left: displayWidth(context) * 0.05,
                right: displayWidth(context) * 0.04,
              ),
              child: Text(
                ''' Enter the amount of funds you would like to \n add to your account balance''',
                style: TextStyle(
                    fontFamily: "RobotoBold",
                    fontSize: displayWidth(context) * 0.035,
                    color: Color(0xFF465A64)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: displayHeight(context) * 0.05,
                left: displayWidth(context) * 0.05,
                right: displayWidth(context) * 0.04,
              ),
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter amount',
                    prefix: Container(
                      width: 12,
                      height: 12,
                      child: SvgPicture.asset(
                        rupee,
                        color: Color(0xFF465A64),
                      ),
                    )),
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF2BCDB4),
          onPressed: () {
            openCheckout();
            // Navigator.push(context, SlideLeftRoute(page: ()));
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
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }
}

import 'package:flutter/material.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';

class faqs extends StatefulWidget {
  @override
  _faqsState createState() => _faqsState();
}

class _faqsState extends State<faqs> {
  Widget questionText(String text) {
    return Text(
      text,
      style: TextStyle(fontFamily: "RobotoBold", fontSize: 15.0),
    );
  }

  Widget answerText(String text) {
    return Text(
      text,
      style: TextStyle(fontFamily: "Roboto", fontSize: 15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "FAQ",
            style: TextStyle(
                fontFamily: "RobotoBold",
                fontSize: 20.0,
                color: Color(0xFF2AD0B5)),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, SlideRightRoute(page: Dashboard()));
            },
            icon: Icon(Icons.arrow_back_ios),
          )),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    "1. Do I need to place a minimum number of orders per month?"),
                answerText(
                    '''No. There is no minimum. You can just make one order a year!'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText('''2. How can I book a delivery'''),
                answerText(
                    '''There are three ways: using the online form on our website or by android and ios application.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText('''3. How early should I book a courier?'''),
                answerText(
                    '''You only need to book 30 minutes in advance if the first delivery is within travel zone 1, one hour in advance if in travel zone 2 and 1.5–2 hours if further out of.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''4. How do I know that the courier is from Postmaster and not from somewhere else?'''),
                answerText(
                    '''The courier will ask you to sign in the app on his/her smartphone. In addition, the courier will contact you before arriving at the address so you will be able to identify him/her.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''5. I have a very urgent order. Can I specify a 30 minute interval between two deliveries?'''),
                answerText(
                    '''Yes, as long as this time is sufficient for the courier to get from one address to the other.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''6. What do I do if I want to send several items to the recipient to choose from?'''),
                answerText(
                    '''On the form, add your collection point separately as a return address.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''7. Will you definitely find a courier to deliver my order?'''),
                answerText(
                    '''We can always find a courier, the only issue is time. For example, it can sometimes take up to an hour to find a courier if you book a courier on Friday, which is the busiest day of the week.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''8. Why hasn't anyone been assigned to my order yet?'''),
                answerText(
                    '''Our system works on the basis of responses. So far, no couriers have responded to your order. Depending on the day and the route, it can take from one minute to an hour to find a courier.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''9. How do I know if the courier has delivered the parcel?'''),
                answerText(
                    '''You will receive a text message or email. The recipient will also receive a text message notifying them that the courier is coming (unless the delivery is a surprise).'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText('''10. Do you pack the goods?'''),
                answerText(
                    '''No, the courier will deliver the goods in the same packaging they were collected in.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''11. Do you have a warehouse? Do you have any collection points?'''),
                answerText(
                    '''As we specialise in urgent deliveries, we don't have our own warehouse or collection points; our couriers can collect the goods from you or from your suppliers and deliver directly to the customer.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''12. If my goods are heavy (15 to 100 kg), will the courier deliver to the door if the address is not on the ground floor?'''),
                answerText(
                    '''It's up to you. We can assign couriers who deal with heavy goods.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''13. Should the courier phone the customer before delivering or is it the shop's responsibility?'''),
                answerText(
                    '''The courier will phone the contact person at each delivery point before setting off to confirm the address and notify the customer of the delivery time.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''14. Can I save money and bring the goods to your office so that I only have to pay for delivery?'''),
                answerText('''No, our office is not a warehouse.'''),
                SizedBox(
                  height: 10.0,
                ),
                questionText(
                    '''15. Is it possible to track the location of the courier online?'''),
                answerText(
                    '''Yes, you can track your courier's location on a map in your online account. Location is updated every 15 minutes.'''),
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Privacy Policy",
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
            )),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(children: <Widget>[
              Text(
                '''\nThis privacy policy has been compiled to better serve those who are concerned with how their ‘Personally Identifiable Information’ (PII) is being used online. The information that can be used on its own or with other information to identify, contact, or locate a single person, or to identify an individual in context. Please read our privacy policy carefully to get a clear understanding of how we collect, use, protect or otherwise handle your Personally Identifiable Information in accordance with our website.\n
What personal information do we collect from the people that visit our website or app? When ordering or registering on our site, as appropriate, you may be asked to enter your name, email address, phone number, credit/debit card information or other details to help you with your experience. 
When do we collect information? We collect information from you when you register on our Website/Application, place an order, subscribe to a newsletter or provide us with feedback on our products or services. 
How do we use your information? We may use the information we collect from you when you register, make a purchase, sign up for our newsletter, respond to a survey or marketing communication, surf the website/application, or use certain other site features in the following ways:
• To personalize your experience and to allow us to deliver the type of content and product offerings in which you are most interested. • To improve our website/application in order to better serve you. • To allow us to better service you in responding to your customer service requests. • To quickly process your transactions. • To ask for ratings and reviews of services or products. 
How do we protect your information? We use regular Malware Scanning. Your personal information is contained behind secured networks and is only accessible by a limited number of persons who have special access rights to such systems admins, and are required to keep the information confidential. In addition, all sensitive/credit information you supply is encrypted via Secure Socket Layer (SSL) technology. We implement a variety of security measures when a user enters, submits, or accesses their information to maintain the safety of your personal information. All transactions are processed through a gateway provider and are not stored or processed on our servers. 
Do we use ‘cookies’? Yes. You have the right to choose whether or not to accept cookies. However, they are an important part of how our Services work, so you should be aware that if you choose to refuse or remove cookies, this could affect the availability and functionality of the Services.  Most web browsers are set to accept cookies by default. If you prefer, you can usually choose to set your browser to remove or reject browser cookies. To do so, please follow the instructions provided by your browser which are usually located within the "Help" or “Preferences” menu. Some third parties also provide the ability to refuse their cookies directly by clicking on an opt-out link, and we have indicated where this is possible in the table above.  Removing or rejecting browser cookies does not necessarily affect third-party flash cookies which may be used by us or our partners in connection with our Services. To delete or disable flash cookies please visit this site for more information.  Third-party disclosure. We do not sell, trade, or otherwise transfer to outside parties your Personally Identifiable Information unless we provide users with advance notice. This does not include website hosting partners and other parties who assist us in operating our website/application, conducting our business, or serving our users, so long as those parties agree to keep this information confidential. We may also release information when it’s release is appropriate to comply with the law, enforce our site policies, or protect ours or others’ rights, property or safety. 
However, non-personally identifiable visitor information may be provided to other parties for marketing, advertising, or other uses.
Third-party links. Occasionally, at our discretion, we may include or offer third-party products or services on our website. These third-party sites have separate and independent privacy policies. We therefore have no responsibility or liability for the content and activities of these linked sites. Nonetheless, we seek to protect the integrity of our site and welcome any feedback about these sites.''',
                style: TextStyle(fontFamily: "Roboto", fontSize: 15.0),
              ),
            ]),
          ),
        ));
  }
}

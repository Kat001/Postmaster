import 'package:flutter/material.dart';
import 'package:postmaster/Components/animate.dart';
import 'package:postmaster/Screens/BottomAppbar.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Terms & Conditions",
              style: TextStyle(
                  fontFamily: "RobotoBold",
                  fontSize: 20.0,
                  color: Color(0xFF2AD0B5)),
            ),
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
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Text(
              '''Welcome to Postmaster India Private Limited. The following are the rules or "Terms" that govern use of the Postmaster India Private Limited website/application. By using or visiting the Site, you expressly agree to be bound by these Terms and to follow these Terms and all applicable laws and regulations governing the site.  Permitted Use You agree that you are only authorized to visit, view and to retain a copy of pages of this Site for your own personal use, and that you shall not duplicate, download, publish, modify or otherwise distribute the material on this Site for any purpose other than to review event and promotional information, for personal use, unless otherwise specifically authorized by Postmaster India Private Limited to do so. You also agree not to deep-link to the site for any purpose, unless specifically authorized by Postmaster India Private Limited to do so. The content and software on this Site is the property of Postmaster India Private Limited and/or its suppliers and is protected by India and international copyright laws.  Disclaimers Postmaster India Private Limited does not promise that the Site will be error-free, uninterrupted, nor that it will provide specific results from use of the Site or any Content, search or link on it. The Site and its Content are delivered on an "as-is" and "as-available" basis. Postmaster India Private Limited cannot ensure that files you download from the Site will be free of viruses or contamination or destructive features. Postmaster India Private Limited will not be liable for any damages of any kind arising from the use of this Site, including without limitation, direct, indirect, incidental, and punitive and consequential damages.  Trademarks: Postmaster India Private Limited logos as well as Postmaster India Private Limited design found on this site are registered trademarks of Postmaster India Private Limited.   Ownership of Materials: All materials on Postmaster India Private Limited’s website/application are copyrighted and are protected under treaty provisions and world-wide copyright laws. Postmaster India Private Limited's materials may not be reproduced, copied, edited, published, transmitted or uploaded in any way without Postmaster India Private Limited's written permission.  Copyright Policy: We will terminate the privileges of any user who uses this Site to unlawfully transmit copyrighted material without a license express consent, valid defense or fair use exemption to do so. In particular, users who submit Content to this Site, whether articles, images, stories, software or other copyrightable material must ensure that the Content they upload does not infringe the copyrights or other rights of third parties (such as privacy or public rights). After proper notification by the copyright holder or its agent to us, and confirmation through court order or admission by the user that they have used this Site as an instrument of unlawful infringement, we will terminate the infringing users' rights to use and/or access this Site. We may, also in our sole discretion, decide to terminate a user's rights to use or access the Site prior to that time if we believe that the alleged infringement has occurred.
 
Access & Interference: You agree that you will not use any robot, spider, other automatic device, or manual process to monitor or copy our web pages or the content contained there on or for any other unauthorized purpose without our prior express written permission. You agree that you will not use any device, software or routine to interfere or attempt to interfere with the proper working of the Postmaster India Private Limited website/application. You agree that you will not take any action that imposes an unreasonable or disproportionately large load on our infrastructure. You agree that you will not copy, reproduce, alter, modify, create derivative works, or publicly display any content (except for your own personal, non-commercial use) from our website without the prior express written permission of Postmaster India Private Limited.  Violation of the Terms: You understand and agree that in postmaster India Private Limited’s sole discretion, and without prior notice, postmaster India Private Limited may terminate your access to the Site, any other remedy available and remove any unauthorized User Content, if postmaster India Private Limited believes that the User Content you provided has violated or is inconsistent with these Terms of Use violated the rights of postmaster India Private Limited, another User or the law. You agree that monetary damages may not provide a sufficient remedy to postmaster India Private Limited for violations of these terms and conditions and you consent to injunctive or other equitable relief for such violations. postmaster India Private Limited may release user information about you if required by law or if the information is necessary or appropriate to release to address an unlawful or harmful activity.  Dispute: This site is controlled and operated by Postmaster India Private Limited from its offices in India. If there is any dispute about or involving the Site, by using the Site, you agree that the dispute will be governed and construed by Indian law. In the event of a dispute arising out of or relating to these terms and conditions, or your use of or access to this site, litigation must be brought in court in India without regard to its conflict of law provisions.  Indemnity: You agree to indemnify and hold Postmaster India Private Limited, its subsidiaries, affiliates, officers, agents and other partners and employees, harmless from any loss, liability, claim or demand, including reasonable attorneys' fees, made by any third party due to or arising out of your use of the Site, including also your use of the Site to provide a link to another site or to upload content or other information to the Site.''',
              style: TextStyle(fontFamily: "Roboto", fontSize: 15.0),
            ),
          ),
        ));
  }
}

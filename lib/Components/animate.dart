import 'package:flutter/material.dart';
import 'package:login/Screens/Homepage.dart';

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttontext;
  //final Image image;

  CustomDialog(this.title, this.description, this.buttontext);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context));
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 100.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(description, style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  // margin: new EdgeInsets.only(left: 75, right: 75, top: 40),
                  child: MaterialButton(
                    // color: Color(0xFF27DEBF),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(page: Homepage()));
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return Dashboard();
                      // }));
                    },
                    minWidth: 250.0,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0)),
                    height: 45.0,
                    child: Text(
                      "Confirm",
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
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 50.0,
            backgroundImage: AssetImage('assets/images/tick.gif'),
          ),
        )
      ],
    );
  }
}

class CustomDialogError extends StatelessWidget {
  final String title, description, buttontext;
  //final Image image;

  CustomDialogError(this.title, this.description, this.buttontext);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context));
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 100.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(description, style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  // margin: new EdgeInsets.only(left: 75, right: 75, top: 40),
                  child: MaterialButton(
                    // color: Color(0xFF27DEBF),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(page: Homepage()));
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return Dashboard();
                      // }));
                    },
                    minWidth: 250.0,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0)),
                    height: 45.0,
                    child: Text(
                      "Redo",
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
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 50.0,
            backgroundImage: AssetImage('assets/images/error.gif'),
          ),
        )
      ],
    );
  }
}

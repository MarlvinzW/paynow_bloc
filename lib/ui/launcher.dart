import 'package:flutter/material.dart';
import 'package:paynowbloc/ui/payment.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:paynowbloc/utils/constants.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: Payment(title: appTitle),
      image: Image.asset('images/logo.png'),
      photoSize: 60,
      loaderColor: Colors.white,
      backgroundColor: appColor,
      loadingText: Text('flutter Paynow example with Bloc',
          style: TextStyle(color: Colors.white)),
    );
  }
}

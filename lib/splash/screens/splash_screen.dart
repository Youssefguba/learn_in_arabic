import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/main_screen.dart';
import 'package:learn_in_arabic/on_boarding/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool start = false;
  @override
  void initState() {
    super.initState();
    final duration = Duration(seconds: 4);
    Future.delayed(duration, () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          //to move to next splash screen
          return OnBoardingPage();
        },
      ), (route) => false);
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
            height: height,
            width: width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: Image.asset('assets/logo.png')),
                SizedBox(height: 12),
                SpinKitThreeBounce(size: 25, color: Colors.white),
              ],
            ),
          ),
        ),
    );
  }
}

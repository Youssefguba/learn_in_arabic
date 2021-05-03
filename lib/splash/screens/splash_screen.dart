import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:learn_in_arabic/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _logoController;
  Animation _logoAnimation;

  @override
  void initState() {
    _initAnimationOfLogo();

    final duration = Duration(seconds: 4);
    Future.delayed(duration, () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          //to move to next splash screen
          return MainPage();
        },
      ), (route) => false);
    });
    super.initState();
  }

  _initAnimationOfLogo() {
    _logoController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _logoController.addListener(() {
      setState(() {});
    });
    _logoAnimation =
        Tween<double>(begin: -0.0, end: 1.0).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));
    _logoController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _logoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:  Colors.white,
      body: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 3),
            curve: Curves.easeIn,
            child: ScaleTransition(
              scale: _logoAnimation,
              child: Container(
                height: height * 0.25,
                width: width * 0.5,
                child:  ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}

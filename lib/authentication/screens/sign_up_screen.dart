import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_in_arabic/authentication/authentication.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  double _screenHeight, _screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: SvgPicture.asset(
                    'assets/images/undraw_login.svg',
                    height: _screenHeight * 0.25,
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Text(
                    'سجل دخولك معنا في تعلموا بالعربية',
                    style: TextStyle(fontFamily: 'Arb', fontSize: 30),
                  ),
              ),
              SizedBox(height: 20),
              Flexible(flex: 1,
                  fit: FlexFit.loose,
                  child: GoogleButton()),
            ],
          ),
        ),
      ),
    );
  }
}

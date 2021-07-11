import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  bool start = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      setState(() {
        start = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxHeight: MediaQuery.of(context).size.longestSide * 2,
      maxWidth: MediaQuery.of(context).size.longestSide * 2,
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        width: start ? MediaQuery.of(context).size.longestSide * 2 : 0,
        height: start ? MediaQuery.of(context).size.longestSide * 2 : 0,
        decoration: BoxDecoration(
            color: start ? Colors.white : Colors.black ,
            shape: BoxShape.circle
        ),
        child: RedPage(),
      ),
    );
  }
}

class RedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.grey,child: Center(child: Text("I am RedPage",style: TextStyle(color: Colors.black),)),);
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
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
        ) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: child,
      );
    },
  );
}
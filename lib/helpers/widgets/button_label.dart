import 'package:flutter/material.dart';

class ButtonLabel extends StatelessWidget {
  const ButtonLabel(
      {Key key,
      @required this.text,
      @required this.onPressed,
      @required this.color})
      : super(key: key);
  final String text;
  final Function onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      height: 50,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: color,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.bold, fontFamily: 'Arb'),
        ),
      ),
    );
  }
}

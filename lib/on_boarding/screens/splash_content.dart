import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);

  final String text, image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //title

        // Flexible(
        //   flex: 1,
        //   fit: FlexFit.tight,
        //   child: Container(
        //       padding: EdgeInsets.only(top: 10),
        //       child: Text(
        //         "تعلموا بالعربية",
        //         style: TextStyle(
        //             color: mPrimaryBlackColor, fontFamily: 'Arb', fontSize: 35, fontWeight: FontWeight.bold),
        //       ),
        //     ),
        // ),

        //image
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: SvgPicture.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.5,
            alignment: Alignment.bottomCenter,
          ),
        ),

        Spacer(),
        //body text
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            text,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(color: mPrimaryBlueColor, fontSize: 20.0, fontFamily: "Arb"),
          ),
        ),
      ],
    );
  }
}

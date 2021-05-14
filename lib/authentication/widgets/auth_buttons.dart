import 'package:flutter/material.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';

import '../authentication.dart';

class AuthButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Column(
        children: [
          FacebookButton(),
          GoogleButton(),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: ButtonLabel(
                text: 'Continue with Phone number',
                onPressed: () => AuthCycleWidget.loginBottomSheet(context),
                color: mPrimaryBlackColor),
          ),
        ],
      ),
    );
  }
}

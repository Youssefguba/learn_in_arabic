import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../authentication.dart';

class AuthCycleWidget {
  /// Auth Bottom Sheet contain Auth Buttons [ Google, Facebook, SignUp ]
  static authBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
        isDismissible: true,
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        bounce: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (BuildContext context) => Container(
          height: 350,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Login or create an account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    // TODO pop up navigator.
                    IconButton(icon: Icon(Icons.close), onPressed: () {}),
                  ],
                ),
              ),
                AuthButtons(),
              ],
            ),
        ),
        );
  }

  /// Login Bottom Sheet
  static loginBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        bounce: true,
        expand: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (BuildContext context) => LoginWidget());
  }

  /// SignUp Bottom Sheet
  static signUpBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        bounce: true,
        expand: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (BuildContext context) => SignUpWidget());
  }
}

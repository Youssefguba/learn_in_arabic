import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication.dart';
import '../../helpers/helpers.dart';

class FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(10),
        // onPressed: () => context.read<LoginCubit>().signInWithFacebook(),
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: mFacebookButtonColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/icons-facebook.png',
                height: 30, width: 30),
            SizedBox(width: width * 0.05),
            Text(
              'Continue with Facebook',
              style: TextStyle(color: Colors.white, fontSize: 19.0),
            ),
          ],
        ),
      ),
    );
  }
}

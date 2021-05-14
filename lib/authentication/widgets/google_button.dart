import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';

import '../authentication.dart';

class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state.status == FormzStatus.submissionFailure) {
          Fluttertoast.showToast(msg: 'لا يمكنك التسجيل دخول الآن حاول مرة أخرى!');
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: width * 0.80,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: mSecondaryColor,
          ),
          child: GestureDetector(
            onTap: () => context.read<LoginCubit>().logInWithGoogle(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/icons-google.png', height: 30, width: 30),
                SizedBox(width: width * 0.05),
                Text('تسجيل دخول بواسطة جوجل', style: TextStyle(color: Colors.black, fontSize: 19.0, fontFamily: 'Arb'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

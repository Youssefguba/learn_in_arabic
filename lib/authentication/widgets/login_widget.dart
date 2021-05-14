import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:quiver/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication.dart';

enum LoginCycle { MobileNumberStep, OTPStep }

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  LoginCycle _loginCycle;
  String _phoneNumber;

  int _otpStartTime = 59;
  int _otpCurrentTime = 59;
  StreamSubscription<CountdownTimer> _otpTimerSubscription;

  void _startOTPTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _otpStartTime),
      new Duration(seconds: 1),
    );

    _otpTimerSubscription = countDownTimer.listen(null);
    _otpTimerSubscription.onData((duration) {
      setState(() {
        _otpCurrentTime = _otpStartTime - duration.elapsed.inSeconds;
      });
    });

    _otpTimerSubscription.onDone(() {
      _otpTimerSubscription.cancel();
    });
  }


  @override
  void dispose() {
    super.dispose();
    _otpTimerSubscription.cancel();
  }

  // Check if form is valid before perform login.
  bool _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.9,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 18),
      padding: EdgeInsets.symmetric(vertical: 18),
      child: _renderStepsWidget(),
    );
  }

  /// Render Step Widgets due to case [ Mobile Number Step, OTP Step, Password Step ]
  Widget _renderStepsWidget() {
    switch (_loginCycle) {
      case LoginCycle.OTPStep:
        return _otpStepWidget(context);
        break;

      case LoginCycle.MobileNumberStep:
        return _mobileNumberStepWidget(context);
        break;

      default:
        return _mobileNumberStepWidget(context);
    }
  }

  /// OTP Step Widget
  Widget _otpStepWidget(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .78,
      width: double.infinity,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.topLeft,
              child: Text(
                'We have sent your 6-digit code to',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.topLeft,
              child: Text(
                '$_phoneNumber',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              )),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    controller: _otpController,
                    cursorColor: mPrimaryBlackColor,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isEmpty ? 'OTP Code can\'t be empty' : null,
                    decoration: InputDecoration(
                        labelText: "Enter Code",
                        labelStyle: TextStyle(color: Colors.grey),
                        fillColor: mPrimaryBlackColor,
                        focusColor: mPrimaryBlackColor,
                        hoverColor: mPrimaryBlackColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text('00:${_otpCurrentTime.toString()}',
                          style: TextStyle(color: mPrimaryBlackColor)),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          // Check if Timer is Finished or not.
                          if (_otpCurrentTime > 0) {
                            return;
                          } else {
                            context.read<LoginCubit>().logInWithPhoneNumber(
                                countryCode + _mobileNumberController.text);
                            setState(() {
                              _otpCurrentTime = 59;
                            });
                            _startOTPTimer();
                          }
                        },
                        child: Text(
                          'Resend OTP Code',
                          style: TextStyle(
                              color: _otpCurrentTime > 0
                                  ? mGreyColor
                                  : mPrimaryBlackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: ButtonLabel(
                text: 'Verify',
                color: _otpController.text.isEmpty
                    ? Colors.grey
                    : mPrimaryBlackColor,
                onPressed: () async {
                    if (_validateForm()) {
                      /// Verify SMS Code.
                      final result = await context
                          .read<LoginCubit>()
                          .verifySmsCode(_otpController.text);

                      if (result == null) {
                        Fluttertoast.showToast(
                            msg: 'OTP number is invalid, please try again.',
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_LONG);
                      } else {
                        return;
                      }
                    }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileNumberStepWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_rounded, color: Colors.grey),
                  // TODO pop up navigation.
                  onPressed: () {}),
              Text(
                'Continue with mobile number',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
              ),
              IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // NamedNavigatorImpl().pop();
                    // NamedNavigatorImpl().pop();
                  }),
            ],
          ),
        ),
        SizedBox(height: 10),
        Form(
          key: _formKey,
          child: Column(
            children: [
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.phoneNumber != current.phoneNumber,
                builder: (BuildContext context, state) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                      controller: _mobileNumberController,
                      cursorColor: mPrimaryBlackColor,
                      validator: (value) => value.isEmpty
                          ? 'Mobile Number can\'t be empty'
                          : null,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Mobile Number",
                          prefix: Text('+20 '),
                          labelStyle: TextStyle(color: Colors.grey),
                          fillColor: mPrimaryBlackColor,
                          focusColor: mPrimaryBlackColor,
                          hoverColor: mPrimaryBlackColor),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: ButtonLabel(
              text: 'Login',
              color: _mobileNumberController.text.isEmpty
                  ? Colors.grey
                  : mPrimaryBlackColor,
              onPressed: () {
                if (_validateForm()) {
                  context.read<LoginCubit>().logInWithPhoneNumber(
                      countryCode + _mobileNumberController.text);
                  _startOTPTimer();
                  _loginCycle = LoginCycle.OTPStep;
                }
              },
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          child: InkWell(
            onTap: () {
              AuthCycleWidget.signUpBottomSheet(context);
            },
            child: Text(
              'Create an Account',
              style: TextStyle(
                  color: mPrimaryBlackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

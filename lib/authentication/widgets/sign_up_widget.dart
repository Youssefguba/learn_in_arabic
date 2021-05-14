import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_in_arabic/helpers/helpers.dart';
import 'package:quiver/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication.dart';

enum AuthCycle { MobileNumberStep, OTPStep, SuccessfulStep }

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  AuthCycle _authCycle;
  String _phoneNumber;
  int _otpStartTime = 59;
  int _otpCurrentTime = 59;
  int _successfulStepStartTime = 5;
  int _successfulStepCurrentTime = 5;
  StreamSubscription<CountdownTimer> _otpTimerSubscription;
  StreamSubscription<CountdownTimer> _successfulStepTimerSubscription;

  @override
  void initState() {
    super.initState();
  }

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

  void _startSuccessfulStepTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _successfulStepStartTime),
      new Duration(seconds: 1),
    );

    _successfulStepTimerSubscription = countDownTimer.listen(null);
    _successfulStepTimerSubscription.onData((duration) {
      setState(() {
        _successfulStepCurrentTime =
            _successfulStepStartTime - duration.elapsed.inSeconds;
      });
    });

    _successfulStepTimerSubscription.onDone(() {
      _successfulStepTimerSubscription.cancel();
      // NamedNavigatorImpl().pop();
      // NamedNavigatorImpl().pop();
      // NamedNavigatorImpl().pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _otpTimerSubscription.cancel();
    _successfulStepTimerSubscription.cancel();
  }

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: Colors.grey),
                    // TODO pop up navigation
                    onPressed: () {}),
                Text(
                  _titleOfSheet(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15),
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
          _renderStepsWidget(),
        ],
      ),
    );
  }

  /// Render title of sheet due to case [ Mobile Number Step, OTP Step, Password Step ]
  String _titleOfSheet() {
    switch (_authCycle) {
      case AuthCycle.MobileNumberStep:
        return "Enter your mobile number to register";
        break;
      case AuthCycle.OTPStep:
        return "Enter your code";
        break;
      case AuthCycle.SuccessfulStep:
        return "";
        break;

      default:
        return "Enter your mobile number to register";
    }
  }

  /// Render Step Widgets due to case [ Mobile Number Step, OTP Step, Password Step ]
  Widget _renderStepsWidget() {
    switch (_authCycle) {
      case AuthCycle.OTPStep:
        return _otpStepWidget(context);
        break;

      case AuthCycle.SuccessfulStep:
        return _successfulStepWidget(context);
        break;

      case AuthCycle.MobileNumberStep:
        return _mobileNumberStepWidget(context);
        break;

      default:
        return _mobileNumberStepWidget(context);
    }
  }

  /// Mobile Number Step Widget
  Widget _mobileNumberStepWidget(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (BuildContext context, state) {
        return Container(
          height: height * .78,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: TextFormField(
                        controller: _usernameController,
                        cursorColor: mPrimaryBlackColor,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            value.isEmpty ? 'Name can\'t be empty' : null,
                        decoration: InputDecoration(
                            labelText: "Full Name",
                            labelStyle: TextStyle(color: Colors.grey),
                            fillColor: mPrimaryBlackColor,
                            focusColor: mPrimaryBlackColor,
                            hoverColor: mPrimaryBlackColor),
                      ),
                    ),

                    // Phone Number
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: TextFormField(
                        controller: _mobileNumberController,
                        cursorColor: mPrimaryBlackColor,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        validator: (value) => value.isEmpty
                            ? 'Mobile Number can\'t be empty'
                            : null,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            prefix: Text(countryCode),
                            labelStyle: TextStyle(color: Colors.grey),
                            fillColor: mPrimaryBlackColor,
                            focusColor: mPrimaryBlackColor,
                            hoverColor: mPrimaryBlackColor),
                      ),
                    ),

                    // Email
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: TextFormField(
                        controller: _emailController,
                        cursorColor: mPrimaryBlackColor,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value.isEmpty
                            ? 'Email Address can\'t be empty'
                            : null,
                        decoration: InputDecoration(
                            labelText: "Email Address",
                            labelStyle: TextStyle(color: Colors.grey),
                            fillColor: mPrimaryBlackColor,
                            focusColor: mPrimaryBlackColor,
                            hoverColor: mPrimaryBlackColor),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: ButtonLabel(
                    text: 'Continue',
                    color: _mobileNumberController.text.isEmpty
                        ? Colors.grey
                        : mPrimaryBlackColor,
                    onPressed: () {
                      setState(() {
                        if (_validateForm()) {
                          _phoneNumber = _mobileNumberController.text;
                          context.read<LoginCubit>().logInWithPhoneNumber(
                              countryCode + _mobileNumberController.text);
                          _startOTPTimer();
                          _authCycle = AuthCycle.OTPStep;
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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

                    /// Add User To Firestore
                    context.read<LoginCubit>().addUserToFirestore(
                        username: _usernameController.text,
                        phoneNumber: _mobileNumberController.text,
                        email: _emailController.text);

                    setState(() {
                      // Start Timer
                      _startSuccessfulStepTimer();

                      // Switch to Last step.
                      _authCycle = AuthCycle.SuccessfulStep;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Successful Step Widget
  Widget _successfulStepWidget(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .78,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/check_icon.png',
                height: height * 0.2,
              )),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            child: RichText(
              textAlign: TextAlign.center,
              textScaleFactor: 1.1,
              strutStyle: StrutStyle(
                height: 1.6,
              ),
              text: TextSpan(
                style: TextStyle(
                    color: mGreyColor,
                    letterSpacing: 1,
                    wordSpacing: 0.5,
                    fontWeight: FontWeight.w400),
                children: [
                  TextSpan(text: 'You Have Successfully Created Your Account.'),
                  TextSpan(
                      text:
                          ' You will redirect after $_successfulStepCurrentTime seconds automatically to Barber Profile to proceed your Booking.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

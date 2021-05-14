import 'package:authentication_repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:learn_in_arabic/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppView(authenticationRepository: AuthenticationRepository()));
}


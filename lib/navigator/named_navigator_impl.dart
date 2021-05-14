import 'package:flutter/material.dart';
import 'package:learn_in_arabic/authentication/authentication.dart';
import 'package:learn_in_arabic/main_screen.dart';
import 'package:learn_in_arabic/splash/splash.dart';

import 'named_navigator.dart';

class NamedNavigatorImpl implements NamedNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      new GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.HOME:
        return MaterialPageRoute(builder: (_) => MainPage());
      case Routes.SIGN_UP:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      default:
        {
          return MaterialPageRoute(builder: (_) => MainPage());
        }
    }
  }

  @override
  void pop({dynamic result}) {
    if (navigatorState.currentState.canPop()) {
      navigatorState.currentState.pop(result);
    } else {
      print("not allowed");
    }
  }

  @override
  Future push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      print('Route >>> $routeName');
      return navigatorState.currentState.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      print('Route >>> $routeName');
      return navigatorState.currentState
          .pushReplacementNamed(routeName, arguments: arguments);
    } else {
      print('Route >>> $routeName');
      return navigatorState.currentState
          .pushNamed(routeName, arguments: arguments);
    }
  }
}

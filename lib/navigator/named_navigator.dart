class Routes {
  static const INTRO = "INTRO";
  static const SIGN_UP = "SIGN_UP";
  static const LOGIN = "LOGIN";
  static const RESET_PASSWORD = "RESET_PASSWORD";
  static const HOME = "HOME";
  static const SEARCH_PAGE = "SEARCH_PAGE";
  static const CONTACT_US = "CONTACT_US";
  static const ACCOUNT_INFO = "ACCOUNT_INFO";
  static const UPDATE_PROFILE = "UPDATE_PROFILE";
  static const PROFILE_PAGE = "PROFILE_PAGE";
  static const SPLASH_SCREEN = "SPLASH_SCREEN";

}

abstract class NamedNavigator {
  Future push(String routeName,
      {dynamic arguments, bool replace = false, bool clean = false});

  void pop({dynamic result});
}

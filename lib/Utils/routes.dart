import 'package:blog_app/Utils/route_names.dart';
import 'package:blog_app/screens/Upload_screen.dart';
import 'package:blog_app/screens/forgot_password.dart';
import 'package:blog_app/screens/homepage.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:blog_app/screens/main_page.dart';
import 'package:blog_app/screens/phone_screen.dart';
import 'package:blog_app/screens/sign_up.dart';
import 'package:blog_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateroutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesNames.loginscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesNames.signUpScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());

      case RoutesNames.phoneNumberScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PhoneNumberScreen());

      case RoutesNames.ForgotPasswordScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPassword());

      case RoutesNames.mainScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainScreen());

      case RoutesNames.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());

      case RoutesNames.uploadScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UploadScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Column(
              children: [
                Center(
                  child: Text('No relevant screen found'),
                )
              ],
            ),
          );
        });
    }
  }
}

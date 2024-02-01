import 'dart:async';
import 'package:blog_app/Utils/route_names.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RoutesNames.homeScreen));
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RoutesNames.mainScreen));
    }
  }
}

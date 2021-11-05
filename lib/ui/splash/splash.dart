import 'dart:async';

import 'package:esentai/constants/assets.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: Image.asset(
        Assets.appLogo,
        width: 200,
        height: 200,
      )),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // if (preferences.getBool(Preferences.is_logged_in) ?? false) {
    //   Navigator.of(context).pushReplacementNamed(Routes.home);
    // } else {
    //   Navigator.of(context).pushReplacementNamed(Routes.login);
    // }
  }
}

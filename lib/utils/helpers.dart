import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/payment/creditcard.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locale/app_localization.dart';

class Helpers {
  static Widget showErrorMessage(BuildContext context, String message) {
    if (message.isNotEmpty) {
      // Future.delayed(Duration(milliseconds: 0), () {
      //   FlushbarHelper.createError(
      //     message: message,
      //     title: AppLocalizations.of(context).translate('home_tv_error'),
      //     duration: Duration(seconds: 3),
      //   )..show(context);
      // });

      Future.delayed(Duration(milliseconds: 0), () {
        Flushbar(
          title: 'Ошибка',
          message: message,
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),
          leftBarIndicatorColor: Colors.blue[300],
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context);
      });
    }

    return SizedBox.shrink();
  }

  static Widget showInfoMessage(BuildContext context, String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        Flushbar(
          title: 'Информация',
          message: message,
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue[300],
          ),
          leftBarIndicatorColor: Colors.blue[300],
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context);
      });
    }

    return SizedBox.shrink();
  }

  static String formatHourMinute(DateTime date) {
    int dateHour = date.hour;
    int dateMinute = date.minute;

    return dateHour.toString().padLeft(2, '0') +
        ":" +
        dateMinute.toString().padLeft(2, '0');
  }

  static void setNotificationsBadge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Preferences.fcm, true);
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('no_service');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('no_permissions');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('denied');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var lastPosition = await Geolocator.getLastKnownPosition();

    return lastPosition != null
        ? lastPosition
        : await Geolocator.getCurrentPosition();
  }

  static void share() {
    Share.share(
        'Изысканные блюда и подарки от Esentai Gourmet: https://esentai-gourmet.kz');
  }

  static String getCardType(CreditCard card) {
    String typeStr = '';
    var type = detectCCType(card.cardStr!.substring(0, 3));

    if (type == CreditCardType.maestro) {
      typeStr = 'maestro';
    } else if (type == CreditCardType.visa) {
      typeStr = 'visa';
    } else if (type == CreditCardType.mastercard) {
      typeStr = 'mastercard';
    } else {
      // TODO: add all types...
      typeStr = 'unknown';
    }

    return typeStr;
  }

  static String getCardTypeStr(CreditCard card) {
    String typeStr = '';
    var type = detectCCType(card.cardStr!.substring(0, 3));

    if (type == CreditCardType.maestro) {
      typeStr = 'MAESTRO';
    } else if (type == CreditCardType.visa) {
      typeStr = 'VISA';
    } else if (type == CreditCardType.mastercard) {
      typeStr = 'Master Card';
    } else {
      // TODO: add all types...
      typeStr = '';
    }

    return typeStr;
  }

  static String prettyNum(dynamic num) {
    return NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru")
        .format(num);
  }

  static String getCardStr(CreditCard card) {
    return '**** ${card.cardStr!.substring(15)}';
  }

  static Widget getFullCard(CreditCard card) {
    return Row(
      children: [
        if (Helpers.getCardType(card) == 'visa')
          Image.asset('assets/images/visa.png', width: 30, height: 30),
        if (Helpers.getCardType(card) == 'mastercard')
          Image.asset('assets/images/mastercard.png', width: 30, height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(Helpers.getCardTypeStr(card)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            Helpers.getCardStr(card),
            style: TextStyle(color: DefaultAppTheme.grayLight),
          ),
        ),
      ],
    );
  }
}

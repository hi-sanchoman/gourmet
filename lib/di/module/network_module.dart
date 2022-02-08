import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:esentai/data/navigation_service.dart';
import 'package:esentai/data/network/constants/endpoints.dart';
import 'package:esentai/data/sharedpref/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:esentai/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();
    final getIt = GetIt.instance;

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };

    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401) {
          // go to login screen
          // getIt<NavigationService>().navigatorKey.currentState!.pushAndRemoveUntil(newRoute, (route) => false)

          pushNewScreen(getIt<NavigationService>().navigatorKey.currentContext!,
              screen: LoginScreen(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.fade);
        }

        // return error.response;
      },
    ));

    return dio;
  }
}

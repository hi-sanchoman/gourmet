import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:esentai/data/network/constants/endpoints.dart';
import 'package:esentai/data/sharedpref/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

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

    // ..interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (RequestOptions options,
    //         RequestInterceptorHandler handler) async {
    //       // getting token
    //       // var token = await sharedPrefHelper.authToken;

    //       // if (token != null) {
    //       //   options.headers.putIfAbsent('Authorization', () => token);
    //       // } else {
    //       //   print('Auth token is null');
    //       // }

    //       return handler.next(options);
    //     },
    //   ),
    // );

    return dio;
  }
}

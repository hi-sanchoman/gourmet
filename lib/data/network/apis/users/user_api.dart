import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:esentai/data/network/constants/endpoints.dart';
import 'package:esentai/data/network/dio_client.dart';
import 'package:esentai/data/network/rest_client.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/address/address_list.dart';
import 'package:esentai/models/auth/login_response.dart';
import 'package:esentai/models/auth/token_response.dart';
import 'package:esentai/models/message.dart';
import 'package:esentai/models/notification/notification_list.dart';
import 'package:esentai/models/order/order.dart';
import 'package:esentai/models/order/order_list.dart';
import 'package:esentai/models/order/order_result.dart';
import 'package:esentai/models/payment/creditcard_list.dart';
import 'package:esentai/models/post/post_list.dart';
import 'package:esentai/models/user/user.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

class UserApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  UserApi(this._dioClient, this._restClient);

  // Login
  Future<LoginResponse> login(String userId) async {
    var data = {"username": userId};

    try {
      final res = await _dioClient.post(Endpoints.login, data: data);

      return LoginResponse.fromMap(res);
    } catch (e) {
      print("user_api error:" + e.toString());
      throw e;
    }
  }

  // Activate user
  Future<LoginResponse> activateUser(String userId, String code) async {
    var data = {"phone_number": userId, "code": code};

    try {
      final res = await _dioClient.post(Endpoints.activateUser, data: data);
      return LoginResponse.fromMap(res);
    } catch (e) {
      print("user_api error:" + e.toString());
      throw e;
    }
  }

  // Register
  Future<LoginResponse> register(
      String userId, String email, String fullName, String birthday) async {
    var data = {
      "username": userId,
      "full_name": fullName,
      "email": email,
    };

    if (birthday.isNotEmpty) {
      data['birthday'] = birthday;
    }

    try {
      final res = await _dioClient.post(Endpoints.register, data: data);
      return LoginResponse.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Register device (FMC)
  // TODO ...

  // Resend SMS
  Future<LoginResponse> resendSMS(String userId) async {
    var data = {"username": userId};

    try {
      final res = await _dioClient.post(Endpoints.login, data: data);
      return LoginResponse.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Create JWT Token
  Future<TokenResponse> createJwtToken(String username, String password) async {
    var data = {"username": username, "password": password};

    try {
      final res = await _dioClient.post(Endpoints.createJwtToken, data: data);
      TokenResponse tokenRes = TokenResponse.fromMap(res);

      // TODO:
      // register device
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? fcmToken = await messaging.getToken();

      if (fcmToken != null) {
        try {
          var fcmData = {
            "registration_id": fcmToken,
            "type": Platform.isAndroid ? 'android' : 'ios',
          };

          await _dioClient.post(Endpoints.fcmDevice,
              data: fcmData,
              options: Options(
                  headers: {"Authorization": "JWT ${tokenRes.access}"}));
        } catch (e) {
          print("Ошибка регистрации девайса: $e");
        } finally {
          return tokenRes;
        }
      }

      return tokenRes;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // get profile data
  Future<User> getProfile(String token) async {
    try {
      final res = await _dioClient.get(Endpoints.userData,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return User.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // update profile data (partial)
  Future<User> updateProfile(
      String token, String username, String fullname, String email) async {
    var data = {"username": username, "full_name": fullname, "email": email};

    try {
      final res = await _dioClient.put(Endpoints.updateProfile,
          data: data,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return User.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // TODO: order_api

  // create order
  Future<OrderResult> createOrder(
      String token, Map<String, dynamic> data) async {
    try {
      final res = await _dioClient.post(Endpoints.createOrder,
          data: data,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return OrderResult.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // get orders
  Future<OrderList> getOrders(String token) async {
    try {
      final res = await _dioClient.get(Endpoints.ordersHistory,
          options: Options(headers: {"Authorization": "JWT $token"}));

      return OrderList.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get order details
  Future<Order> getOrder(String token, int id) async {
    try {
      final res = await _dioClient.get(
          Endpoints.orderDetails.toString().replaceFirst(':id', id.toString()),
          options: Options(headers: {"Authorization": "JWT $token"}));

      return Order.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get card
  Future<CardList> getCards(String token) async {
    try {
      final res = await _dioClient.post(Endpoints.getCards,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return CardList.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // add card
  Future<Message> addCard(String token) async {
    try {
      final res = await _dioClient.post(Endpoints.addCard,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return Message.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // delete card
  Future<Message> deleteCard(String token, String id) async {
    var data = {"card_id": id};

    try {
      final res = await _dioClient.post(Endpoints.deleteCard,
          data: data,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return Message.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // get address
  Future<AddressList> getAddresses(String token) async {
    try {
      final res = await _dioClient.get(Endpoints.getAddresses,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return AddressList.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // add address
  Future<Address> addAddress(String token, Map<String, Object> data) async {
    try {
      final res = await _dioClient.post(Endpoints.createAddress,
          data: data,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return Address.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // delete address
  Future<bool> deleteAddress(String token, int id) async {
    try {
      final res = await _dioClient.delete(
          Endpoints.deleteAddress.toString().replaceFirst(':id', id.toString()),
          options: Options(headers: {"Authorization": "JWT $token"}));
      return true;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // update order
  Future<Order> submitReview(String token, String review, int orderId) async {
    try {
      var data = {"review": review};

      final res = await _dioClient.put(
          Endpoints.updateOrder
              .toString()
              .replaceFirst(':id', orderId.toString()),
          data: data,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return Order.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // get notifications
  Future<NotificationList> getNotifications(String token) async {
    try {
      final res = await _dioClient.get(Endpoints.getNotifications,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return NotificationList.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // delete notification
  Future<bool> deleteNotification(String token, int id) async {
    try {
      final res = await _dioClient.delete(
          Endpoints.deleteNotification
              .toString()
              .replaceFirst(':id', id.toString()),
          options: Options(headers: {"Authorization": "JWT $token"}));
      return true;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // delete all notifications
  Future<bool> deleteAllNotifications(String token) async {
    try {
      final res = await _dioClient.post(Endpoints.clearNotifications,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return true;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}

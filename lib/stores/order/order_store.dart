import 'package:esentai/data/repository.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/auth/login_response.dart';
import 'package:esentai/models/catalog/category_list.dart';
import 'package:esentai/models/catalog/product_list.dart';
import 'package:esentai/models/order/order_result.dart';
import 'package:esentai/stores/error/error_store.dart';
import 'package:esentai/utils/dio/dio_error_util.dart';
import 'package:flutter/material.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'order_store.g.dart';

class OrderStore = _OrderStore with _$OrderStore;

abstract class _OrderStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _OrderStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------

  @observable
  bool success = false;

  @observable
  bool isLoading = false;

  @observable
  String? deliveryType;

  @observable
  String? username;

  @observable
  String? fullname;

  @observable
  String? email;

  @observable
  Address? address;

  @observable
  String? comment;

  @observable
  bool dateIsAsap = false; // 1 - deliver as soon as possible

  @observable
  DateTime? dateStart;

  @observable
  String? paymentId;

  @observable
  String? promoId;

  @observable
  double? payWithBonus;

  @observable
  int? bonusCan;

  @observable
  int? bonusMax;

  @observable
  int? bonusPay;

  @observable
  bool sendCheck = true;

  @observable
  OrderResult? response;

  @observable
  int deliveryPrice = 3000;

  @observable
  int deliveryTreshold = 999999999;

  @observable
  int freeTreshold = 999999999;

  @observable
  LatLng? deliveryPoint;

  @observable
  List<Widget>? listOfSuggestions;

  @observable
  List<String>? addressesFound;

  @observable
  bool queryMode = false;

  // actions:-------------------------------------------------------------------
  @action
  Future createOrder(Map<String, dynamic> data) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    await _repository.createOrder(token!, data).then((res) {
      // print("res from rep: $res");
      isLoading = false;
      success = true;
      response = res;
    }).catchError((e) {
      isLoading = false;
      success = false;
      response = null;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getBonuses(String loyaltyNum, List<dynamic> cartDetails) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    var data = {
      "card_code": loyaltyNum,
      "register_details": cartDetails,
    };

    print("data $data");

    await _repository.getBonuses(token!, data).then((res) {
      isLoading = false;

      // set bonuses
      bonusCan = res.bonusCan?.toInt();
      bonusMax = res.bonusMax?.toInt();
    }).catchError((e) {
      isLoading = false;
      success = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future processBonuses(int orderId, int totalSum, int sumWithDiscount,
      List<dynamic> discountDetails, List<dynamic> cartDetails) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    var data = {
      "order_id": orderId,
      "total_sum": totalSum,
      "total_sum_discount": sumWithDiscount,
      "document_discount_dtos": discountDetails,
      "document_detail_dtos": cartDetails,
    };

    print("data $data");

    await _repository.processBonuses(token!, data).then((res) {
      isLoading = false;
      // success = true;
    }).catchError((e) {
      isLoading = false;
      // success = false;
      errorStore.errorMessage = e.toString();
    });
  }
}

import 'package:esentai/data/repository.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/auth/login_response.dart';
import 'package:esentai/models/catalog/category_list.dart';
import 'package:esentai/models/catalog/product_list.dart';
import 'package:esentai/models/order/order_result.dart';
import 'package:esentai/stores/error/error_store.dart';
import 'package:esentai/utils/dio/dio_error_util.dart';
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
  bool sendCheck = true;

  @observable
  OrderResult? response;

  @observable
  int deliveryPrice = 3000;

  @observable
  int deliveryTreshold = 999999999;

  @observable
  int freeTreshold = 999999999;

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
}

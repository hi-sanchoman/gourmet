import 'package:dio/dio.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/data/sharedpref/shared_preference_helper.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/address/address_list.dart';
import 'package:esentai/models/message.dart';
import 'package:esentai/models/notification/notification_list.dart';
import 'package:esentai/models/order/order.dart';
import 'package:esentai/models/order/order_list.dart';
import 'package:esentai/models/payment/creditcard.dart';
import 'package:esentai/models/payment/creditcard_list.dart';
import 'package:esentai/models/user/user.dart';
import 'package:esentai/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository.dart';
import '../form/form_store.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling form errors
  // final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  @observable
  bool isLoggedIn = false;

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : this._repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.isLoggedIn.then((value) {
      this.isLoggedIn = value;
    });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<bool> emptyLoginResponse =
      ObservableFuture.value(false);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  bool successProfile = false;

  @observable
  bool? showBadge = false;

  @observable
  User? profile;

  @observable
  OrderList? orderList;

  @observable
  Order? currentOrder;

  @observable
  AddressList? addressList;

  @observable
  Address? currentAddress;

  @observable
  CreditCard? currentCard;

  @observable
  CardList? cardList;

  @observable
  String? paymentLink;

  @observable
  int? currentPaymentMethod;

  @observable
  bool hideNavBar = false;

  @observable
  ObservableFuture<bool> loginFuture = emptyLoginResponse;

  @observable
  NotificationList? notificationList;

  @observable
  bool isLoading = false;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String email, String password) async {
    // final future = _repository.login(email, password);
    // loginFuture = ObservableFuture(future);

    // await future.then((value) async {
    //   if (value) {
    //     _repository.saveIsLoggedIn(true);
    //     this.isLoggedIn = true;
    //     this.success = true;
    //   } else {
    //     print('failed to login');
    //   }
    // }).catchError((e) {
    //   print(e);
    //   this.errorStore.errorMessage =
    //       e.toString(); // TODO: show user-friendly errors
    //   this.isLoggedIn = false;
    //   this.success = false;
    //   throw e;
    // });
  }

  @action
  Future logout() async {
    isLoading = true;

    this.isLoggedIn = false;
    _repository.saveIsLoggedIn(false);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(Preferences.user_id, 0);
    prefs.setString(Preferences.username, '');
    prefs.setString(Preferences.email, '');
    prefs.setString(Preferences.fullname, '');
    prefs.setString(Preferences.auth_token, '');

    // this.success = true;
    this.profile = null;
    isLoading = false;
  }

  @action
  Future getProfile() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);
    // print("token: $token");

    // TODO: check for null
    if (token == null) return;

    await _repository.getProfile(token).then((res) {
      // print("isLoading before: $isLoading");
      isLoading = false;
      // print("isLoading after: $isLoading");

      if (res is User) {
        success = true;
        isLoggedIn = true;
        profile = res;
      }
    }).catchError((e) {
      isLoading = false;
      profile = null;
      isLoggedIn = false;

      // print(e.toString());
    });
  }

  @action
  Future editProfile(String userId, String fullname, String email) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    await _repository
        .updateProfile(token!, userId, fullname, email)
        .then((res) {
      isLoading = false;

      if (res is User) {
        successProfile = true;
        profile = res;
      }
    }).catchError((e) {
      isLoading = false;
      successProfile = false;

      DioError err = e as DioError;

      if (err.response != null) {
        print("login error: ${e.response!.data['email']}");

        if (err.response!.data['email'] != null) {
          errorStore.errorMessage = 'Ошибка: почта уже существует';
        } else if (err.response!.data['username'] != null) {
          errorStore.errorMessage = 'Ошибка: номер уже существует';
        } else {
          errorStore.errorMessage = 'Ошибка на сервере. Попробуйте еще раз.';
        }
      } else {
        errorStore.errorMessage = 'Ошибка на сервере. Попробуйте еще раз.';
      }

      // errorStore.errorMessage = e.toString();
      // print(e);
    });
  }

  @action
  Future getOrders() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.getOrders(token).then((res) {
      isLoading = false;

      if (res is OrderList) {
        success = true;
        orderList = res;
      }
    }).catchError((e) {
      isLoading = false;
      orderList = null;

      // print(e.toString());
    });
  }

  @action
  Future getOrderById(int id) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.getOrderById(token, id).then((res) {
      isLoading = false;

      if (res is Order) {
        success = true;
        currentOrder = res;
      }
    }).catchError((e) {
      isLoading = false;
      currentOrder = null;

      // print(e.toString());
    });
  }

  // get cards
  @action
  Future getCards() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.getCards(token).then((res) {
      isLoading = false;

      if (res is CardList) {
        success = true;
        cardList = res;
      }
    }).catchError((e) {
      isLoading = false;
      cardList = null;

      // print(e.toString());
    });
  }

  @action
  Future addCard() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.addCard(token).then((res) {
      isLoading = false;

      if (res is Message) {
        success = true;
        paymentLink = res.message;
      }
    }).catchError((e) {
      success = false;
      isLoading = false;
    });
  }

  // delete card
  @action
  Future deleteCard(String id) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.deleteCard(token, id).then((res) {
      isLoading = false;

      if (res is Message) {
        success = true;
      }
    }).catchError((e) {
      success = false;
      isLoading = false;
    });
  }

  // get addresses
  @action
  Future getAddresses() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.getAddresses(token).then((res) {
      isLoading = false;

      if (res is AddressList) {
        success = true;
        addressList = res;
      }
    }).catchError((e) {
      isLoading = false;
      addressList = null;

      // print(e.toString());
    });
  }

  // delete address
  @action
  Future deleteAddress(int id) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.deleteAddress(token, id).then((res) {
      isLoading = false;

      if (res is bool) {
        success = res;
      }
    }).catchError((e) {
      isLoading = false;
      success = false;

      // print(e.toString());
    });
  }

  @action
  Future addAddress(Map<String, String> data) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.addAddress(token, data).then((res) {
      isLoading = false;

      if (res is Address) {
        success = true;
      }
    }).catchError((e) {
      isLoading = false;
      success = false;

      // print(e.toString());
    });
  }

  // submit review
  @action
  Future submitReview(String review, int orderId) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);
    if (token == null) return;

    await _repository.submitReview(token, review, orderId).then((res) {
      isLoading = false;
      success = true;
      currentOrder = res;
    }).catchError((e) {
      isLoading = false;
      success = false;
      // print(e.toString());
    });
  }

  // get notifications
  @action
  Future getNotifications() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.getNotifications(token).then((res) {
      isLoading = false;

      if (res is NotificationList) {
        success = true;
        notificationList = res;
      } else {
        // no notifications found
        success = true;
        notificationList = NotificationList(items: []);
      }
    }).catchError((e) {
      isLoading = false;
      notificationList = null;

      // print(e.toString());
    });
  }

  // delete notification
  @action
  Future removeNotificationById(int id) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.deleteNotification(token, id).then((res) {
      isLoading = false;
      success = true;
    }).catchError((e) {
      success = false;
      isLoading = false;
    });
  }

  // delete all notifications
  @action
  Future removeAllNotifications() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    if (token == null) return;

    await _repository.deleteAllNotifications(token).then((res) {
      isLoading = false;
      success = true;
    }).catchError((e) {
      success = false;
      isLoading = false;
    });
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

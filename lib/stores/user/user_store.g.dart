// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$isLoggedInAtom = Atom(name: '_UserStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$successAtom = Atom(name: '_UserStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$successProfileAtom = Atom(name: '_UserStore.successProfile');

  @override
  bool get successProfile {
    _$successProfileAtom.reportRead();
    return super.successProfile;
  }

  @override
  set successProfile(bool value) {
    _$successProfileAtom.reportWrite(value, super.successProfile, () {
      super.successProfile = value;
    });
  }

  final _$profileAtom = Atom(name: '_UserStore.profile');

  @override
  User? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(User? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$orderListAtom = Atom(name: '_UserStore.orderList');

  @override
  OrderList? get orderList {
    _$orderListAtom.reportRead();
    return super.orderList;
  }

  @override
  set orderList(OrderList? value) {
    _$orderListAtom.reportWrite(value, super.orderList, () {
      super.orderList = value;
    });
  }

  final _$currentOrderAtom = Atom(name: '_UserStore.currentOrder');

  @override
  Order? get currentOrder {
    _$currentOrderAtom.reportRead();
    return super.currentOrder;
  }

  @override
  set currentOrder(Order? value) {
    _$currentOrderAtom.reportWrite(value, super.currentOrder, () {
      super.currentOrder = value;
    });
  }

  final _$addressListAtom = Atom(name: '_UserStore.addressList');

  @override
  AddressList? get addressList {
    _$addressListAtom.reportRead();
    return super.addressList;
  }

  @override
  set addressList(AddressList? value) {
    _$addressListAtom.reportWrite(value, super.addressList, () {
      super.addressList = value;
    });
  }

  final _$currentAddressAtom = Atom(name: '_UserStore.currentAddress');

  @override
  Address? get currentAddress {
    _$currentAddressAtom.reportRead();
    return super.currentAddress;
  }

  @override
  set currentAddress(Address? value) {
    _$currentAddressAtom.reportWrite(value, super.currentAddress, () {
      super.currentAddress = value;
    });
  }

  final _$currentCardAtom = Atom(name: '_UserStore.currentCard');

  @override
  CreditCard? get currentCard {
    _$currentCardAtom.reportRead();
    return super.currentCard;
  }

  @override
  set currentCard(CreditCard? value) {
    _$currentCardAtom.reportWrite(value, super.currentCard, () {
      super.currentCard = value;
    });
  }

  final _$cardListAtom = Atom(name: '_UserStore.cardList');

  @override
  CardList? get cardList {
    _$cardListAtom.reportRead();
    return super.cardList;
  }

  @override
  set cardList(CardList? value) {
    _$cardListAtom.reportWrite(value, super.cardList, () {
      super.cardList = value;
    });
  }

  final _$paymentLinkAtom = Atom(name: '_UserStore.paymentLink');

  @override
  String? get paymentLink {
    _$paymentLinkAtom.reportRead();
    return super.paymentLink;
  }

  @override
  set paymentLink(String? value) {
    _$paymentLinkAtom.reportWrite(value, super.paymentLink, () {
      super.paymentLink = value;
    });
  }

  final _$currentPaymentMethodAtom =
      Atom(name: '_UserStore.currentPaymentMethod');

  @override
  int? get currentPaymentMethod {
    _$currentPaymentMethodAtom.reportRead();
    return super.currentPaymentMethod;
  }

  @override
  set currentPaymentMethod(int? value) {
    _$currentPaymentMethodAtom.reportWrite(value, super.currentPaymentMethod,
        () {
      super.currentPaymentMethod = value;
    });
  }

  final _$hideNavBarAtom = Atom(name: '_UserStore.hideNavBar');

  @override
  bool get hideNavBar {
    _$hideNavBarAtom.reportRead();
    return super.hideNavBar;
  }

  @override
  set hideNavBar(bool value) {
    _$hideNavBarAtom.reportWrite(value, super.hideNavBar, () {
      super.hideNavBar = value;
    });
  }

  final _$loginFutureAtom = Atom(name: '_UserStore.loginFuture');

  @override
  ObservableFuture<bool> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<bool> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_UserStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$logoutAsyncAction = AsyncAction('_UserStore.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$getProfileAsyncAction = AsyncAction('_UserStore.getProfile');

  @override
  Future<dynamic> getProfile() {
    return _$getProfileAsyncAction.run(() => super.getProfile());
  }

  final _$editProfileAsyncAction = AsyncAction('_UserStore.editProfile');

  @override
  Future<dynamic> editProfile(String userId, String fullname, String email) {
    return _$editProfileAsyncAction
        .run(() => super.editProfile(userId, fullname, email));
  }

  final _$getOrdersAsyncAction = AsyncAction('_UserStore.getOrders');

  @override
  Future<dynamic> getOrders() {
    return _$getOrdersAsyncAction.run(() => super.getOrders());
  }

  final _$getOrderByIdAsyncAction = AsyncAction('_UserStore.getOrderById');

  @override
  Future<dynamic> getOrderById(int id) {
    return _$getOrderByIdAsyncAction.run(() => super.getOrderById(id));
  }

  final _$getCardsAsyncAction = AsyncAction('_UserStore.getCards');

  @override
  Future<dynamic> getCards() {
    return _$getCardsAsyncAction.run(() => super.getCards());
  }

  final _$addCardAsyncAction = AsyncAction('_UserStore.addCard');

  @override
  Future<dynamic> addCard() {
    return _$addCardAsyncAction.run(() => super.addCard());
  }

  final _$deleteCardAsyncAction = AsyncAction('_UserStore.deleteCard');

  @override
  Future<dynamic> deleteCard(String id) {
    return _$deleteCardAsyncAction.run(() => super.deleteCard(id));
  }

  final _$getAddressesAsyncAction = AsyncAction('_UserStore.getAddresses');

  @override
  Future<dynamic> getAddresses() {
    return _$getAddressesAsyncAction.run(() => super.getAddresses());
  }

  final _$deleteAddressAsyncAction = AsyncAction('_UserStore.deleteAddress');

  @override
  Future<dynamic> deleteAddress(int id) {
    return _$deleteAddressAsyncAction.run(() => super.deleteAddress(id));
  }

  final _$addAddressAsyncAction = AsyncAction('_UserStore.addAddress');

  @override
  Future<dynamic> addAddress(Map<String, String> data) {
    return _$addAddressAsyncAction.run(() => super.addAddress(data));
  }

  final _$submitReviewAsyncAction = AsyncAction('_UserStore.submitReview');

  @override
  Future<dynamic> submitReview(String review, int orderId) {
    return _$submitReviewAsyncAction
        .run(() => super.submitReview(review, orderId));
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
success: ${success},
successProfile: ${successProfile},
profile: ${profile},
orderList: ${orderList},
currentOrder: ${currentOrder},
addressList: ${addressList},
currentAddress: ${currentAddress},
currentCard: ${currentCard},
cardList: ${cardList},
paymentLink: ${paymentLink},
currentPaymentMethod: ${currentPaymentMethod},
hideNavBar: ${hideNavBar},
loginFuture: ${loginFuture},
isLoading: ${isLoading}
    ''';
  }
}

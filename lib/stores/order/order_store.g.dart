// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrderStore on _OrderStore, Store {
  final _$successAtom = Atom(name: '_OrderStore.success');

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

  final _$isLoadingAtom = Atom(name: '_OrderStore.isLoading');

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

  final _$deliveryTypeAtom = Atom(name: '_OrderStore.deliveryType');

  @override
  String? get deliveryType {
    _$deliveryTypeAtom.reportRead();
    return super.deliveryType;
  }

  @override
  set deliveryType(String? value) {
    _$deliveryTypeAtom.reportWrite(value, super.deliveryType, () {
      super.deliveryType = value;
    });
  }

  final _$usernameAtom = Atom(name: '_OrderStore.username');

  @override
  String? get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String? value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$fullnameAtom = Atom(name: '_OrderStore.fullname');

  @override
  String? get fullname {
    _$fullnameAtom.reportRead();
    return super.fullname;
  }

  @override
  set fullname(String? value) {
    _$fullnameAtom.reportWrite(value, super.fullname, () {
      super.fullname = value;
    });
  }

  final _$emailAtom = Atom(name: '_OrderStore.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$addressAtom = Atom(name: '_OrderStore.address');

  @override
  Address? get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(Address? value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  final _$commentAtom = Atom(name: '_OrderStore.comment');

  @override
  String? get comment {
    _$commentAtom.reportRead();
    return super.comment;
  }

  @override
  set comment(String? value) {
    _$commentAtom.reportWrite(value, super.comment, () {
      super.comment = value;
    });
  }

  final _$dateIsAsapAtom = Atom(name: '_OrderStore.dateIsAsap');

  @override
  bool get dateIsAsap {
    _$dateIsAsapAtom.reportRead();
    return super.dateIsAsap;
  }

  @override
  set dateIsAsap(bool value) {
    _$dateIsAsapAtom.reportWrite(value, super.dateIsAsap, () {
      super.dateIsAsap = value;
    });
  }

  final _$dateStartAtom = Atom(name: '_OrderStore.dateStart');

  @override
  DateTime? get dateStart {
    _$dateStartAtom.reportRead();
    return super.dateStart;
  }

  @override
  set dateStart(DateTime? value) {
    _$dateStartAtom.reportWrite(value, super.dateStart, () {
      super.dateStart = value;
    });
  }

  final _$paymentIdAtom = Atom(name: '_OrderStore.paymentId');

  @override
  String? get paymentId {
    _$paymentIdAtom.reportRead();
    return super.paymentId;
  }

  @override
  set paymentId(String? value) {
    _$paymentIdAtom.reportWrite(value, super.paymentId, () {
      super.paymentId = value;
    });
  }

  final _$promoIdAtom = Atom(name: '_OrderStore.promoId');

  @override
  String? get promoId {
    _$promoIdAtom.reportRead();
    return super.promoId;
  }

  @override
  set promoId(String? value) {
    _$promoIdAtom.reportWrite(value, super.promoId, () {
      super.promoId = value;
    });
  }

  final _$payWithBonusAtom = Atom(name: '_OrderStore.payWithBonus');

  @override
  double? get payWithBonus {
    _$payWithBonusAtom.reportRead();
    return super.payWithBonus;
  }

  @override
  set payWithBonus(double? value) {
    _$payWithBonusAtom.reportWrite(value, super.payWithBonus, () {
      super.payWithBonus = value;
    });
  }

  final _$sendCheckAtom = Atom(name: '_OrderStore.sendCheck');

  @override
  bool get sendCheck {
    _$sendCheckAtom.reportRead();
    return super.sendCheck;
  }

  @override
  set sendCheck(bool value) {
    _$sendCheckAtom.reportWrite(value, super.sendCheck, () {
      super.sendCheck = value;
    });
  }

  final _$responseAtom = Atom(name: '_OrderStore.response');

  @override
  OrderResult? get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(OrderResult? value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  final _$deliveryPriceAtom = Atom(name: '_OrderStore.deliveryPrice');

  @override
  int get deliveryPrice {
    _$deliveryPriceAtom.reportRead();
    return super.deliveryPrice;
  }

  @override
  set deliveryPrice(int value) {
    _$deliveryPriceAtom.reportWrite(value, super.deliveryPrice, () {
      super.deliveryPrice = value;
    });
  }

  final _$deliveryTresholdAtom = Atom(name: '_OrderStore.deliveryTreshold');

  @override
  int get deliveryTreshold {
    _$deliveryTresholdAtom.reportRead();
    return super.deliveryTreshold;
  }

  @override
  set deliveryTreshold(int value) {
    _$deliveryTresholdAtom.reportWrite(value, super.deliveryTreshold, () {
      super.deliveryTreshold = value;
    });
  }

  final _$freeTresholdAtom = Atom(name: '_OrderStore.freeTreshold');

  @override
  int get freeTreshold {
    _$freeTresholdAtom.reportRead();
    return super.freeTreshold;
  }

  @override
  set freeTreshold(int value) {
    _$freeTresholdAtom.reportWrite(value, super.freeTreshold, () {
      super.freeTreshold = value;
    });
  }

  final _$createOrderAsyncAction = AsyncAction('_OrderStore.createOrder');

  @override
  Future<dynamic> createOrder(Map<String, dynamic> data) {
    return _$createOrderAsyncAction.run(() => super.createOrder(data));
  }

  @override
  String toString() {
    return '''
success: ${success},
isLoading: ${isLoading},
deliveryType: ${deliveryType},
username: ${username},
fullname: ${fullname},
email: ${email},
address: ${address},
comment: ${comment},
dateIsAsap: ${dateIsAsap},
dateStart: ${dateStart},
paymentId: ${paymentId},
promoId: ${promoId},
payWithBonus: ${payWithBonus},
sendCheck: ${sendCheck},
response: ${response},
deliveryPrice: ${deliveryPrice},
deliveryTreshold: ${deliveryTreshold},
freeTreshold: ${freeTreshold}
    ''';
  }
}

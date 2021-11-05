// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GiftStore on _GiftStore, Store {
  final _$flutterCartAtom = Atom(name: '_GiftStore.flutterCart');

  @override
  FlutterCart get flutterCart {
    _$flutterCartAtom.reportRead();
    return super.flutterCart;
  }

  @override
  set flutterCart(FlutterCart value) {
    _$flutterCartAtom.reportWrite(value, super.flutterCart, () {
      super.flutterCart = value;
    });
  }

  final _$cartResponseWrapperAtom =
      Atom(name: '_GiftStore.cartResponseWrapper');

  @override
  CartResponseWrapper? get cartResponseWrapper {
    _$cartResponseWrapperAtom.reportRead();
    return super.cartResponseWrapper;
  }

  @override
  set cartResponseWrapper(CartResponseWrapper? value) {
    _$cartResponseWrapperAtom.reportWrite(value, super.cartResponseWrapper, () {
      super.cartResponseWrapper = value;
    });
  }

  final _$addToCartAsyncAction = AsyncAction('_GiftStore.addToCart');

  @override
  Future addToCart(Product _productElement, {int funcQuantity = 0}) {
    return _$addToCartAsyncAction.run(
        () => super.addToCart(_productElement, funcQuantity: funcQuantity));
  }

  final _$deleteItemFromCartAsyncAction =
      AsyncAction('_GiftStore.deleteItemFromCart');

  @override
  Future deleteItemFromCart(int index) {
    return _$deleteItemFromCartAsyncAction
        .run(() => super.deleteItemFromCart(index));
  }

  final _$decrementItemFromCartProviderAsyncAction =
      AsyncAction('_GiftStore.decrementItemFromCartProvider');

  @override
  Future decrementItemFromCartProvider(int index) {
    return _$decrementItemFromCartProviderAsyncAction
        .run(() => super.decrementItemFromCartProvider(index));
  }

  final _$incrementItemToCartProviderAsyncAction =
      AsyncAction('_GiftStore.incrementItemToCartProvider');

  @override
  Future incrementItemToCartProvider(int index) {
    return _$incrementItemToCartProviderAsyncAction
        .run(() => super.incrementItemToCartProvider(index));
  }

  final _$_GiftStoreActionController = ActionController(name: '_GiftStore');

  @override
  bool cartIsEmpty() {
    final _$actionInfo = _$_GiftStoreActionController.startAction(
        name: '_GiftStore.cartIsEmpty');
    try {
      return super.cartIsEmpty();
    } finally {
      _$_GiftStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int? findItemIndexFromCartProvider(dynamic cartId) {
    final _$actionInfo = _$_GiftStoreActionController.startAction(
        name: '_GiftStore.findItemIndexFromCartProvider');
    try {
      return super.findItemIndexFromCartProvider(cartId);
    } finally {
      _$_GiftStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  CartItem? getSpecificItemFromCartProvider(dynamic id) {
    final _$actionInfo = _$_GiftStoreActionController.startAction(
        name: '_GiftStore.getSpecificItemFromCartProvider');
    try {
      return super.getSpecificItemFromCartProvider(id);
    } finally {
      _$_GiftStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  double getTotalAmount() {
    final _$actionInfo = _$_GiftStoreActionController.startAction(
        name: '_GiftStore.getTotalAmount');
    try {
      return super.getTotalAmount();
    } finally {
      _$_GiftStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<CartItem> getCartItems() {
    final _$actionInfo = _$_GiftStoreActionController.startAction(
        name: '_GiftStore.getCartItems');
    try {
      return super.getCartItems();
    } finally {
      _$_GiftStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int getTotalItemsCount() {
    final _$actionInfo = _$_GiftStoreActionController.startAction(
        name: '_GiftStore.getTotalItemsCount');
    try {
      return super.getTotalItemsCount();
    } finally {
      _$_GiftStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic printCartValue() {
    final _$actionInfo = _$_GiftStoreActionController.startAction(
        name: '_GiftStore.printCartValue');
    try {
      return super.printCartValue();
    } finally {
      _$_GiftStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteAllCartProvider() {
    final _$actionInfo = _$_GiftStoreActionController.startAction(
        name: '_GiftStore.deleteAllCartProvider');
    try {
      return super.deleteAllCartProvider();
    } finally {
      _$_GiftStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
flutterCart: ${flutterCart},
cartResponseWrapper: ${cartResponseWrapper}
    ''';
  }
}

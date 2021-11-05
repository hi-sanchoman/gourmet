// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on _CartStore, Store {
  final _$flutterCartAtom = Atom(name: '_CartStore.flutterCart');

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
      Atom(name: '_CartStore.cartResponseWrapper');

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

  final _$addToCartAsyncAction = AsyncAction('_CartStore.addToCart');

  @override
  Future addToCart(Product _productElement,
      {int funcQuantity = 0,
      Package? package = null,
      Postcard? postcard = null}) {
    return _$addToCartAsyncAction.run(() => super.addToCart(_productElement,
        funcQuantity: funcQuantity, package: package, postcard: postcard));
  }

  final _$deleteItemFromCartAsyncAction =
      AsyncAction('_CartStore.deleteItemFromCart');

  @override
  Future deleteItemFromCart(int index) {
    return _$deleteItemFromCartAsyncAction
        .run(() => super.deleteItemFromCart(index));
  }

  final _$decrementItemFromCartProviderAsyncAction =
      AsyncAction('_CartStore.decrementItemFromCartProvider');

  @override
  Future decrementItemFromCartProvider(int index) {
    return _$decrementItemFromCartProviderAsyncAction
        .run(() => super.decrementItemFromCartProvider(index));
  }

  final _$incrementItemToCartProviderAsyncAction =
      AsyncAction('_CartStore.incrementItemToCartProvider');

  @override
  Future incrementItemToCartProvider(int index) {
    return _$incrementItemToCartProviderAsyncAction
        .run(() => super.incrementItemToCartProvider(index));
  }

  final _$_CartStoreActionController = ActionController(name: '_CartStore');

  @override
  bool cartIsEmpty() {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.cartIsEmpty');
    try {
      return super.cartIsEmpty();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int? findItemIndexFromCartProvider(dynamic cartId) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.findItemIndexFromCartProvider');
    try {
      return super.findItemIndexFromCartProvider(cartId);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  CartItem? getSpecificItemFromCartProvider(dynamic id) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.getSpecificItemFromCartProvider');
    try {
      return super.getSpecificItemFromCartProvider(id);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  double getTotalAmount() {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.getTotalAmount');
    try {
      return super.getTotalAmount();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<CartItem> getCartItems() {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.getCartItems');
    try {
      return super.getCartItems();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int getTotalItemsCount() {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.getTotalItemsCount');
    try {
      return super.getTotalItemsCount();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic printCartValue() {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.printCartValue');
    try {
      return super.printCartValue();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteAllCartProvider() {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.deleteAllCartProvider');
    try {
      return super.deleteAllCartProvider();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int getGiftQuantity(int id) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.getGiftQuantity');
    try {
      return super.getGiftQuantity(id);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
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

import 'package:esentai/models/catalog/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_cart/model/cart_response_wrapper.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:mobx/mobx.dart';

part 'gift_store.g.dart';

class GiftStore = _GiftStore with _$GiftStore;

abstract class _GiftStore with Store {
  @observable
  var flutterCart = FlutterCart();

  @observable
  CartResponseWrapper? cartResponseWrapper;

  @action
  addToCart(Product _productElement, {int funcQuantity = 0}) async {
    cartResponseWrapper = flutterCart.addToCart(
        productId: _productElement.id,
        unitPrice: _productElement.price,
        productName: _productElement.name,
        quantity: funcQuantity == 0 ? 1 : funcQuantity,
        productDetailsObject: _productElement);

    // print(cartResponseWrapper);
  }

  @action
  bool cartIsEmpty() {
    return flutterCart.cartItem.length == 0;
  }

  @action
  deleteItemFromCart(int index) async {
    cartResponseWrapper = flutterCart.deleteItemFromCart(index);
    // notifyListeners();
  }

  @action
  decrementItemFromCartProvider(int index) async {
    cartResponseWrapper = flutterCart.decrementItemFromCart(index);
    // print('- item');

    // for (var item in cartResponseWrapper!.cartItemList) {
    //   print(item.toString());
    // }
  }

  @action
  incrementItemToCartProvider(int index) async {
    cartResponseWrapper = flutterCart.incrementItemToCart(index);
    // print('+ item');
  }

  @action
  int? findItemIndexFromCartProvider(cartId) {
    int? index = flutterCart.findItemIndexFromCart(cartId);
    return index;
  }

  //show already added items with their quantity on servicelistdetail screen
  @action
  CartItem? getSpecificItemFromCartProvider(id) {
    CartItem? cartItem = flutterCart.getSpecificItemFromCart(id);

    if (cartItem != null) {
      // print(
      // "Name ${cartItem.productDetails.name} Quantity ${cartItem.quantity}");
      return cartItem;
    }
    return cartItem;
  }

  @action
  double getTotalAmount() {
    return flutterCart.getTotalAmount();
  }

  @action
  List<CartItem> getCartItems() {
    return flutterCart.cartItem;
  }

  @action
  int getTotalItemsCount() {
    int total = 0;

    for (var item in flutterCart.cartItem) {
      total += item.quantity;
    }

    return total;
  }

  @action
  printCartValue() {
    flutterCart.cartItem.forEach((f) => {
          print(f.productId),
          print(f.quantity),
        });
  }

  @action
  deleteAllCartProvider() {
    flutterCart.deleteAllCart();
  }
}

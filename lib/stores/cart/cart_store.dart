import 'package:esentai/models/catalog/gift.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/gift/gift_wrapper.dart';
import 'package:esentai/models/gift/package.dart';
import 'package:esentai/models/gift/postcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_cart/model/cart_response_wrapper.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  FlutterCart flutterCart = FlutterCart();

  @observable
  CartResponseWrapper? cartResponseWrapper;

  @action
  addToCart(Product _productElement,
      {int funcQuantity = 0,
      Package? package = null,
      Postcard? postcard = null}) async {
    // put object
    dynamic itemObject;
    dynamic itemId;
    dynamic itemPrice;

    // product
    if (_productElement.itemType == 'product') {
      // print("product is_gram: ${_productElement.isGram}");

      funcQuantity = funcQuantity == 0 && _productElement.isGram == true
          ? 300
          : funcQuantity;
      itemObject = _productElement;
      itemId = _productElement.id;
      itemPrice = _productElement.isGram == true
          ? _productElement.price
          : _productElement.price;
    }
    // gift
    else {
      GiftWrapper giftWrapper = GiftWrapper(
          gift: _productElement, package: package, postcard: postcard);

      itemObject = giftWrapper;
      itemId =
          "${giftWrapper.gift.id}-${giftWrapper.package?.id}-${giftWrapper.postcard?.id}";

      itemPrice = giftWrapper.gift.price;
      if (giftWrapper.package != null)
        itemPrice = itemPrice + double.parse('${giftWrapper.package!.price}');
      if (giftWrapper.postcard != null)
        itemPrice = itemPrice + double.parse('${giftWrapper.postcard!.price}');
    }

    // print('inside cartstore: $itemPrice');
    // return;

    cartResponseWrapper = flutterCart.addToCart(
        productId: itemId,
        unitPrice: itemPrice,
        productName: _productElement.name,
        quantity: funcQuantity == 0 ? 1 : funcQuantity,
        productDetailsObject: itemObject);

    // print("what is in cart: ${cartResponseWrapper}");
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

  @action
  int getGiftQuantity(int id) {
    int count = 0;

    for (var item in getCartItems()) {
      if (item.productDetails is GiftWrapper) {
        GiftWrapper wrapper = item.productDetails as GiftWrapper;

        if (wrapper.gift.id == id) {
          count += item.quantity;
        }
      }
    }

    return count;
  }
}

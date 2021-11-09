import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/models/catalog/gift.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/gift/gift_wrapper.dart';
import 'package:esentai/models/gift/package.dart';
import 'package:esentai/models/gift/postcard.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/cart/gift_store.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItemWidgetWidget extends StatefulWidget {
  CartItemWidgetWidget({Key? key, required this.id, required this.item})
      : super(key: key);

  final int id;
  final CartItem item;

  @override
  _CartItemWidgetWidgetState createState() => _CartItemWidgetWidgetState();
}

class _CartItemWidgetWidgetState extends State<CartItemWidgetWidget> {
  CartStore? _cartStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _cartStore = Provider.of<CartStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_cartStore != null) {
        print(_cartStore!.cartResponseWrapper);
      }

      String type = widget.item.productDetails is Product ? 'product' : 'gift';

      return type == 'product' ? _buildProduct() : _buildGift();
    });
  }

  Widget _buildProduct() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        SizedBox(width: 100, height: 100, child: _buildItem()),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.item.productName}',
                          textAlign: TextAlign.left,
                          style: DefaultAppTheme.title3,
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  '${_calcSubtotal()} тг',
                                  textAlign: TextAlign.left,
                                  style: DefaultAppTheme.title2.override(
                                    fontFamily: 'Gilroy',
                                    color: DefaultAppTheme.primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                width: 125,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: _buildQuantityPicker(),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGift() {
    GiftWrapper wrapper = widget.item.productDetails as GiftWrapper;

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: double.infinity,
        height: 212,
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                            width: 100, height: 100, child: _buildItem()),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 10, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.item.productName}',
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: DefaultAppTheme.title3,
                            ),
                            // Spacer(),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${_calcSubtotal()} тг',
                                      textAlign: TextAlign.left,
                                      style: DefaultAppTheme.title2.override(
                                        fontFamily: 'Gilroy',
                                        color: DefaultAppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0F0F0),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: _buildQuantityPicker(),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (wrapper.package != null) _buildPackage(wrapper.package!),
                if (wrapper.postcard != null) _buildPostcard(wrapper.postcard!),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPackage(Package package) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            '${package.name}',
            style: TextStyle(color: DefaultAppTheme.grey3),
          )),
          Text(
            '${package.price}',
            style: TextStyle(color: DefaultAppTheme.grey3),
          ),
          Text(
            ' x ${widget.item.quantity}',
            style: TextStyle(color: DefaultAppTheme.grey3),
          ),
        ],
      ),
    );
  }

  Widget _buildPostcard(Postcard postcard) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${postcard.name}',
                    style: TextStyle(color: DefaultAppTheme.grey3),
                  ),
                ),
                Text(
                  '${postcard.price}',
                  style: TextStyle(color: DefaultAppTheme.grey3),
                ),
                Text(
                  'x ${widget.item.quantity}',
                  style: TextStyle(color: DefaultAppTheme.grey3),
                ),
              ],
            ),
            if (postcard.text != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${postcard.text}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: DefaultAppTheme.grayLight),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }

  Widget _buildQuantityPickerGift() {
    return Container();
  }

  int _getQuantity() {
    String type = widget.item.productDetails is Product ? 'product' : 'gift';
    String itemId = '';

    if (type == 'product') {
      return widget.item.quantity;
    }

    GiftWrapper wrapper = widget.item.productDetails as GiftWrapper;

    return _cartStore != null
        ? _cartStore!.getGiftQuantity(wrapper.gift.id!)
        : 0;
  }

  // void _onCartDecrement() {
  //   if (_cartStore == null) return;

  //   _cartStore!.decrementItemFromCartProvider(widget.item.itemCartIndex);
  //   // setState(() {});
  // }

  // void _onCartIncrement() {
  //   if (_cartStore == null) return;

  //   print("+1");

  //   _cartStore!.incrementItemToCartProvider(widget.item.itemCartIndex);
  //   // setState(() {});
  // }

  void _onCartDecrement() {
    if (_cartStore == null) return;

    String type = widget.item.productDetails is Product ? 'product' : 'gift';
    String itemId = '';

    if (type == 'product') {
      itemId = (widget.item.productDetails as Product).id.toString();
      _cartStore!.decrementItemFromCartProvider(widget.item.itemCartIndex);
    } else {
      GiftWrapper wrapper = widget.item.productDetails as GiftWrapper;
      itemId =
          "${wrapper.gift.id}-${wrapper.package?.id}-${wrapper.postcard?.id}";
      _cartStore!.decrementItemFromCartProvider(
          _cartStore!.findItemIndexFromCartProvider(itemId)!);

      // print(
      // "gift left in cart: ${_cartStore!.getGiftQuantity(wrapper.gift.id!)}");
    }
  }

  void _onCartIncrement() {
    if (_cartStore == null) return;

    String type = widget.item.productDetails is Product ? 'product' : 'gift';
    String itemId = '';

    if (type == 'product') {
      itemId = (widget.item.productDetails as Product).id.toString();
      _cartStore!.incrementItemToCartProvider(widget.item.itemCartIndex);
    } else {
      GiftWrapper wrapper = widget.item.productDetails as GiftWrapper;
      itemId =
          "${wrapper.gift.id}-${wrapper.package?.id}-${wrapper.postcard?.id}";
      _cartStore!.incrementItemToCartProvider(
          _cartStore!.findItemIndexFromCartProvider(itemId)!);

      // print(
      // "gift left in cart: ${_cartStore!.getGiftQuantity(wrapper.gift.id!)}");
    }

    // print('$itemId, ${_cartStore!.findItemIndexFromCartProvider(itemId)}');
  }

  // TODO: refactor
  Widget _buildQuantityPicker() {
    String type = widget.item.productDetails is Product ? 'product' : 'gift';
    late int amount;

    if (type == 'product') {
      amount = (widget.item.productDetails as Product).amount ?? 0;
    } else {
      amount = (widget.item.productDetails as GiftWrapper).gift.amount ?? 0;
    }

    return Row(children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
        child: InkWell(
          onTap: () {
            _onCartDecrement();
          },
          child: _getQuantity() == 1
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: DefaultAppTheme.primaryColor,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                    Image.asset('assets/images/ic_trash_primary.png',
                        width: 16, height: 16, fit: BoxFit.contain),
                  ],
                )
              : Image.asset('assets/images/ic_cart_minus.png',
                  width: 32, height: 32),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: Text(
            '${widget.item.quantity}',
            textAlign: TextAlign.center,
            style: DefaultAppTheme.title2.override(
              fontFamily: 'Gilroy',
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
        child: InkWell(
          onTap: _getQuantity() >= amount
              ? null
              : () {
                  _onCartIncrement();
                },
          child: _getQuantity() >= amount
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: DefaultAppTheme.grayLight,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                    FaIcon(
                      FontAwesomeIcons.plus,
                      size: 16,
                      color: DefaultAppTheme.grayLight,
                    )
                  ],
                )
              : Image.asset('assets/images/ic_cart_plus.png',
                  width: 32, height: 32),
        ),
      ),
    ]);
  }

  Widget _buildItem() {
    late String imageUrl;

    if (widget.item.productDetails is Product) {
      imageUrl = '${(widget.item.productDetails as Product).mainImage}';
    } else if (widget.item.productDetails is GiftWrapper) {
      GiftWrapper wrapper = widget.item.productDetails as GiftWrapper;
      imageUrl = '${wrapper.gift.mainImage}';
    }

    return CachedNetworkImage(
      fadeInDuration: Duration(milliseconds: 0),
      fadeOutDuration: Duration(milliseconds: 0),
      imageUrl: "${imageUrl}",
      // placeholder: (context, url) =>
      //     CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          Image.asset('assets/images/nophoto.png', width: 100, height: 100),
      fit: BoxFit.cover,
    );
  }

  String _calcSubtotal() {
    if (widget.item.productDetails is Product) {
      return NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru")
          .format(widget.item.subTotal);
    }

    GiftWrapper wrapper = widget.item.productDetails as GiftWrapper;
    double price = wrapper.gift.price!;

    if (wrapper.package != null) price += double.parse(wrapper.package!.price!);

    if (wrapper.postcard != null)
      price += double.parse(wrapper.postcard!.price!);

    return (price * widget.item.quantity).toString();
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/constants/app_config.dart';
import 'package:esentai/models/catalog/gift.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/gift/gift_wrapper.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/cart/gift_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/gift/package_picker.dart';
import 'package:esentai/ui/login/login.dart';
import 'package:esentai/ui/product/product.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ProductCardWidget extends StatefulWidget {
  ProductCardWidget({Key? key, required this.product, this.isFav = false})
      : super(key: key);

  final Product product;
  bool isFav = false;

  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  CartStore? _cartStore;
  // late GiftStore _giftStore;
  late CatalogStore _catalogStore;
  late UserStore _userStore;

  late CartItem? _cartItem;
  late int _isInCart;

  @override
  void initState() {
    super.initState();
    // print("product is ${widget.product}");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _cartStore = Provider.of<CartStore>(context);
    _catalogStore = Provider.of<CatalogStore>(context);
    _userStore = Provider.of<UserStore>(context);
  }

  bool _checkItemisInCart() {
    if (_cartStore == null) return false;

    if (widget.product.itemType == 'product')
      return _cartStore!.getSpecificItemFromCartProvider(widget.product.id) !=
          null;

    if (widget.product.itemType == 'gift')
      return _cartStore!.getGiftQuantity(widget.product.id!) > 0;

    return false;
  }

  bool _showLeft() {
    if (widget.product.amount == null) return false;
    if (widget.product.amount! < 0) return false;

    if (widget.product.minimumGram != null) {
      return widget.product.amount! * 1000 - _getQuantity() <=
          widget.product.minimumGram! * 5;
    }

    return widget.product.amount! - _getQuantity() <=
        AppConfig.product_amount_treshold;
  }

  String _getItemLeft() {
    if (_cartStore == null) return '';

    if (widget.product.itemType == 'gift') {
      int amount = widget.product.amount ?? 0;

      return '${amount - _cartStore!.getGiftQuantity(widget.product.id!)}';
    }

    return '${widget.product.minimumGram != null && widget.product.amount != null ? widget.product.amount! * 1000 : widget.product.amount}';
  }

  double _getTotalLeft() {
    double left = double.parse(_getItemLeft());
    double quantity = _getQuantity();

    // if ()

    return left - quantity;
  }

  int _getActualPrice() {
    return widget.product.minimumGram != null && widget.product.price != null
        ? widget.product.price! ~/ (1000 / widget.product.minimumGram!)
        : widget.product.price!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_cartStore != null) {
        print(_cartStore!.cartResponseWrapper);
      }

      double price = widget.product.price ?? 0;

      return Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 167,
          height: 262,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // product image
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: InkWell(
                      onTap: () {
                        _onProductPressed();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: widget.product.mainImage != null
                            ? SizedBox(
                                width: 147,
                                height: 147,
                                child: CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 0),
                                  fadeOutDuration: Duration(milliseconds: 0),
                                  imageUrl: '${widget.product.mainImage}',
                                  // placeholder: (context, url) =>
                                  //     CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/nophoto.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset('assets/images/nophoto.png',
                                width: 147, height: 147, fit: BoxFit.cover),
                      ),
                    ),
                  ),

                  // Name
                  Expanded(
                    child: Container(
                      // color: Colors.lightBlue,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: Text(
                          '${widget.product.name}',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: DefaultAppTheme.title3,
                        ),
                      ),
                    ),
                  ),

                  // Add to cart btn
                  _buildBtn(),
                ],
              ),

              // Discount
              // TODO: discount

              if (price < 0)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: 49,
                    height: 23,
                    decoration: BoxDecoration(
                      color: DefaultAppTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 3, 4, 3),
                      child: Text(
                        '-20%',
                        textAlign: TextAlign.end,
                        style: DefaultAppTheme.title3.override(
                          fontFamily: 'Gilroy',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

              // Add to Fav
              _buildFavButton(),

              // Left quantity
              if (_showLeft())
                Align(
                  alignment: AlignmentDirectional(-1, 0.2),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 20),
                    child: Container(
                      // width: 85,
                      height: 20,
                      decoration: BoxDecoration(
                        color: DefaultAppTheme.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 2, 5, 0),
                        child: Text(
                          'Осталось: ${widget.product.minimumGram != null ? _getTotalLeft() / 1000 : _getTotalLeft().toInt()}',
                          textAlign: TextAlign.start,
                          style: DefaultAppTheme.subtitle2.override(
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBtn() {
    bool isActive = widget.product.isActive ?? false;
    double price = widget.product.price ?? 0;
    int amount = widget.product.amount ?? 0;
    bool isGram = widget.product.minimumGram != null;

    return isActive && amount > 0
        ? Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 4),
            child: _checkItemisInCart() == false
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        _addToCart();
                      },
                      child: Text(
                          '${NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru").format(_getActualPrice())} тг'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 36),
                          textStyle: DefaultAppTheme.title2.override(
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(top: 0),
                          elevation: 0,
                          primary: DefaultAppTheme.primaryColor,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0))),
                    ),
                  )
                : Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color(0xFFF0F0F0)),
                      child: _buildQuantityPicker(),
                    ),
                  ),
          )
        : TextButton(
            child: Text('Нет в наличии'),
            onPressed: null,
          );
  }

  void _addToCart() {
    if (widget.product.itemType == 'gift') {
      pushNewScreen(context,
          screen: PackagePickerScreen(gift: widget.product),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      return;
    }

    // print("${widget.product}");

    if (_cartStore != null) _cartStore!.addToCart(widget.product);
  }

  bool _isGram() {
    if (_cartStore == null) return false;

    return widget.product.isGram == true;
  }

  double _getQuantity() {
    if (_cartStore == null) return 0;

    // product
    if (widget.product.itemType == 'product') {
      var item = _cartStore!.getSpecificItemFromCartProvider(widget.product.id);
      if (item == null) return 0;

      return item.quantity * 1.0;
    }

    // gift
    return _cartStore!.getGiftQuantity(widget.product.id!) * 1.0;
  }

  void _onCartDecrement() {
    // if (widget.product.itemType == 'product') {
    if (_cartStore == null) return;

    if (widget.product.minimumGram != null) {
      // if (_getQuantity() == 300) {
      //   _cartStore!.deleteItemFromCart(
      //       _cartStore!.findItemIndexFromCartProvider(widget.product.id!)!);
      // } else {
      //   for (int i = 0; i < 100; i++) {
      //     _cartStore!.decrementItemFromCartProvider(
      //         _cartStore!.findItemIndexFromCartProvider(widget.product.id!)!);
      //   }
      // }
      for (int i = 0; i < widget.product.minimumGram!; i++) {
        _cartStore!.decrementItemFromCartProvider(
            _cartStore!.findItemIndexFromCartProvider(widget.product.id!)!);
      }
    } else {
      _cartStore!.decrementItemFromCartProvider(
          _cartStore!.findItemIndexFromCartProvider(widget.product.id!)!);
    }

    // }

    // if (widget.product.itemType == 'gift') {
    //   _giftStore.decrementItemFromCartProvider(
    //       _giftStore.findItemIndexFromCartProvider(widget.product.id!)!);
    // }
  }

  void _onCartIncrement() {
    // if (widget.product.itemType == 'product') {
    if (_cartStore == null) return;

    // print("inc product ${widget.product}");

    if (widget.product.minimumGram != null) {
      for (int i = 0; i < widget.product.minimumGram!; i++) {
        _cartStore!.incrementItemToCartProvider(
            _cartStore!.findItemIndexFromCartProvider(widget.product.id!)!);
      }
    } else {
      _cartStore!.incrementItemToCartProvider(
          _cartStore!.findItemIndexFromCartProvider(widget.product.id!)!);
    }

    // }

    // if (widget.product.itemType == 'gift') {
    //   _giftStore.incrementItemToCartProvider(
    //       _giftStore.findItemIndexFromCartProvider(widget.product.id!)!);
    // }
  }

  Widget _buildFavButton() {
    return Observer(builder: (context) {
      if (_catalogStore.productsList != null) {
        print(_catalogStore.productsList?.items?.length);
        // return Container();

        if (_catalogStore.productsList!.items == null) {
          print(_catalogStore.productsList?.items?.length);
          // return Container();
        }
      }
      if (_catalogStore.mainList != null) {
        print(_catalogStore.mainList?.items?.length);
        // return Container();
      }
      if (_catalogStore.mainGifts != null) {
        print(_catalogStore.mainGifts?.items?.length);
        // return Container();
      }
      if (_catalogStore.searchList != null) {
        print(_catalogStore.searchList?.items?.length);
        // return Container();
      }
      if (_catalogStore.otherList != null) {
        print(_catalogStore.otherList?.items?.length);
        // return Container();
      }

      // return Text('L');

      return Align(
        alignment: AlignmentDirectional(1, -1),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 20, 0),
          child: InkWell(
            onTap: () {
              _onAddToFavPressed();
            },
            child: Image.asset(
              widget.product.isLiked == true
                  // _catalogStore.productsList!.items!
                  //             .elementAt(widget.product.id!)
                  //             .isLiked ==
                  //         true
                  ? 'assets/images/add_to_fav_active.png'
                  : 'assets/images/add_to_fav.png',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    });
  }

  bool _isAllowedToIncrement() {
    if (widget.product.minimumGram != null && widget.product.amount != null) {
      return _getQuantity() >= widget.product.amount! * 1000;
    }

    return _getQuantity() >= widget.product.amount!;
  }

  Widget _buildQuantityPicker() {
    if (_cartStore == null) return Container();

    int productAmount = widget.product.amount ?? 0;

    if (widget.product.itemType == 'gift') {
      int amountLeft = (widget.product.amount ?? 0) -
          _cartStore!.getGiftQuantity(widget.product.id!);

      return amountLeft > 0
          ? ElevatedButton(
              onPressed: () {
                _addToCart();
              },
              child: Text(
                  '${NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru").format(widget.product.price?.toInt())} тг'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 36),
                  textStyle: DefaultAppTheme.title2.override(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                  ),
                  elevation: 0,
                  primary: DefaultAppTheme.primaryColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0))),
            )
          : TextButton(
              child: Text('Нет в наличии'),
              onPressed: null,
            );
    }

    return Row(children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
        child: InkWell(
          onTap: () {
            _onCartDecrement();
          },
          child: _getQuantity() == 1 ||
                  (widget.product.minimumGram != null &&
                      _getQuantity() == widget.product.minimumGram)
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
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Text(
            '${_getQuantity().toInt()}',
            textAlign: TextAlign.center,
            style: DefaultAppTheme.title2.override(
              fontFamily: 'Gilroy',
              fontSize: 16,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
        child: InkWell(
          onTap: _isAllowedToIncrement()
              ? null
              : () {
                  _onCartIncrement();
                },
          child: _isAllowedToIncrement()
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

  void _onProductPressed() {
    pushNewScreen(context,
        screen: ProductScreen(product: widget.product),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  void _onAddToFavPressed() {
    print('toggle fav');

    if (!_userStore.isLoggedIn) {
      Future.delayed(Duration(milliseconds: 0), () {
        // Navigator.of(context).pushReplacementNamed(Routes.login);
        pushNewScreen(context,
            screen: LoginScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);
      });
      return;
    }

    _catalogStore.toggleFav(widget.product.id!, widget.product.itemType!);
    setState(() {
      // widget.product.isLiked = !widget.product.isLiked!;
    });
  }
}

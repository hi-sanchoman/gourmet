import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/constants/app_config.dart';
import 'package:esentai/models/catalog/gift.dart';
import 'package:esentai/models/catalog/gift_product.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/catalog/product_card_widget.dart';
import 'package:esentai/ui/gift/gift_builder.dart';
import 'package:esentai/ui/gift/package_picker.dart';
import 'package:esentai/ui/login/login.dart';
import 'package:esentai/ui/orders/order_prepare.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _FoodScreenWidgetState createState() => _FoodScreenWidgetState();
}

class _FoodScreenWidgetState extends State<ProductScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late CartStore _cartStore;
  late CatalogStore _catalogStore;
  late UserStore _userStore;

  late CartItem? _cartItem;
  late int _isInCart;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _cartStore = Provider.of<CartStore>(context);
    _catalogStore = Provider.of<CatalogStore>(context);
    _userStore = Provider.of<UserStore>(context);

    print('product ${widget.product.amount}');

    if (!_catalogStore.isLoading) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // elevation: 1,
        backgroundColor: DefaultAppTheme.primaryColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Helpers.share();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Icon(Icons.share_outlined, size: 25, color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFCFCFC),
      body: Observer(builder: (context) {
        return Stack(children: [
          RefreshIndicator(
            onRefresh: () async {
              _loadData();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Stack(
                  children: [
                    // Image.asset(
                    //   'assets/images/product_big.png',
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 330,
                    //   fit: BoxFit.cover,
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        imageUrl: '${widget.product.mainImage}',
                        // placeholder: (context, url) =>
                        //     CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                            'assets/images/nophoto.png',
                            width: MediaQuery.of(context).size.width,
                            height: 330,
                            fit: BoxFit.cover),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                          //   child: InkWell(
                          //     onTap: () async {
                          //       Navigator.pop(context);
                          //     },
                          //     child: Icon(
                          //       Icons.arrow_back_ios,
                          //       color: DefaultAppTheme.primaryColor,
                          //       size: 35,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),

                    _buildFavBtn(),
                  ],
                ),
                Container(
                  width: double.infinity,
                  // height: 720,
                  decoration: BoxDecoration(
                    color: DefaultAppTheme.background,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Observer(builder: (context) {
                    print(_cartStore.cartResponseWrapper);

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.product.amount != null &&
                            widget.product.amount! - _getQuantity() <=
                                AppConfig.product_amount_treshold &&
                            widget.product.amount! > 0)
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                            child: Text(
                              'Осталось: ${_getItemLeft()}',
                              style: DefaultAppTheme.bodyText1.override(
                                fontFamily: 'Gilroy',
                                color: DefaultAppTheme.secondaryColor,
                              ),
                            ),
                          ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Text(
                            '${widget.product.name}',
                            style: DefaultAppTheme.title1.override(
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                        if (widget.product.price != null)
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Text(
                                      '${widget.product.price} тг/шт',
                                      style: DefaultAppTheme.title1.override(
                                        fontFamily: 'Gilroy',
                                        color: DefaultAppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                _buildBtn(),
                              ],
                            ),
                          ),
                        _buildDescription(),

                        if (widget.product.itemType == 'gift')
                          _buildGiftProducts(),

                        // if (widget.product.itemType == 'gift')
                        //   _buildWrapperPicker(),

                        // others
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                          child: Text(
                            'Похожие товары',
                            style: DefaultAppTheme.title2,
                          ),
                        ),
                        _buildOthers(),

                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                        //   child: Text(
                        //     'Похожие товары',
                        //     style: DefaultAppTheme.title2.override(
                        //       fontFamily: 'Gilroy',
                        //       color: DefaultAppTheme.grayLight,
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 0),
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        //           child: Text('Other product'),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Container(
                          height: 140,
                        ),
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
          _buildCartTotal(),
        ]);
      }),
    );
  }

  Widget _buildFavBtn() {
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
              width: 36,
              height: 36,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    });
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

  String _getItemLeft() {
    if (widget.product.itemType == 'gift') {
      int amount = widget.product.amount ?? 0;

      return '${amount - _cartStore.getGiftQuantity(widget.product.id!)}';
    }

    return '${widget.product.amount}';
  }

  Widget _buildOthers() {
    return Observer(builder: (context) {
      print(_catalogStore.otherList?.items?.length);

      return _catalogStore.otherList != null
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 16.0,
                    ),
                    for (var product in _catalogStore.otherList!.items!)
                      ProductCardWidget(
                        product: product,
                      ),
                    // Text('${product.name}'),
                    Container(
                      width: 16.0,
                    ),
                  ],
                ),
              ),
            )
          : Container();
    });
  }

  Widget _buildBtn() {
    return widget.product.isActive != null &&
            widget.product.isActive! &&
            widget.product.amount != null
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Container(
              // width: 100,
              height: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color(0xFFF0F0F0)),
              child: _checkItemisInCart() == false
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.product.itemType == 'gift') {
                            int amount = widget.product.amount ?? 0;
                            if (_cartStore
                                    .getGiftQuantity(widget.product.id!) >=
                                amount) {
                              return;
                            }

                            pushNewScreen(context,
                                screen:
                                    PackagePickerScreen(gift: widget.product),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade);
                            return;
                          }

                          double price = widget.product.price ?? 0;
                          if (price > 0)
                            _cartStore.addToCart(widget.product);
                          else
                            Helpers.showInfoMessage(
                                context, 'Невозможно добавить товар в корзину');
                        },
                        child: widget.product.itemType == 'gift'
                            ? _buildGiftBtn()
                            : Text(
                                '${NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru").format(widget.product.price?.toInt())} тг'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 36),
                            textStyle: DefaultAppTheme.title2.override(
                              fontFamily: 'Gilroy',
                              color: Colors.white,
                            ),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Color(0xFFF0F0F0)),
                        child: _buildQuantityPicker(),
                      ),
                    ),
              // child: Container(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: TextButton(
              child: Text('Нет в наличии'),
              onPressed: null,
            ),
          );
    ;
  }

  Widget _buildGiftBtn() {
    int amount = widget.product.amount ?? 0;
    return _cartStore.getGiftQuantity(widget.product.id!) < amount
        ? Text('Добавить')
        : Text('Нет в наличии');
  }

  Widget _buildDescription() {
    return Observer(builder: (context) {
      return _catalogStore.currentProduct != null ||
              _catalogStore.currentGift != null
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
              child: Text(
                '${_catalogStore.currentProduct != null ? _catalogStore.currentProduct!.description : _catalogStore.currentGift!.description}',
                style: DefaultAppTheme.bodyText1.override(
                  fontFamily: 'Gilroy',
                ),
              ),
            )
          : Container();
    });
  }

  Widget _buildGiftProducts() {
    return Observer(builder: (context) {
      print(_catalogStore.currentGift);

      // for (GiftProduct product in _catalogStore.currentGift!.products!) {
      //   print("product in gift: ${product.products?.name}");
      // }

      return _catalogStore.currentGift != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Text(
                    'Содержимое набора',
                    style: DefaultAppTheme.subtitle1.override(
                      fontFamily: 'Gilroy',
                      color: DefaultAppTheme.textColor,
                    ),
                  ),
                ),
                for (GiftProduct product
                    in _catalogStore.currentGift!.products!)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Text('${product.products?.name ?? ''}'),
                  ),
              ],
            )
          : Container();
    });
  }

  Widget _buildWrapperPicker() {
    if (_checkItemisInCart()) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            Divider(),
            InkWell(
              onTap: () {
                // pushNewScreen(context,
                // screen: GiftBuilderScreen(), withNavBar: false);
              },
              child: ListTile(
                  dense: true,
                  title: Text('Упаковки и открытки'),
                  trailing: Icon(Icons.arrow_right,
                      size: 24, color: DefaultAppTheme.primaryColor)),
            ),
            Divider(),
          ],
        ),
      );
    }

    return Container();
  }

  bool _checkItemisInCart() {
    if (widget.product.itemType == 'gift') return false;

    return _cartStore.getSpecificItemFromCartProvider(widget.product.id) !=
        null;
  }

  int _getQuantity() {
    var item = _cartStore.getSpecificItemFromCartProvider(widget.product.id);
    if (item == null) return 0;

    print("count: ${item.quantity}");

    return item.quantity;
  }

  void _onCartDecrement() {
    if (_cartStore == null) return;

    _cartStore!.decrementItemFromCartProvider(
        _cartStore!.findItemIndexFromCartProvider(widget.product.id!)!);
    // setState(() {});
  }

  void _onCartIncrement() {
    if (_cartStore == null) return;

    _cartStore!.incrementItemToCartProvider(
        _cartStore!.findItemIndexFromCartProvider(widget.product.id!)!);
    // setState(() {});
  }

  Widget _buildQuantityPicker() {
    return Row(children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(2, 4, 0, 0),
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
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                    ),
                    Image.asset('assets/images/ic_trash_primary.png',
                        width: 16, height: 16, fit: BoxFit.contain),
                  ],
                )
              : Image.asset('assets/images/ic_cart_minus.png',
                  width: 32, height: 32),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 4, 15, 0),
        child: SizedBox(
          width: 50,
          child: Text(
            '${_getQuantity()}',
            textAlign: TextAlign.center,
            style: DefaultAppTheme.title2.override(
              fontFamily: 'Gilroy',
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 2, 0),
        child: InkWell(
          onTap: _getQuantity() >= widget.product.amount!
              ? null
              : () {
                  _onCartIncrement();
                },
          child: _getQuantity() >= widget.product.amount!
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

  void _loadData() async {
    _catalogStore.currentProduct = null;
    _catalogStore.currentGift = null;

    if (widget.product.itemType == 'product') {
      // print("get product info");

      _catalogStore.getProduct(widget.product.id!);
      _catalogStore.getOtherProducts(widget.product.id!);
    }

    if (widget.product.itemType == 'gift') {
      // print("get gift info");

      _catalogStore.getGift(widget.product.id!);
      _catalogStore.getOtherGifts(widget.product.id!);
    }
  }

  Widget _buildCartTotal() {
    return Observer(builder: (context) {
      print(_cartStore.cartResponseWrapper);

      return Visibility(
          visible: !_cartStore.cartIsEmpty(),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 56),
              child: Container(
                height: 51,
                decoration: BoxDecoration(
                    color: DefaultAppTheme.tertiaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0))),
                child: InkWell(
                  onTap: () {
                    _onCheckout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text('Перейти к оплате: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text(
                            '${NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru").format(_cartStore.getTotalAmount())} тг',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }

  void _onCheckout() {
    pushNewScreen(context,
        screen: OrderPrepareScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

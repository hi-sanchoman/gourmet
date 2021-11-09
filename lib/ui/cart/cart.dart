import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/gift/gift_wrapper.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/ui/cart/cart_item_widget.dart';
import 'package:esentai/ui/catalog/catalog.dart';
import 'package:esentai/ui/home/home.dart';
import 'package:esentai/ui/home/navbarscreen.dart';
import 'package:esentai/ui/orders/order_prepare.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenWidgetState createState() => _CartScreenWidgetState();
}

class _CartScreenWidgetState extends State<CartScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late CartStore _cartStore;
  late final SlidableController _slidableController;

  Animation<double>? _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double>? slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool? isOpen) {
    setState(() {
      _fabColor = isOpen! ? Colors.green : Colors.blue;
    });
  }

  @override
  void initState() {
    super.initState();

    _slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _cartStore = Provider.of<CartStore>(context);
    _cartStore.printCartValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: DefaultAppTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Корзина',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: DefaultAppTheme.background,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(
          builder: (context) {
            if (_cartStore != null) {
              print(_cartStore.cartResponseWrapper);
            }

            return _cartStore.cartIsEmpty() ? _buildEmptyCart() : _buildCart();
          },
        )
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_bag.png',
            width: 160,
            height: 160,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
            child: Text(
              'Ваша карзина пуста',
              style: DefaultAppTheme.bodyText1.override(
                fontFamily: 'Gilroy',
                color: DefaultAppTheme.grayLight,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 11, 16, 0),
            child: Text(
              'Добавьте товары в Корзину чтобы увидеть выбранные товары. ',
              textAlign: TextAlign.center,
              style: DefaultAppTheme.bodyText2.override(
                fontFamily: 'Gilroy',
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(16, 90, 16, 0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       _onShop();
          //     },
          //     child: Text('Начать покупки'),
          //     style: DefaultAppTheme.buttonDefaultStyle,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildCart() {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            for (var item in _cartStore.flutterCart.cartItem)
              Slidable(
                key: Key(item.uuid),
                controller: _slidableController,
                direction: Axis.horizontal,
                dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                  onDismissed: (actionType) {
                    _onCartRemove(item);
                  },
                ),
                actionPane: _getActionPane(2)!,
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  IconSlideAction(
                    // caption: 'Delete',
                    color: DefaultAppTheme.background,
                    iconWidget: Image.asset(
                      'assets/images/ic_trash_red.png',
                    ),
                    onTap: () => _onCartRemove(item),
                  ),
                ],
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: CartItemWidgetWidget(
                    id: item.itemCartIndex,
                    item: item,
                  ),
                ),
              ),

            // for (int i = 0; i < _cartStore.getCartItems().length; i++)
            //   Padding(
            //     padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            //     child: CartItemWidgetWidget(
            //       id: 0,
            //       item: _cartStore.getCartItems()[i],
            //     ),
            //   ),

            Container(
              height: 140,
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional(0, 1),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 86),
            child: ElevatedButton(
              onPressed: () {
                // go to orders page
                _onCheckout();
              },
              child: Text(
                'Оформить заказ\n${_cartStore.getTotalItemsCount()} шт, ${NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru").format(_cartStore.getTotalAmount())} тг',
                textAlign: TextAlign.center,
              ),
              style: DefaultAppTheme.buttonDefaultStyle,
            ),
          ),
        ),

        // Observer(builder: (context) {
        //   return Visibility(
        //       visible: !_cartStore.cartIsEmpty(),
        //       child: Align(
        //         alignment: Alignment.bottomCenter,
        //         child: Padding(
        //           padding: const EdgeInsets.only(top: 56),
        //           child: Container(
        //             height: 51,
        //             decoration: BoxDecoration(
        //                 color: DefaultAppTheme.tertiaryColor,
        //                 borderRadius: BorderRadius.only(
        //                     topLeft: Radius.circular(16.0),
        //                     topRight: Radius.circular(16.0))),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Padding(
        //                   padding: EdgeInsets.only(left: 16.0),
        //                   child: Text('Перейти к оплате',
        //                       style: TextStyle(
        //                         color: Colors.white,
        //                         fontWeight: FontWeight.w600,
        //                         fontSize: 17,
        //                       )),
        //                 ),
        //                 Padding(
        //                   padding: EdgeInsets.only(right: 16.0),
        //                   child: Text('${_cartStore.getTotalAmount()} тг',
        //                       style: TextStyle(
        //                         color: Colors.white,
        //                         fontWeight: FontWeight.w600,
        //                         fontSize: 17,
        //                       )),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ));
        // }),
      ],
    );
  }

  static Widget? _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  void _onCartRemove(CartItem item) {
    if (item.productDetails is Product) {
      _cartStore.deleteItemFromCart(item.itemCartIndex);
      return;
    }

    GiftWrapper wrapper = item.productDetails as GiftWrapper;
    String itemId =
        "${wrapper.gift.id}-${wrapper.package?.id}-${wrapper.postcard?.id}";

    _cartStore
        .deleteItemFromCart(_cartStore!.findItemIndexFromCartProvider(itemId)!);
  }

  void _onShop() {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => NavBarScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _onCheckout() {
    pushNewScreen(context,
        screen: OrderPrepareScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

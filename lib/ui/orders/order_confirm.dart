import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/gift/gift_wrapper.dart';
import 'package:esentai/models/order/order_result.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/creditcard/creditcard_picker.dart';
import 'package:esentai/ui/orders/orders.dart';
import 'package:esentai/ui/orders/payment_picker.dart';
import 'package:esentai/ui/payment/pay.dart';
import 'package:esentai/ui/payment/payment_result.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/cupertino_switchstyle.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CheckoutConfirmScreen extends StatefulWidget {
  CheckoutConfirmScreen({Key? key}) : super(key: key);

  @override
  _CheckoutConfirmScreenWidgetState createState() =>
      _CheckoutConfirmScreenWidgetState();
}

class _CheckoutConfirmScreenWidgetState extends State<CheckoutConfirmScreen> {
  bool switchListTileValue = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;
  late OrderStore _orderStore;
  late CartStore _cartStore;

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String _deliveryMode = 'DEV_COURIER';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _orderStore = Provider.of<OrderStore>(context);
    _cartStore = Provider.of<CartStore>(context);

    if (_userStore.profile == null) {
      _userStore.getProfile().then((_) => {});
    } else {
      _fullnameController.text = _userStore.profile!.fullname!;
      _usernameController.text = _userStore.profile!.username!;
      _emailController.text = _userStore.profile!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFCFC),
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: DefaultAppTheme.textColor,
            size: 24,
          ),
        ),
        title: Text(
          'Оформление заказа',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFCFCFC),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(builder: (context) {
          return _buildForm();
        }),
        Observer(builder: (context) {
          return Visibility(
              visible: _orderStore.isLoading,
              child: CustomProgressIndicatorWidget());
        }),
      ],
    );
  }

  Widget _buildForm() {
    return SafeArea(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 22, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 11),
                      child: Text(
                        'Способ оплаты',
                        style: DefaultAppTheme.title2.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    _buildPaymentMethod(),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      dense: false,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 11),
                      child: Text(
                        'Дополнительно',
                        style: DefaultAppTheme.title2.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Промокод',
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                          color: DefaultAppTheme.grey3,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: DefaultAppTheme.primaryColor,
                        size: 20,
                      ),
                      dense: false,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      title: Text(
                        'Потратить бонусы',
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                          color: DefaultAppTheme.grey3,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: DefaultAppTheme.primaryColor,
                        size: 20,
                      ),
                      dense: false,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    )
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Container(
              width: double.infinity,
              height: 375,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Цена',
                          style: DefaultAppTheme.title2.override(
                            fontFamily: 'Gilroy',
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: Text(
                                'Сумма заказа:',
                                style: DefaultAppTheme.bodyText1.override(
                                  fontFamily: 'Gilroy',
                                  color: DefaultAppTheme.grey3,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '${_cartStore.getTotalAmount()} тг',
                            textAlign: TextAlign.end,
                            style: DefaultAppTheme.bodyText1.override(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                    ),
                    if (_orderStore.deliveryType == 'DEV_COURIER')
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                                child: Text(
                                  'Стоимость доставки:',
                                  style: DefaultAppTheme.bodyText1.override(
                                    fontFamily: 'Gilroy',
                                    color: DefaultAppTheme.grey3,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '1000 тг',
                              textAlign: TextAlign.end,
                              style: DefaultAppTheme.bodyText1.override(
                                fontFamily: 'Gilroy',
                              ),
                            )
                          ],
                        ),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: Text(
                                'Бонусы:',
                                style: DefaultAppTheme.bodyText1.override(
                                  fontFamily: 'Gilroy',
                                  color: DefaultAppTheme.grey3,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '0 тг',
                            textAlign: TextAlign.end,
                            style: DefaultAppTheme.bodyText1.override(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: Text(
                                'Промокод:',
                                style: DefaultAppTheme.bodyText1.override(
                                  fontFamily: 'Gilroy',
                                  color: DefaultAppTheme.grey3,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '0 тг',
                            textAlign: TextAlign.end,
                            style: DefaultAppTheme.bodyText1.override(
                              fontFamily: 'Gilroy',
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: Text(
                                'Итого:',
                                style: DefaultAppTheme.title2.override(
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '${_cartStore.getTotalAmount()} тг',
                            textAlign: TextAlign.end,
                            style: DefaultAppTheme.title2.override(
                              fontFamily: 'Gilroy',
                              color: DefaultAppTheme.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                                child: CupertinoSwitchListTile(
                                  activeColor: DefaultAppTheme.primaryColor,
                                  dense: true,
                                  onChanged: (newValue) => setState(
                                      () => switchListTileValue = newValue),
                                  title: Text('Отправить чек ОФД мне на почту'),
                                  value: switchListTileValue ??= true,
                                )),
                          )
                        ],
                      ),
                    ),
                    Observer(builder: (context) {
                      print(_orderStore.paymentId);

                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            _onConfirm();
                          },
                          style: DefaultAppTheme.buttonDefaultStyle,
                          child: _orderStore.paymentId == 1
                              ? Text('Оплатить')
                              : Text('Завершить заказ'),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    String title = 'Способ оплаты';
    Color color = DefaultAppTheme.grayLight;

    return ListTile(
      title: _buildPaymentText(),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: color,
        size: 20,
      ),
      dense: false,
      onTap: () {
        _onPickPayment();
      },
    );
  }

  Widget _buildPaymentText() {
    String title = 'Способ оплаты';

    if (_orderStore.paymentId != null) {
      // TODO: hard coded...
      Map<String, String> methods = {
        '1': 'Оплата банковской картой',
        '2': 'Банковской картой курьеру',
        '3': 'Наличными',
      };

      title = methods[_orderStore.paymentId]!;
    }

    // show card by default
    if (_userStore.currentPaymentMethod == 1) {
      if (_userStore.currentCard != null) {
        return Helpers.getFullCard(_userStore.currentCard!);
      }
    }

    return Text(
      '${title}',
      style: DefaultAppTheme.bodyText1.override(
          fontFamily: 'Gilroy',
          color: _orderStore.paymentId == null
              ? DefaultAppTheme.grayLight
              : DefaultAppTheme.textColor),
    );
  }

  void _onPickPayment() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Wrap(children: [PaymentPicker()]),
    );

    // it is card -> show card picker
    if (_userStore.currentPaymentMethod == 1) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) => Wrap(children: [CreditCardPickerWidget()]),
      );
    }
  }

  void _onConfirm() async {
    if (_orderStore.paymentId == null) {
      Helpers.showInfoMessage(context, 'Выберите способ оплаты');
      return;
    }

    _userStore.currentOrder = null;

    var orderItems = [];

    var items = _cartStore.getCartItems();

    for (var item in items) {
      print('${item.productName} - ${item.quantity}');

      String type = item.productDetails is Product ? 'product' : 'gift';

      if (type == 'product') {
        var product = item.productDetails as Product;
        orderItems.add({"product": product.id, "product_count": item.quantity});
      } else {
        GiftWrapper wrapper = item.productDetails as GiftWrapper;

        Map<String, dynamic> giftOrder = {'gift': wrapper.gift.id};

        if (wrapper.package != null) {
          giftOrder['package_order'] = [
            {'package': wrapper.package!.id, 'package_count': item.quantity}
          ];
        }

        if (wrapper.postcard != null) {
          giftOrder['postcard_order'] = [
            {
              'postcard': wrapper.postcard!.id,
              'postcard_count': item.quantity,
              'text': 'some text',
            }
          ];
        }

        orderItems
            .add({'gift_order': giftOrder, 'product_count': item.quantity});
      }
    }
    print(orderItems);
    // return;
    // print(_orderStore.address);

    var data = {
      "order_items": orderItems,
      "full_name": _orderStore.fullname,
      "email": _orderStore.email,
      "phone_number": _orderStore.username,
      "latitute": null,
      "longitude": null,
      "payment_method": _orderStore
          .paymentId, // 1 - банковская карта, 2 - курьеру картой, 3 - наличными
      "custom_address": null,
      "is_asap": _orderStore.dateIsAsap,
      "delivery_date": _orderStore.dateStart != null
          ? DateFormat('yyyy-MM-dd').format(_orderStore.dateStart!)
          : null,
      "delivery_start_time": _orderStore.dateStart != null
          ? Helpers.formatHourMinute(_orderStore.dateStart!)
          : null, // get h:m:s from dateStart
      "delivery_end_time": null,
      "bonus_payed": _orderStore.payWithBonus,
      "bonus_returned": null,
      "total_price": _cartStore.getTotalAmount(),
      "send_check": switchListTileValue,
      "comment": _orderStore.comment,
      "review": null,
      "delivery_type": _orderStore.deliveryType == 'DEV_DIY' ? 2 : 1,
      "address": _orderStore.deliveryType == 'DEV_DIY'
          ? null
          : _orderStore.address?.id, // TODO: address from current address
    };

    print('order to be created: $data');

    await _orderStore.createOrder(data);

    if (_orderStore.response == null) {
      print('error on creating order...');
      return;
    }

    // successfully created order
    print("created order: ${_orderStore.response}");

    // clear cart
    _cartStore.deleteAllCartProvider();
    _cartStore.cartResponseWrapper = null;

    print("result from order create");

    // clear all _orderStore
    _orderStore.comment = null;
    _orderStore.address = null;
    _orderStore.dateIsAsap = false;
    _orderStore.dateStart = null;
    _orderStore.deliveryType = null;
    _orderStore.payWithBonus = null;

    print("payment number for order: ${_orderStore.paymentId}");

    if (_orderStore.paymentId == "1") {
      print("payment number go to payment page");

      pushNewScreen(context,
          screen: PayScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
    } else {
      Future.delayed(Duration(milliseconds: 0), () {
        pushNewScreen(context,
            screen: PaymentResultScreen(
              message: 'success',
            ),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);
      });
    }
  }
}

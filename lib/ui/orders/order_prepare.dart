import 'dart:convert';

import 'package:esentai/data/network/constants/endpoints.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/auth/login_response.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/address/address_picker.dart';
import 'package:esentai/ui/login/login.dart';
import 'package:esentai/ui/orders/order_confirm.dart';
import 'package:esentai/ui/payment/pay.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/comment_enter_widget.dart';
import 'package:esentai/widgets/default_input_field_widget.dart';
import 'package:esentai/widgets/pick_date_widget.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPrepareScreen extends StatefulWidget {
  OrderPrepareScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenWidgetState createState() => _CheckoutScreenWidgetState();
}

class _CheckoutScreenWidgetState extends State<OrderPrepareScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;
  late OrderStore _orderStore;
  static late CartStore _cartStore;

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

    //
    if (!_userStore.isLoggedIn) {
      Future.delayed(Duration(milliseconds: 0), () {
        print("user is not logged in");
        pushNewScreen(context,
            screen: LoginScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     Routes.login, (Route<dynamic> route) => false);

        // Navigator.of(context).pushReplacementNamed(Routes.login);
      });

      return;
    }

    if (_userStore.profile == null) {
      print("profile is null");
      _userStore.getProfile().then((_) => {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      backgroundColor: Colors.white,
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
                padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                child: Text(
                  'Способ доставки',
                  style: DefaultAppTheme.title2.override(
                    fontFamily: 'Gilroy',
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 13, 16, 0),
                  child: Container(
                    height: 33,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(0xFFF5F5F5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              _onDevCourier();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: _deliveryMode == 'DEV_COURIER'
                                      ? DefaultAppTheme.primaryColor
                                      : Color(0xFFF5F5F5),
                                ),
                                child: Center(
                                    child: Text(
                                  'Курьером',
                                  style: TextStyle(
                                      color: _deliveryMode == 'DEV_COURIER'
                                          ? Colors.white
                                          : DefaultAppTheme.grayLight),
                                ))),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              _onDevDiy();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: _deliveryMode == 'DEV_DIY'
                                      ? DefaultAppTheme.primaryColor
                                      : Color(0xFFF5F5F5),
                                ),
                                child: Center(
                                    child: Text(
                                  'Самовывоз',
                                  style: TextStyle(
                                      color: _deliveryMode == 'DEV_DIY'
                                          ? Colors.white
                                          : DefaultAppTheme.grayLight),
                                ))),
                          )),
                        ],
                      ),
                    ),
                  )),
              _buildData(),
              if (_deliveryMode == 'MODE_DIY')
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 0),
                  child: Text(
                    'Адрес',
                    style: DefaultAppTheme.title2.override(
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
              if (_deliveryMode == 'MODE_DIY')
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Color(0xFFFF8F3F),
                        size: 24,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ТЦ. ESENTAI MALL, \nпроспект Аль-Фараби, 77/8',
                                style: DefaultAppTheme.bodyText1.override(
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                              Text(
                                '050040/A15E3H5, Алматы, Бостандыкский район\n-1 этаж',
                                style: DefaultAppTheme.subtitle2.override(
                                  fontFamily: 'Gilroy',
                                  color: DefaultAppTheme.grayLight,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                child: ElevatedButton(
                  child: Text('Далее'),
                  style: DefaultAppTheme.buttonDefaultStyle,
                  onPressed: () {
                    _onNextPressed();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildData() {
    return Observer(builder: (context) {
      if (_userStore.profile != null) {
        _fullnameController.text = _userStore.profile!.fullname!;
        _usernameController.text = _userStore.profile!.username!;
        _emailController.text = _userStore.profile!.email!;
      }

      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 22, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 11),
              child: Text(
                'Ваши данные',
                style: DefaultAppTheme.title2.override(
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            _buildEditFullname(),
            Divider(
              height: 1,
              thickness: 1,
            ),
            _buildEditUsername(),
            Divider(
              height: 1,
              thickness: 1,
            ),
            _buildEditEmail(),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              dense: false,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            if (_deliveryMode == 'DEV_COURIER') _buildAddress(),
            Divider(
              height: 1,
              thickness: 1,
            ),
            _buildComment(),
            Divider(
              height: 1,
              thickness: 1,
            ),
            if (_deliveryMode == 'DEV_COURIER') _buildDate(),
            Divider(
              height: 1,
              thickness: 1,
            )
          ],
        ),
      );
    });
  }

  Widget _buildEditFullname() {
    return ListTile(
      leading: FaIcon(
        FontAwesomeIcons.userAlt,
        color: DefaultAppTheme.primaryColor,
        size: 15,
      ),
      title: TextFormField(
        controller: _fullnameController,
        onChanged: (val) {
          setState(() {
            _fullnameController.text = val;
          });
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Ваше имя',
          hintStyle: DefaultAppTheme.bodyText2,
          errorStyle: TextStyle(color: DefaultAppTheme.secondaryColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          contentPadding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 12),
        ),
        style: DefaultAppTheme.bodyText1,
      ),
      dense: false,
    );
  }

  Widget _buildEditUsername() {
    return ListTile(
      leading: FaIcon(
        FontAwesomeIcons.phoneAlt,
        color: DefaultAppTheme.primaryColor,
        size: 15,
      ),
      title: TextFormField(
        controller: _usernameController,
        onChanged: (val) {
          setState(() {
            _usernameController.text = val;
          });
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Ваш телефон',
          hintStyle: DefaultAppTheme.bodyText2,
          errorStyle: TextStyle(color: DefaultAppTheme.secondaryColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          contentPadding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 12),
        ),
        style: DefaultAppTheme.bodyText1,
      ),
      dense: false,
    );
  }

  Widget _buildEditEmail() {
    return ListTile(
      leading: FaIcon(
        FontAwesomeIcons.solidEnvelope,
        color: DefaultAppTheme.primaryColor,
        size: 15,
      ),
      title: TextFormField(
        controller: _emailController,
        onChanged: (val) {
          setState(() {
            _emailController.text = val;
          });
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Ваша почта',
          hintStyle: DefaultAppTheme.bodyText2,
          errorStyle: TextStyle(color: DefaultAppTheme.secondaryColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          contentPadding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 12),
        ),
        style: DefaultAppTheme.bodyText1,
      ),
      dense: false,
    );
  }

  Widget _buildAddress() {
    return InkWell(
      onTap: () {
        _pickAddress();
      },
      child: ListTile(
        leading: FaIcon(
          FontAwesomeIcons.mapMarkerAlt,
          color: _orderStore.address == null
              ? DefaultAppTheme.grayLight
              : DefaultAppTheme.primaryColor,
          size: 15,
        ),
        title: Text(
          (_orderStore.address == null)
              ? 'Адрес доставки'
              : '${Address.getFullStr(_orderStore.address!)}',
          style: DefaultAppTheme.bodyText1.override(
            fontFamily: 'Gilroy',
            color: _orderStore.address == null
                ? DefaultAppTheme.grayLight
                : DefaultAppTheme.textColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: _orderStore.address == null
              ? DefaultAppTheme.grayLight
              : DefaultAppTheme.primaryColor,
          size: 20,
        ),
        dense: false,
      ),
    );
  }

  Widget _buildComment() {
    return InkWell(
      onTap: () {
        _enterComment();
      },
      child: ListTile(
        leading: FaIcon(
          FontAwesomeIcons.solidCommentAlt,
          color: _orderStore.comment == null
              ? DefaultAppTheme.grayLight
              : DefaultAppTheme.primaryColor,
          size: 15,
        ),
        title: Text(
          (_orderStore.comment == null)
              ? 'Комментарий для заказа'
              : '${_orderStore.comment}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: DefaultAppTheme.bodyText1.override(
            fontFamily: 'Gilroy',
            color: _orderStore.comment == null
                ? DefaultAppTheme.grayLight
                : DefaultAppTheme.textColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: _orderStore.comment == null
              ? DefaultAppTheme.grayLight
              : DefaultAppTheme.primaryColor,
          size: 20,
        ),
        dense: false,
      ),
    );
  }

  Widget _buildDate() {
    return InkWell(
      onTap: () {
        _pickDate();
      },
      child: Observer(builder: (context) {
        return ListTile(
          leading: FaIcon(
            FontAwesomeIcons.solidClock,
            color: (_orderStore.dateIsAsap || _orderStore.dateStart != null)
                ? DefaultAppTheme.primaryColor
                : DefaultAppTheme.grayLight,
            size: 15,
          ),
          title: _showDate(),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: (_orderStore.dateIsAsap || _orderStore.dateStart != null)
                ? DefaultAppTheme.primaryColor
                : DefaultAppTheme.grayLight,
            size: 20,
          ),
          dense: false,
        );
      }),
    );
  }

  Widget _showDate() {
    String title = 'Дата доставки';
    Color color = DefaultAppTheme.grayLight;

    if (_orderStore.dateIsAsap) {
      title = 'Как можно раньше';
      color = DefaultAppTheme.textColor;
    }

    if (_orderStore.dateStart != null) {
      DateTime oneHourPlus = _orderStore.dateStart!.add(Duration(hours: 1));
      DateFormat dateFormatter = DateFormat('dd-MM-yyy');
      DateFormat hourFormatter = DateFormat('H:m');

      title =
          '${Helpers.formatHourMinute(_orderStore.dateStart!)}-${Helpers.formatHourMinute(oneHourPlus)}, ${dateFormatter.format(_orderStore.dateStart!)}';
      color = DefaultAppTheme.textColor;
    }

    return Text(
      title,
      style: DefaultAppTheme.bodyText1.override(
        fontFamily: 'Gilroy',
        color: color,
      ),
    );
  }

  void _pickDate() async {
    await pushNewScreen(context,
        screen: PickDateWidget(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  void _pickAddress() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Wrap(
        children: [AddressPickerWidget()],
      ),
    );

    _orderStore.address = _userStore.currentAddress;

    print(
        "address list: current - ${_userStore.currentAddress}, order - ${_orderStore.address}");
  }

  void _enterComment() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Wrap(
        children: [CommentEnterWidget()],
      ),
    );
  }

  void _onDevCourier() {
    setState(() {
      _deliveryMode = 'DEV_COURIER';
    });
  }

  void _onDevDiy() {
    setState(() {
      _deliveryMode = 'DEV_DIY';
    });
  }

  void _onNextPressed() async {
    print('on next');

    _orderStore.deliveryType = _deliveryMode;

    _orderStore.username = _usernameController.text;
    _orderStore.fullname = _fullnameController.text;
    _orderStore.email = _emailController.text;

    // check for name
    if (_orderStore.fullname == null ||
        _orderStore.username == null ||
        _orderStore.email == null ||
        _usernameController.text.isEmpty ||
        _fullnameController.text.isEmpty ||
        _emailController.text.isEmpty) {
      Helpers.showInfoMessage(context, 'Введите ваши данные');
      return;
    }

    // TODO: check for num & email

    if (_orderStore.address == null &&
        _orderStore.deliveryType == 'DEV_COURIER') {
      Helpers.showInfoMessage(context, 'Укажите адрес доставки');
      return;
    }

    if (_orderStore.dateStart == null &&
        _orderStore.dateIsAsap == false &&
        _orderStore.deliveryType != 'DEV_DIY') {
      Helpers.showInfoMessage(context, 'Укажите дату доставки');
      return;
    }

    pushNewScreen(context,
        screen: CheckoutConfirmScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

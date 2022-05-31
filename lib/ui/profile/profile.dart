import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:barcode/barcode.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/payment/creditcard.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/address/address_picker.dart';
import 'package:esentai/ui/creditcard/creditcard_picker.dart';
import 'package:esentai/ui/favorites/favorites.dart';
import 'package:esentai/ui/login/login.dart';
import 'package:esentai/ui/notifications/notifications.dart';
import 'package:esentai/ui/orders/orders.dart';
import 'package:esentai/ui/orders/payment_picker.dart';
import 'package:esentai/ui/profile/edit_profile.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/barcode_widget.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);

    if (!_userStore.isLoggedIn) {
      Future.delayed(Duration(milliseconds: 0), () {
        // print("user is not logged in");
        pushNewScreen(context,
            screen: LoginScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     Routes.login, (Route<dynamic> route) => false);
      });

      return;
    }

    if (!_userStore.isLoading) {
      // print("load profile");
      _userStore.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: DefaultAppTheme.primaryColor,
          title: Text(
            'Личный кабинет',
            style: DefaultAppTheme.title2.override(
              fontFamily: 'Gilroy',
              color: Colors.white,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFCFCFC),
        body: SafeArea(child: _buildBody()));
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(builder: (context) {
          return _buildMainBody();
        }),

        // Observer(builder: (context) {
        //   return _userStore.profile == null
        //       ? navigate(context)
        //       : Helpers.showErrorMessage(
        //           context, _userStore.errorStore.errorMessage);
        // }),
      ],
    );
  }

  Widget _buildMainBody() {
    // if (_userStore != null && !_userStore.isLoggedIn) {
    //   pushNewScreen(context, screen: LoginScreen(), withNavBar: false);
    // }

    return !_userStore.isLoggedIn || _userStore.profile == null
        ? Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Нет данных',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                          onPressed: () {
                            _userStore.getProfile();
                          },
                          child: Text('Перезагрузить'),
                          style: DefaultAppTheme.buttonDefaultStyle),
                    )
                  ]),
            ),
          )
        : Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    _userStore.getProfile();
                  },
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _buildProfileHeader(),
                            InkWell(
                              onTap: () async {
                                await pushNewScreen(context,
                                    screen: EditProfileScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade);

                                _userStore.getProfile();
                              },
                              child: Image.asset(
                                'assets/images/ic_profile_edit.png',
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ),
                      _buildLoyalty(),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _onFavoritesPressed();
                                    },
                                    child: ListTile(
                                      leading: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        color: DefaultAppTheme.grayLight,
                                        size: 20,
                                      ),
                                      title: Text(
                                        'Избранные товары',
                                        textAlign: TextAlign.start,
                                        style: DefaultAppTheme.bodyText1,
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: DefaultAppTheme.primaryColor,
                                        size: 20,
                                      ),
                                      dense: false,
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      pushNewScreen(context,
                                          screen: OrdersScreen(),
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.fade);
                                    },
                                    child: ListTile(
                                      leading: FaIcon(
                                        FontAwesomeIcons.clipboardList,
                                        color: DefaultAppTheme.grayLight,
                                        size: 20,
                                      ),
                                      title: Text(
                                        'История заказов',
                                        textAlign: TextAlign.start,
                                        style: DefaultAppTheme.bodyText1,
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: DefaultAppTheme.primaryColor,
                                        size: 20,
                                      ),
                                      dense: false,
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _onNotificationsPressed();
                                    },
                                    child: ListTile(
                                      leading: FaIcon(
                                        FontAwesomeIcons.bell,
                                        color: DefaultAppTheme.grayLight,
                                        size: 20,
                                      ),
                                      title: Text(
                                        'Мои уведомления',
                                        textAlign: TextAlign.start,
                                        style: DefaultAppTheme.bodyText1,
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: DefaultAppTheme.primaryColor,
                                        size: 20,
                                      ),
                                      dense: false,
                                    ),
                                  ),
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
                                  _buildPaymentMethod(),
                                  // Divider(
                                  //   height: 1,
                                  //   thickness: 1,
                                  // ),
                                  // ListTile(
                                  //   dense: false,
                                  // ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  ListTile(
                                    leading: FaIcon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      color: DefaultAppTheme.grayLight,
                                      size: 20,
                                    ),
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text('Мои адреса',
                                              style: DefaultAppTheme.bodyText1
                                                  .override(
                                                      fontFamily: 'Gilroy',
                                                      color: _userStore
                                                                  .currentPaymentMethod ==
                                                              null
                                                          ? DefaultAppTheme
                                                              .textColor
                                                          : DefaultAppTheme
                                                              .textColor)),
                                        ),
                                        if (_userStore.currentAddress != null)
                                          Expanded(
                                            child: _userStore.currentAddress !=
                                                    null
                                                ? Text(
                                                    "${Address.getFullStr(_userStore.currentAddress!)}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    style: DefaultAppTheme
                                                        .bodyText2)
                                                : Text(
                                                    'Не выбран',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: DefaultAppTheme
                                                            .primaryColor),
                                                  ),
                                          ),
                                      ],
                                    ),
                                    dense: false,
                                    onTap: () {
                                      _onPickAddress();
                                    },
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 60),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          await _userStore.logout();

                                          Future.delayed(
                                              Duration(milliseconds: 0), () {
                                            // go to nav
                                            pushNewScreen(context,
                                                screen: LoginScreen(),
                                                withNavBar: false,
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .fade);
                                          });
                                        },
                                        label: Text('Выйти из аккаунта'),
                                        icon: Icon(
                                          Icons.logout,
                                          size: 15,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent,
                                            elevation: 0,
                                            onPrimary:
                                                DefaultAppTheme.secondaryColor,
                                            textStyle: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: DefaultAppTheme
                                                    .secondaryColor)),
                                      ),
                                    ),
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
              ),
              // Observer(builder: (context) {
              //   return Visibility(
              //     visible: _userStore.isLoading,
              //     child: CustomProgressIndicatorWidget(),
              //   );
              // }),
            ],
          );
  }

  Widget _buildPaymentMethod() {
    String title = 'Мои карты';
    Color color = DefaultAppTheme.grayLight;

    // print("current payment: $title");

    if (_userStore.currentPaymentMethod != null) {
      color = DefaultAppTheme.primaryColor;

      // TODO: hard coded...
      Map<String, String> methods = {
        '1': 'Оплата банковской картой',
        '2': 'Банковской картой курьеру',
        '3': 'Наличными',
      };

      title = methods[_userStore.currentPaymentMethod.toString()]!;
      print("current payment: $title");
    }

    return Observer(builder: (context) {
      // print("current payment in observer: ${_userStore.currentPaymentMethod}");

      return ListTile(
        leading: FaIcon(
          FontAwesomeIcons.ccMastercard,
          color: DefaultAppTheme.grayLight,
          size: 15,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text('Мои карты',
                  style: DefaultAppTheme.bodyText1.override(
                      fontFamily: 'Gilroy',
                      color: _userStore.currentPaymentMethod == null
                          ? DefaultAppTheme.textColor
                          : DefaultAppTheme.textColor)),
            ),
            if (_userStore.currentCard != null)
              Expanded(
                child: Text("${_getFullCardStr(_userStore.currentCard!)}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: DefaultAppTheme.bodyText2),
              ),
            if (_userStore.currentCard == null)
              Text(
                'Не выбрана',
                textAlign: TextAlign.right,
                style: TextStyle(color: DefaultAppTheme.primaryColor),
              ),
          ],
        ),

        // trailing: _userStore.currentPaymentMethod != null
        //     ? SizedBox(
        //         width: 80,
        //         child: Text(_getPaymentMethodId(),
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //             textAlign: TextAlign.right,
        //             style: DefaultAppTheme.bodyText2),
        //       )
        //     : Text(
        //         'Не выбран',
        //         style: TextStyle(color: DefaultAppTheme.primaryColor),
        //       ),
        dense: false,
        onTap: () {
          _onPickPayment();
        },
      );
    });
  }

  String _getFullCardStr(CreditCard card) {
    return Helpers.getCardTypeStr(card) + " " + Helpers.getCardStr(card);
  }

  String _getPaymentMethodId() {
    Map<int, String> methods = {
      1: 'Банковской картой',
      2: 'Банковской картой курьеру',
      3: 'Наличными',
    };

    if (_userStore.currentPaymentMethod != null) {
      return methods[_userStore.currentPaymentMethod]!;
    }

    return '';
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
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Wrap(
        children: [
          // PaymentPicker(),
          CreditCardPickerWidget(),
        ],
      ),
    );

    // print("current payment: ${_userStore.currentPaymentMethod}");
  }

  Widget _buildProfileHeader() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _userStore.profile?.fullname ?? '',
            style: DefaultAppTheme.title1,
          ),
          Row(
            children: [
              Image.asset('assets/images/ic_phone_grey.png', width: 15),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                child: Text(
                  _userStore.profile?.username ?? '',
                  style: DefaultAppTheme.title2.override(
                    color: DefaultAppTheme.grayLight,
                  ),
                ),
              ),
            ],
          ),
          if (_userStore.profile?.birthday != null)
            Row(
              children: [
                Image.asset('assets/images/ic_birthday.png', width: 15),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                  child: Text(
                    '${_userStore.profile?.birthday}',
                    style: DefaultAppTheme.title2.override(
                      color: DefaultAppTheme.grayLight,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLoyalty() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 41, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Бонусная карта',
            style: DefaultAppTheme.title2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logo_black.png',
                          width: 57,
                          height: 21,
                        ),
                        // barcode
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: BarcodeWidget(
                            barcode:
                                Barcode.code128(), // Barcode type and settings
                            data:
                                '${_userStore.profile?.loyaltyNum}', // Content
                            width: double.infinity,
                            height: 80,
                          ),
                        ),
                        // Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Expanded(
                        //         child: Text('000 0000 0000 000',
                        //             textAlign: TextAlign.center),
                        //       ),
                        //     ]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Expanded(child: Text('3%')),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Бонусы',
                                  style: DefaultAppTheme.bodyText1,
                                ),
                                Text(
                                  '${_userStore.profile?.loyaltyBalance!.toInt()}',
                                  style: DefaultAppTheme.title2,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
    double? width,
    double? height,
    double? fontHeight,
  }) {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    // Save the image
    filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    var file = File('$filename.svg');
    file.writeAsStringSync(svg);

    return Image.asset(file.path, height: 80);
  }

  // pick address
  void _onPickAddress() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Wrap(children: [AddressPickerWidget()]),
    );
  }

  void _onFavoritesPressed() {
    pushNewScreen(context,
        screen: FavoritesScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  void _onNotificationsPressed() {
    pushNewScreen(context,
        screen: NotificationsScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  // Widget navigate(BuildContext context) {
  //   print("navigate called...profile");

  //   if (_userStore.profile == null) {
  //     Future.delayed(Duration(milliseconds: 0), () {
  //       // go to nav
  //       Navigator.of(context)
  //           .pushNamedAndRemoveUntil(Routes.home, (route) => false);
  //     });
  //   }

  //   return Container();
  // }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/models/order/order.dart';
import 'package:esentai/models/order/order_item.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderDetailsWidget extends StatefulWidget {
  OrderDetailsWidget({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  _OrderDetailsScreenWidgetState createState() =>
      _OrderDetailsScreenWidgetState();
}

class _OrderDetailsScreenWidgetState extends State<OrderDetailsWidget> {
  late TextEditingController _textController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _userStore = Provider.of<UserStore>(context);

    if (!_userStore.isLoading) {
      _userStore.getOrderById(widget.order.id!);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFFCFCFC),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(builder: (context) {
          return SafeArea(child: _buildMainBody());
        }),
        Observer(builder: (context) {
          return Visibility(
            visible: _userStore.isLoading,
            child: CustomProgressIndicatorWidget(),
          );
        }),
      ],
    );
  }

  Widget _buildMainBody() {
    if (_userStore.currentOrder != null) {
      print(_userStore.currentOrder);
      return _buildOrder();
    }

    return Container();
  }

  Widget _buildOrder() {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.close),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                // color: DefaultAppTheme.textColor,
                // size: 24,
                onPressed: () {
                  print('order...');
                  Navigator.of(context).pop();
                },
                label: Text(''),
              ),
              Expanded(
                child: Text(
                  'Заказ № ${widget.order.id}',
                  textAlign: TextAlign.center,
                  style: DefaultAppTheme.title2.override(
                    fontFamily: 'Gilroy',
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/ic_clock_green.png',
              //   width: 16,
              //   height: 16,
              //   fit: BoxFit.contain,
              // ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Text(
                  '${widget.order.status ?? 'Нет статуса'}',
                  style: DefaultAppTheme.title2.override(
                    fontFamily: 'Gilroy',
                    color: DefaultAppTheme.tertiaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 21, 16, 0),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Оформлен',
                              style: DefaultAppTheme.bodyText2.override(
                                fontFamily: 'Gilroy',
                                color: DefaultAppTheme.grey3,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              '${widget.order.updatedAt}',
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 21, 16, 0),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Получатель',
                              style: DefaultAppTheme.bodyText2.override(
                                fontFamily: 'Gilroy',
                                color: DefaultAppTheme.grey3,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              '${_userStore.currentOrder?.user?.fullname}',
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 21, 16, 0),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Телефон',
                              style: DefaultAppTheme.bodyText2.override(
                                fontFamily: 'Gilroy',
                                color: DefaultAppTheme.grey3,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              '${_userStore.currentOrder?.user?.username}',
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 21, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (_userStore.currentOrder?.address != null)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                'Адрес',
                                style: DefaultAppTheme.bodyText2.override(
                                  fontFamily: 'Gilroy',
                                  color: DefaultAppTheme.grey3,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                              child: Text(
                                '${_userStore.currentOrder?.address}',
                                style: DefaultAppTheme.title2.override(
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 21, 16, 0),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Оплата',
                              style: DefaultAppTheme.bodyText2.override(
                                fontFamily: 'Gilroy',
                                color: DefaultAppTheme.grey3,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              _getPaymentMethod(),
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsetsDirectional.fromSTEB(16, 21, 16, 0),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       Expanded(
        //         child: Column(
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Divider(
        //               height: 1,
        //               thickness: 1,
        //             ),
        //             Padding(
        //               padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 21),
        //               child: Row(
        //                 mainAxisSize: MainAxisSize.max,
        //                 children: [
        //                   Expanded(
        //                     child: Text(
        //                       'Доставка',
        //                       style: DefaultAppTheme.bodyText2.override(
        //                         fontFamily: 'Gilroy',
        //                         color: DefaultAppTheme.grey3,
        //                       ),
        //                     ),
        //                   ),
        //                   Padding(
        //                     padding:
        //                         EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
        //                     child: Text(
        //                       'Бесплатно',
        //                       style: DefaultAppTheme.title2.override(
        //                         fontFamily: 'Gilroy',
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 21, 16, 0),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Сумма',
                              style: DefaultAppTheme.bodyText2.override(
                                fontFamily: 'Gilroy',
                                color: DefaultAppTheme.grey3,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              '${_userStore.currentOrder?.totalPrice ?? 0} тг',
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 21, 16, 0),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 21),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Бонусы',
                              style: DefaultAppTheme.bodyText2.override(
                                fontFamily: 'Gilroy',
                                color: DefaultAppTheme.grey3,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              '${_userStore.currentOrder?.bonusReturned ?? 0} тг',
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          )
                        ],
                      ),
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
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Детали заказа',
                      style: DefaultAppTheme.title2.override(
                        fontFamily: 'Gilroy',
                        color: DefaultAppTheme.grey3,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: double.infinity,
                          // height: 125,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // items
                                _buildItems(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userStore.currentOrder!.review == null
                          ? 'Оставить отзыв'
                          : 'Ваш отзыв',
                      style: DefaultAppTheme.title2.override(
                        fontFamily: 'Gilroy',
                        color: DefaultAppTheme.grey3,
                      ),
                    ),
                    if (_userStore.currentOrder!.review == null)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 125,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _textController,
                              obscureText: false,
                              decoration: InputDecoration(
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 16),
                              ),
                              style: DefaultAppTheme.bodyText1.override(
                                fontFamily: 'Gilroy',
                              ),
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ),
                    if (_userStore.currentOrder!.review != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 80),
                        child: Text('${_userStore.currentOrder!.review}'),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (_userStore.currentOrder!.review == null)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 64),
            child: ElevatedButton(
              onPressed: () {
                _submitReview();
              },
              child: Text('Отправить отзыв'),
              style: DefaultAppTheme.buttonDefaultStyle,
            ),
          ),
      ],
    );
  }

  Widget _buildItems() {
    if (widget.order.goods != null)
      return Column(
        children: [
          for (var item in widget.order.goods!.items!) _buildItem(item),
        ],
      );

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Нет товаров.'),
      ),
    );
  }

  Widget _buildItem(OrderItem item) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (item.product != null)
            SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 0),
                fadeOutDuration: Duration(milliseconds: 0),
                imageUrl: item.product!.mainImage!,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/nophoto.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          _buildGiftImage(item),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(
              '${item.count} х ',
              style: DefaultAppTheme.bodyText1.override(
                fontFamily: 'Gilroy',
                color: DefaultAppTheme.primaryColor,
              ),
            ),
          ),
          if (item.product != null)
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 16, 0),
                child: Text(
                  '${item.product!.name}',
                  style: DefaultAppTheme.bodyText1.override(
                    fontFamily: 'Gilroy',
                  ),
                ),
              ),
            ),
          if (item.gift != null)
            Expanded(
              child: _buildGiftName(item),
            ),
        ],
      ),
    );
  }

  Widget _buildGiftImage(OrderItem item) {
    if (item.gift != null) {
      if (item.gift!.gift != null) {
        if (item.gift!.gift!.mainImage != null) {
          return SizedBox(
            width: 50,
            height: 50,
            child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 0),
              fadeOutDuration: Duration(milliseconds: 0),
              imageUrl: item.gift!.gift!.mainImage!,
              // placeholder: (context, url) =>
              //     CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/nophoto.png',
              ),
              fit: BoxFit.cover,
            ),
          );
        }
      }
    }

    return Container();
  }

  Widget _buildGiftName(OrderItem item) {
    if (item.gift != null) {
      if (item.gift!.gift != null) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 16, 0),
          child: Text(
            '${item.gift!.gift?.name}',
            style: DefaultAppTheme.bodyText1.override(
              fontFamily: 'Gilroy',
            ),
          ),
        );
      }
    }

    return Container();
  }

  void _submitReview() async {
    String review = _textController.text;

    _userStore.submitReview(review, widget.order.id!);
    Navigator.of(context).pop();
  }

  String _getPaymentMethod() {
    Map<int, String> methods = {
      1: 'Оплата банковской картой',
      2: 'Оплата курьеру картой',
      3: 'Оплата наличными'
    };

    if (_userStore.currentOrder != null) {
      if (_userStore.currentOrder!.paymentMethod != null) {
        return methods[_userStore.currentOrder!.paymentMethod]!;
      }
    }

    return 'По умолчанию';
  }
}

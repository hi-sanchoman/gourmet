import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class PayWithBonusesScreen extends StatefulWidget {
  PayWithBonusesScreen({Key? key}) : super(key: key);

  @override
  State<PayWithBonusesScreen> createState() => _PayWithBonusesScreenState();
}

class _PayWithBonusesScreenState extends State<PayWithBonusesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;
  late OrderStore _orderStore;
  late CartStore _cartStore;

  TextEditingController _bonusController = TextEditingController();

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

    _calculateBonuses();
  }

  // METHODS
  List<dynamic> _getCartDetails() {
    List<dynamic> details = [];

    for (var item in _cartStore.flutterCart.cartItem) {
      details.add({
        "PositionId": item.productId,
        "ProductCode": item.productId,
        "TotalPrice": item.subTotal,
        "Quantity": item.quantity
      });
    }

    return details;
  }

  _calculateBonuses() async {
    if (!_orderStore.isLoading) {
      await _orderStore.getBonuses(
          _userStore.profile!.loyaltyNum!, _getCartDetails());
    }

    print("can: ${_orderStore.bonusCan}, max: ${_orderStore.bonusMax}");

    if (_orderStore.bonusPay != null) {
      setState(() {
        _bonusController.text = _orderStore.bonusPay.toString();
      });
    }
  }

  _onConfirm() {
    // print('confirm');
    int? bonus = int.tryParse(_bonusController.text);

    if (bonus != null &&
        _orderStore.bonusCan != null &&
        bonus > _orderStore.bonusCan!) {
      bonus = _orderStore.bonusCan!;
    }

    _orderStore.bonusPay = bonus;

    if (_orderStore.bonusPay! <= 0) {
      _orderStore.bonusPay = null;
    }

    Navigator.of(context).pop();
  }

  int _getTotalPrice() {
    int totalPrice = _cartStore.getTotalAmount().toInt();

    if (_orderStore.deliveryType != 'DEV_DIY' && _orderStore.address != null) {
      if (totalPrice >= _orderStore.address!.freeTreshold!) {
      }
      // else if (_totalPrice < _orderStore.address!.deliveryTreshold!) {
      else {
        totalPrice += _orderStore.address!.deliveryPrice!;
      }
    }

    // old delivery pricing
    // if (_totalPrice < AppConfig.delivery_threshold &&
    //     _orderStore.deliveryType != 'DEV_DIY') {
    //   _totalPrice += AppConfig.delivery_price;
    // }

    int? bonus = int.tryParse(_bonusController.text);

    if (bonus != null &&
        _orderStore.bonusCan != null &&
        bonus > _orderStore.bonusCan!) {
      bonus = _orderStore.bonusCan!;
    }

    if (bonus != null) {
      totalPrice -= bonus;
    }

    return totalPrice.toInt();
  }

  _onUseAll() {
    if (_orderStore.bonusCan != null) {
      setState(() {
        //   _orderStore.bonusPay = _orderStore.bonusCan;
        _bonusController.text = _orderStore.bonusCan.toString();
      });
    }
  }

  int _getBonusRest() {
    if (_orderStore.bonusPay != null && _orderStore.bonusCan != null) {
      return _orderStore.bonusCan! - _orderStore.bonusPay!;
    }

    if (_orderStore.bonusCan != null) {
      return _orderStore.bonusCan!;
    }

    return 0;
  }

  String _getBonusToBePaid() {
    int? bonus = int.tryParse(_bonusController.text);

    if (bonus != null &&
        _orderStore.bonusCan != null &&
        bonus > _orderStore.bonusCan!) {
      bonus = _orderStore.bonusCan!;
    }

    return bonus != null ? '${Helpers.prettyNum(bonus)} тг' : '0 тг';
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
          'Бонусы',
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ElevatedButton(
          onPressed: _bonusController.text.isNotEmpty ? _onConfirm : null,
          style: DefaultAppTheme.buttonDefaultStyle,
          child: Text('Применить'),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(
          builder: (context) {
            return _buildForm();
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
                visible: _orderStore.isLoading,
                child: CustomProgressIndicatorWidget());
          },
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        const SizedBox(
          height: 54,
        ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Stack(
                children: [
                  TextFormField(
                    controller: _bonusController,
                    onChanged: (val) {
                      setState(() {
                        // _bonusController.text = val;
                        // int? bonus = int.tryParse(val);

                        // if (bonus != null &&
                        //     _orderStore.bonusCan != null &&
                        //     bonus > _orderStore.bonusCan!) {
                        //   bonus = _orderStore.bonusCan!;
                        // }

                        // _orderStore.bonusPay = bonus;
                      });
                    },
                    decoration: InputDecoration(
                      isDense: false,
                      hintText: 'Потратить бонусы',
                      hintStyle: DefaultAppTheme.bodyText2,
                      errorStyle:
                          TextStyle(color: DefaultAppTheme.secondaryColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: DefaultAppTheme.grayLight,
                          width: 1,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: DefaultAppTheme.grayLight,
                          width: 1,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(0, 5, 0, 3),
                    ),
                    style: DefaultAppTheme.bodyText1,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _onUseAll,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Text(
                        'Использовать все',
                        style: DefaultAppTheme.bodyText1.override(
                          color: DefaultAppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                'Возможно ${Helpers.prettyNum(_getBonusRest())} тг',
                style: DefaultAppTheme.bodyText2,
              ),
            ),
            Expanded(
              child: Text(
                'Накоплено ${Helpers.prettyNum(_orderStore.bonusMax ?? 0)} тг',
                style: DefaultAppTheme.bodyText2,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        if (_bonusController.text.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Будет списано:',
                  style: DefaultAppTheme.bodyText1,
                ),
                const SizedBox(
                  width: 16,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'С карты',
                          style: DefaultAppTheme.bodyText2.override(
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            color: DefaultAppTheme.primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            '${Helpers.prettyNum(_getTotalPrice())} тг',
                            style: DefaultAppTheme.bodyText1.override(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '+',
                      style: DefaultAppTheme.bodyText1,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'С бонусов',
                              style: DefaultAppTheme.bodyText2.override(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            color: DefaultAppTheme.grayLight,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            _getBonusToBePaid(),
                            style: DefaultAppTheme.bodyText1.override(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

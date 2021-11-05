import 'package:esentai/models/address/address.dart';
import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/address/add_address.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class PaymentPicker extends StatefulWidget {
  PaymentPicker({Key? key}) : super(key: key);
  @override
  _ChooseDefaultAddressWidgetWidgetState createState() =>
      _ChooseDefaultAddressWidgetWidgetState();
}

class _ChooseDefaultAddressWidgetWidgetState extends State<PaymentPicker> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late OrderStore _orderStore;
  late UserStore _userStore;

  String _mode = 'MODE_PICK'; // MODE_PICK, MODE_EDIT

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orderStore = Provider.of<OrderStore>(context);
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: DefaultAppTheme.grey3,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          // height: 100,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 0),
                  child: Text(
                    'Способы оплаты',
                    style: DefaultAppTheme.title2.override(
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
              ),
              _buildPayments(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPayments() {
    return Observer(builder: (context) {
      return Column(children: [
        ListTile(
          leading: Image.asset('assets/images/ic_credit_card.png',
              color: DefaultAppTheme.primaryColor,
              width: 24,
              height: 24,
              fit: BoxFit.contain),
          title: Text(
            'Банковской картой',
            style: DefaultAppTheme.bodyText1.override(
              fontFamily: 'Gilroy',
            ),
          ),
          trailing: Image.asset(
            _userStore.currentPaymentMethod != 1
                ? 'assets/images/radio_back.png'
                : 'assets/images/radio_front.png',
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
          dense: false,
          onTap: () {
            _onPaymentPicked('credit_card');
          },
        ),
        Divider(),
        ListTile(
          leading: Image.asset('assets/images/ic_credit_courier.png',
              color: DefaultAppTheme.primaryColor,
              width: 24,
              height: 24,
              fit: BoxFit.contain),
          title: Text(
            'Банковской картой курьеру',
            style: DefaultAppTheme.bodyText1.override(
              fontFamily: 'Gilroy',
            ),
          ),
          dense: false,
          trailing: Image.asset(
            _userStore.currentPaymentMethod != 2
                ? 'assets/images/radio_back.png'
                : 'assets/images/radio_front.png',
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
          onTap: () {
            _onPaymentPicked('credit_courier');
          },
        ),
        Divider(),
        ListTile(
          leading: Image.asset('assets/images/ic_cash.png',
              color: DefaultAppTheme.primaryColor,
              width: 24,
              height: 24,
              fit: BoxFit.contain),
          title: Text(
            'Наличными курьеру',
            style: DefaultAppTheme.bodyText1.override(
              fontFamily: 'Gilroy',
            ),
          ),
          trailing: Image.asset(
            _userStore.currentPaymentMethod != 3
                ? 'assets/images/radio_back.png'
                : 'assets/images/radio_front.png',
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
          dense: false,
          onTap: () {
            _onPaymentPicked('cash');
          },
        ),
      ]);
    });
  }

  void _onPaymentPicked(String method) {
    Map<String, int> methods = {
      'credit_card': 1,
      'credit_courier': 2,
      'cash': 3
    };

    _orderStore.paymentId = methods[method].toString();
    _userStore.currentPaymentMethod = methods[method];

    print("order store: " + _orderStore.paymentId.toString());
    print("user store: " + _userStore.currentPaymentMethod.toString());

    Navigator.of(context).pop();
  }
}

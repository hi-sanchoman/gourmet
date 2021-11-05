import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/login/success.dart';
import 'package:esentai/ui/payment/payment_result.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class PaymentLoadingScreen extends StatefulWidget {
  PaymentLoadingScreen({Key? key}) : super(key: key);

  @override
  _PaymentLoadingScreenState createState() => _PaymentLoadingScreenState();
}

class _PaymentLoadingScreenState extends State<PaymentLoadingScreen> {
  late OrderStore _orderStore;
  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orderStore = Provider.of<OrderStore>(context);
    _userStore = Provider.of<UserStore>(context);

    if (!_userStore.isLoading) {
      // check for payment ...

      _userStore.getOrderById(_orderStore.response!.orderId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Размещение заказа'),
        elevation: 1,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        // navigate on success
        Observer(builder: (context) {
          return _userStore.success ? navigate(context) : Container();
        }),

        Observer(builder: (context) {
          return _userStore.isLoading
              ? CustomProgressIndicatorWidget()
              : Container();
        }),
      ],
    );
  }

  Widget navigate(BuildContext context) {
    if (_userStore.currentOrder == null) {
      return Container();
    }

    // paid
    if (_userStore.currentOrder!.paymentStatus == 'PAYED') {
      Future.delayed(Duration(milliseconds: 0), () {
        pushNewScreen(context,
            screen: PaymentResultScreen(message: 'success'),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);
      });
    }

    // unpaid
    else {
      Future.delayed(Duration(milliseconds: 0), () {
        pushNewScreen(context,
            screen: PaymentResultScreen(message: 'failure'),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);
      });
    }

    return Container();
  }
}

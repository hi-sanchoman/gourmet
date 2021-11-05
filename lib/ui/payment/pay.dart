import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/ui/payment/payment_loading.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class PayScreen extends StatefulWidget {
  PayScreen({Key? key}) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  late OrderStore _orderStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orderStore = Provider.of<OrderStore>(context);

    // _launchUrl(_orderStore.response!.message!);
  }

  @override
  Widget build(BuildContext context) {
    // print("payment url: ${_orderStore.response!.message}");

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            Observer(builder: (context) {
              return _orderStore.response != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: WebView(
                        initialUrl: '${_orderStore.response!.message}',
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                    )
                  : CustomProgressIndicatorWidget();
            }),
            Align(
              alignment: Alignment(0, 1),
              child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 32, left: 32, right: 32),
                  child: Container(
                    color: Colors.white,
                    child: ElevatedButton(
                      style: DefaultAppTheme.buttonDefaultStyle,
                      onPressed: () {
                        _onSubmit();
                      },
                      child: Text('Вернуться в приложение'),
                    ),
                  )),
            ),
          ],
        )),
      ),
    );
  }

  void _onSubmit() async {
    // await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

    pushNewScreen(context,
        screen: PaymentLoadingScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

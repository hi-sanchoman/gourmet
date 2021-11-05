import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentResultScreen extends StatefulWidget {
  PaymentResultScreen({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  _SuccessScreenWidgetState createState() => _SuccessScreenWidgetState();
}

class _SuccessScreenWidgetState extends State<PaymentResultScreen> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: DefaultAppTheme.background,
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [],
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.message == 'success')
                      Image.asset(
                        'assets/images/success.png',
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Text(
                        widget.message == 'success'
                            ? 'Спасибо!'
                            : 'Не оплачено',
                        style: DefaultAppTheme.title1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                      child: Text(
                        widget.message == 'success'
                            ? 'Ваш заказ оформлен'
                            : 'Ваш заказ не оплачен...',
                        textAlign: TextAlign.center,
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 50),
                  child: ElevatedButton(
                    onPressed: () {
                      _onShop();
                    },
                    child: Text('Вернуться к покупкам'),
                    style: DefaultAppTheme.buttonDefaultStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onShop() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.home, (route) => false);
  }
}

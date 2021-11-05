import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  SuccessScreen({Key? key}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DefaultAppTheme.background,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                'assets/images/success.png',
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 0),
                child: Text(
                  'Регистрация в системе прошла успешно!',
                  textAlign: TextAlign.center,
                  style: DefaultAppTheme.title1.override(
                    fontFamily: 'Gilroy',
                    color: DefaultAppTheme.tertiaryColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: Text(
                  'Желаем вам вкусных и быстрых заказов!',
                  textAlign: TextAlign.center,
                  style: DefaultAppTheme.bodyText1.override(
                    fontFamily: 'Gilroy',
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 50),
                child: ElevatedButton(
                    onPressed: () {
                      // go to nav
                    },
                    child: Text('Перейти к покупкам'),
                    style: DefaultAppTheme.buttonDefaultStyle),
              )
            ],
          ),
        ),
      ),
    );
  }
}

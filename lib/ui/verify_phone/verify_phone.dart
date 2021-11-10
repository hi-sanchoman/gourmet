import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:device_info/device_info.dart';
import 'package:esentai/constants/app_config.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/data/sharedpref/shared_preference_helper.dart';
import 'package:esentai/models/auth/login_response.dart';
import 'package:esentai/stores/form/form_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/locale/app_localization.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneVerifyScreen extends StatefulWidget {
  PhoneVerifyScreen({Key? key, required this.referer}) : super(key: key);

  final String referer;

  @override
  _PhoneVerifyScreenState createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _codeInputController = TextEditingController();

  String _code = '';
  String _phoneNumber = '';

  late FormStore _formStore;
  late UserStore _userStore;

  static const countdownDuration =
      Duration(seconds: AppConfig.reset_sms_in_seconds);
  bool _canSendCodeAgain = false;
  Duration _duration = Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    _resetTimer();
    _startTimer();

    // Future.delayed(Duration(milliseconds: 0), () {
    //   FlushbarHelper.createInformation(
    //       title: "SMS code", message: _code, duration: Duration(seconds: 5))
    //     ..show(context);
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _formStore = Provider.of<FormStore>(context);

    if (_formStore.userId.isNotEmpty) {
      _phoneNumber = _formStore.userId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFCFCFC),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          _buildMainBody(),
          // Observer(builder: (context) {
          //   return Visibility(
          //     visible: _formStore.isLoading,
          //     child: CustomProgressIndicatorWidget(),
          //   );
          // }),
          Observer(builder: (context) {
            return _formStore.successSMS || _userStore.success
                ? navigate(context)
                : _showErrorMessage(_formStore.errorStore.errorMessage);
          }),
        ],
      ),
    );
  }

  Widget _buildMainBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: Color(0xFFF2F6FA),
      ),
      child: Stack(
        alignment: AlignmentDirectional(0, 0),
        children: [
          Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Image.asset(
              'assets/images/register_top.png',
              width: double.infinity,
              height: 294,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 36, 0, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    'assets/images/logo_white.png',
                    width: 163,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 16),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: DefaultAppTheme.background,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Color(0x06011926),
                        offset: Offset(2, 0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Text(
                          'Верификация',
                          style: DefaultAppTheme.title1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 0),
                        child: Text(
                          "Введите SMS-код, отправленный на",
                          textAlign: TextAlign.center,
                          style: DefaultAppTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Text(
                          _phoneNumber,
                          style: DefaultAppTheme.title2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 28, 20, 0),
                        child: PinCodeTextField(
                          appContext: context,
                          // backgroundColor: Colors.red,

                          pastedTextStyle: TextStyle(
                            color: Color(0xFFCECFD2),
                            fontWeight: FontWeight.bold,
                          ),
                          length: 5,
                          // obscureText: true,
                          // obscuringCharacter: '*',
                          // obscuringWidget: FlutterLogo(
                          //   size: 24,
                          // ),
                          // blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            // if (v!.length < 3) {
                            //   return "I'm from validator";
                            // } else {
                            //   return null;
                            // }
                          },
                          textStyle: TextStyle(color: Colors.white),
                          pinTheme: PinTheme(
                            inactiveColor: DefaultAppTheme.grayLight,
                            inactiveFillColor: Colors.white,
                            activeColor: DefaultAppTheme.grayLight,
                            activeFillColor: Color(0xFF313234),
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 50,
                            fieldWidth: 50,
                          ),
                          cursorColor: Colors.white,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          // errorAnimationController: errorController,
                          controller: _codeInputController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (value) {
                            print("Completed: $value");

                            setState(() {
                              _code = value;
                            });

                            _onSubmit();
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              _code = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      _buildTimer(),
                      Visibility(
                        visible: _canSendCodeAgain,
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(40, 10, 40, 0),
                          child: TextButton(
                              onPressed: () {
                                _onCanSendCodeAgain();
                              },
                              child: Text('Отправить код заново')),
                        ),
                      ),
                      Spacer(),
                      Observer(builder: (context) {
                        return Visibility(
                          visible: _formStore.isLoading || _userStore.isLoading,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 16),
                        child: ElevatedButton(
                          onPressed: () {
                            _onSubmit();
                          },
                          child: Text('Подтвердить'),
                          style: DefaultAppTheme.buttonDefaultStyle,
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      //   child: TextButton(
                      //     onPressed: () {
                      //       // go to nav
                      //       Navigator.of(context)
                      //           .pushReplacementNamed(Routes.home);
                      //     },
                      //     child: Text('Пропустить авторизацию'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // Align(
          //   alignment: AlignmentDirectional(0, 1),
          //   child: Padding(
          //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
          //     child: TextButton(
          //       onPressed: () {
          //         // go to nav
          //         Navigator.of(context).pushReplacementNamed(Routes.home);
          //       },
          //       child: Text('Пропустить авторизацию'),
          //     ),
          //   ),
          // ),
          // Align(
          //   alignment: AlignmentDirectional(-1, -1),
          //   child: Padding(
          //     padding: EdgeInsetsDirectional.fromSTEB(16, 32, 0, 0),
          //     child: SvgPicture.asset(
          //       'assets/images/back_white.png',
          //       width: 35,
          //       height: 35,
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Visibility(
      visible: !_canSendCodeAgain,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
        child: Text(
          'Отправить код повторно через $seconds сек',
          style: DefaultAppTheme.bodyText2,
        ),
      ),
    );
  }

  void _onSubmit() async {
    _formStore.setCode(_code);

    // if (widget.referer == 'login') {
    // TODO: check for error
    print("print- activate user");
    await _formStore.activateUser();

    print("after code enter: ${_formStore.successSMS}");

    if (_formStore.successSMS == true) {
      print("print- get token");
      await _formStore.getToken();
      return;
    } else {}
    // await _registerDevice();

    // } else {
    // print("register mode");
    // }
    // _formStore.activateSMS();

    _showErrorMessage('Ошибка на сервере');
  }

  void _registerDevice() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    //
    // FirebaseMessaging messaging = FirebaseMessaging.instance;

    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    //
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }

      deviceData['registration_id'] = '';

      // _formStore.registerDevice(deviceData);
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'deviceName': build.model,
      'deviceVersion': build.version.toString(),
      'device_id': build.androidId,
      'active': true,
      'type': 'android'
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'deviceName': data.name,
      'deviceVersion': data.systemVersion,
      'device_id': data.identifierForVendor,
      'active': true,
      'type': 'ios'
    };
  }

  void _onCanSendCodeAgain() {
    _resetTimer();
    _startTimer();

    // resend code
    // if (widget.referer == 'login')
    _formStore.login(mode: "verify_phone");
    // else
    // _formStore.resendSMS();
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => _addTime());
  }

  void _resetTimer() {
    setState(() {
      _canSendCodeAgain = false;
      _duration = countdownDuration;
    });
  }

  void _addTime() {
    final addSeconds = -1;

    setState(() {
      final seconds = _duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
        _canSendCodeAgain = true;
      } else {
        _duration = Duration(seconds: seconds);
      }
    });
  }

  Widget navigate(BuildContext context) {
    print("navigate called...verify phone");

    // we have user data -> go home
    if (_userStore.profile != null) {
      print("print- success... go to home page");

      // save user data <- does this shoud be here?
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(Preferences.username, _userStore.profile!.username!);
        prefs.setString(Preferences.fullname, _userStore.profile!.fullname!);
        prefs.setString(Preferences.email, _userStore.profile!.email!);
        prefs.setInt(Preferences.user_id, _userStore.profile!.id!);
      });

      // go to home
      Future.delayed(Duration(milliseconds: 0), () {
        // go to nav
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.home, (route) => false);
      });

      return Container();
    }

    // we have token
    if (_formStore.tokenResponse != null) {
      // save token
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool(Preferences.is_logged_in, true);
        prefs.setString(
            Preferences.auth_token, _formStore.tokenResponse!.access);
      });

      _userStore.isLoggedIn = true;

      // get current userdata
      print("print- get current profile");
      _userStore.getProfile();

      return Container();
    }

    // testing: show SMS code
    if (_formStore.loginResponse != null) {
      _formStore.successSMS = false;

      // Future.delayed(Duration(milliseconds: 0), () {
      //   FlushbarHelper.createInformation(
      //       title: "SMS code",
      //       message: _formStore.loginResponse!.code.code,
      //       duration: Duration(seconds: 5))
      //     ..show(context);
      // });
    }

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        // FlushbarHelper.createError(
        //   message: message,
        //   title: AppLocalizations.of(context).translate('home_tv_error'),
        //   duration: Duration(seconds: 3),
        // )..show(context);

        // Helpers.showInfoMessage(context, "Неверный код. Попробуйте еще раз.");
      });
    }

    return SizedBox.shrink();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}

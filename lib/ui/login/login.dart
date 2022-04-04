import 'package:another_flushbar/flushbar_helper.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/auth/login_response.dart';
import 'package:esentai/stores/form/form_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/home/home.dart';
import 'package:esentai/ui/home/navbarscreen.dart';
import 'package:esentai/ui/verify_phone/verify_phone.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/locale/app_localization.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/birthday_picker_widget.dart';
import 'package:esentai/widgets/default_input_field_widget.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

  // @override
  // Widget wrappedRoute(BuildContext context) {
  //   print("wrapped widget");

  //   return Observer(builder: (context) {
  //     return Container();
  //   });
  // }
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _inputKeyPhone = GlobalKey<DefaultInputFieldWidgetState>();
  final _inputKeyPhone2 = GlobalKey<DefaultInputFieldWidgetState>();
  final _inputKeyName = GlobalKey<DefaultInputFieldWidgetState>();
  final _inputKeyEmail = GlobalKey<DefaultInputFieldWidgetState>();
  final _birthdayKey = GlobalKey<BirthdayPickerWidgetState>();

  late UserStore _userStore;
  late FormStore _formStore;

  late DefaultInputFieldWidget _phoneInput;
  late DefaultInputFieldWidget _phoneInput2;
  late DefaultInputFieldWidget _userInput;
  late DefaultInputFieldWidget _emailInput;

  var _maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
  var _maskFormatter2 = new MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _phoneController2 = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  late BirthdayPickerWidget _birthdayPicker;

  @override
  void initState() {
    super.initState();

    _phoneInput = DefaultInputFieldWidget(
      key: _inputKeyPhone,
      label: 'Номер телефона',
      isRequired: false,
      formatter: _maskFormatter,
      keyboardType: TextInputType.phone,
      hint: '+7 (   )',
      leadingIconDefault: 'assets/images/ic_phone_grey.png',
      leadingIconActive: 'assets/images/ic_phone.png',
      color: DefaultAppTheme.textColor,
      controller: _phoneController,
    );

    _userInput = DefaultInputFieldWidget(
      key: _inputKeyName,
      label: 'Имя Фамилия',
      isRequired: true,
      hint: 'Имя Фамилия',
      keyboardType: TextInputType.name,
      leadingIconDefault: 'assets/images/ic_user_grey.png',
      leadingIconActive: 'assets/images/ic_user.png',
      color: DefaultAppTheme.textColor,
      controller: _fullnameController,
    );

    _phoneInput2 = DefaultInputFieldWidget(
      key: _inputKeyPhone2,
      label: 'Номер телефона',
      isRequired: true,
      formatter: _maskFormatter2,
      keyboardType: TextInputType.phone,
      hint: '+7 (   )',
      leadingIconDefault: 'assets/images/ic_phone_grey.png',
      leadingIconActive: 'assets/images/ic_phone.png',
      color: DefaultAppTheme.textColor,
      controller: _phoneController2,
    );

    _emailInput = DefaultInputFieldWidget(
      key: _inputKeyEmail,
      label: 'Электронная почта',
      isRequired: true,
      leadingIconDefault: 'assets/images/ic_email_grey.png',
      leadingIconActive: 'assets/images/ic_email.png',
      hint: 'Электронная почта',
      keyboardType: TextInputType.emailAddress,
      color: DefaultAppTheme.textColor,
      controller: _emailController,
    );

    _birthdayPicker = BirthdayPickerWidget(
        key: _birthdayKey,
        onPressed: () {
          print('pick birthday');

          _pickDate();
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _formStore = Provider.of<FormStore>(context);

    // if (_userStore.isLoggedIn) {
    //   Future.delayed(Duration(milliseconds: 0), () {
    //     context.router.replaceAll([
    //       NavBarRoute(children: [HomeRoute()])
    //     ]);
    //   });
    // }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneController2.dispose();
    _fullnameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFFCFCFC),
          body: _buildBody()),
    );
  }

  Widget _buildBody() {
    // if not logged in
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            // main body
            _buildMainBody(),
            // navigate on success
            Observer(builder: (context) {
              return _formStore.success
                  ? navigate(context)
                  : _showErrorMessage(_formStore.errorStore.errorMessage);
            }),
            // is user logged in
            // Observer(builder: (context) {
            //   return _isLoggedIn(context);
            // }),
          ],
        ),
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
              'assets/images/login_top.png',
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
                child: Image.asset(
                  'assets/images/logo_white.png',
                  width: 163,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 16),
                child: Container(
                  width: double.infinity,
                  height: 520,
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
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 52, 30, 0),
                                child: Container(
                                  height: 33,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(
                                      100.0,
                                    ),
                                  ),
                                  child: TabBar(
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100.0,
                                      ),
                                      color: DefaultAppTheme.primaryColor,
                                    ),
                                    labelColor: Colors.white,
                                    unselectedLabelColor:
                                        DefaultAppTheme.grayLight,
                                    tabs: [
                                      Tab(
                                        text: 'Вход',
                                      ),
                                      Tab(
                                        text: 'Регистрация',
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    _buildLogin(),
                                    _buildRegister(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding:
                            //       EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                            //   child: Image.asset(
                            //     'assets/images/line_grey.png',
                            //     width: 57,
                            //     height: 1,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            // Text(
                            //   'или войти с помощью',
                            //   style: DefaultAppTheme.bodyText2,
                            // ),
                            // Padding(
                            //   padding:
                            //       EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            //   child: Image.asset(
                            //     'assets/images/line_grey.png',
                            //     width: 57,
                            //     height: 1,
                            //     fit: BoxFit.cover,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // InkWell(
                            //   onTap: () {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(content: Text('Apple...')));
                            //   },
                            //   child: Image.asset(
                            //     'assets/images/apple.png',
                            //     width: 50,
                            //     height: 50,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            // Padding(
                            //   padding:
                            //       EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            //   child: InkWell(
                            //     onTap: () {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(content: Text('Facebook...')));
                            //     },
                            //     child: Image.asset(
                            //       'assets/images/facebook.png',
                            //       width: 50,
                            //       height: 50,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding:
                            //       EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            //   child: InkWell(
                            //     onTap: () {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(content: Text('Google...')));
                            //     },
                            //     child: Image.asset(
                            //       'assets/images/google.png',
                            //       width: 50,
                            //       height: 50,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          // Align(
          //   alignment: AlignmentDirectional(0, 1),
          //   child: Padding(
          //       padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
          //       child: TextButton(
          //         onPressed: () async {
          //           // go to nav home
          //           Navigator.of(context).pushReplacementNamed(Routes.home);
          //         },
          //         child: Text('Пропустить авторизацию'),
          //       )),
          // )
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30, 32, 30, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _phoneInput,
            Spacer(),
            // loader indicator
            Observer(builder: (context) {
              return Visibility(
                visible: _formStore.isLoading,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: CircularProgressIndicator(),
                ),
              );
            }),
            ElevatedButton(
              onPressed: () {
                _onLogin();
              },
              child: Text('Войти'),
              style: DefaultAppTheme.buttonDefaultStyle,
            ),
            // Padding(
            //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            //     child: TextButton(
            //       onPressed: () async {
            //         // go to nav home
            //         Navigator.of(context).pushReplacementNamed(Routes.home);
            //       },
            //       child: Text('Пропустить авторизацию'),
            //     )),

            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                child: TextButton(
                  onPressed: () async {
                    // go to nav home
                    pushNewScreen(context,
                        screen: NavBarScreen(),
                        pageTransitionAnimation: PageTransitionAnimation.fade);
                  },
                  child: Text('Пропустить авторизацию'),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRegister() {
    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height * 4,
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30, 32, 30, 0),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          _userInput,
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: _phoneInput2),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: _emailInput),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: _birthdayPicker),
          Spacer(),
          ElevatedButton(
              onPressed: () {
                _onRegister();
              },
              child: Text('Далее'),
              style: DefaultAppTheme.buttonDefaultStyle),
          //   Padding(
          //       padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
          //       child: TextButton(
          //         onPressed: () async {
          //           // go to nav home
          //           Navigator.of(context).pushReplacementNamed(Routes.home);
          //         },
          //         child: Text('Пропустить авторизацию'),
          //       )),
          // ],
        ]),
      ),
    );
  }

  void _pickDate() {
    DatePicker.showDatePicker(context,
        currentTime: _birthdayKey.currentState?.getDate(),
        showTitleActions: true,
        minTime: DateTime(1920, 1, 1), onConfirm: (date) {
      _setUserBirthday(date);
    }, locale: LocaleType.ru);
  }

  void _setUserBirthday(DateTime date) {
    String pickedDate = DateFormat('yyyy-MM-dd').format(date);

    _formStore.setBirthday(pickedDate);
    _birthdayKey.currentState?.updateDate(date);
  }

  void _onLogin() async {
    String phoneNumber = "+7" + _maskFormatter.getUnmaskedText().trim();

    print("go login: $phoneNumber");

    // set store
    _formStore.setUserId(phoneNumber);

    if (!_formStore.canLogin) {
      print("cant login " + _formStore.formErrorStore.userId.toString());

      _inputKeyPhone.currentState?.setErrors();
      Helpers.showInfoMessage(context, "Неверный номер телефона");
      // _showErrorMessage(_formStore.formErrorStore.userId.toString());

      _formStore.isLoading = false;

      return;
    }

    _formStore.login();
  }

  void _onRegister() async {
    var phoneNumber = '+7' + _maskFormatter2.getUnmaskedText().trim();
    var fullName = _fullnameController.text.trim();
    var email = _emailController.text.trim();

    _formStore.setFullName(fullName);
    _formStore.setUserId(phoneNumber);
    _formStore.setEmail(email);

    if (phoneNumber.isEmpty || fullName.isEmpty || email.isEmpty) {
      _inputKeyName.currentState?.setErrors();
      _inputKeyPhone2.currentState?.setErrors();
      _inputKeyEmail.currentState?.setErrors();

      Helpers.showInfoMessage(context, "Заполните все поля");

      // _showErrorMessage(_formStore.formErrorStore.register.toString());

      return;
    }

    _formStore.register();
  }

  // Widget _isLoggedIn(BuildContext context) {
  //   if (_userStore.isLoggedIn) {
  //     print("user is logged in");

  //     Future.delayed(Duration(milliseconds: 0), () {
  //       // go to nav home
  //       Navigator.of(context)
  //           .pushNamedAndRemoveUntil(Routes.home, (route) => false);
  //     });

  //     return Container();
  //   }

  //   print("user not logged in");
  //   return Container();
  // }

  Widget navigate(BuildContext context) {
    print("navigate called...login");

    Future.delayed(Duration(milliseconds: 0), () async {
      _formStore.success = false;
      // go to phone verify
      Navigator.of(context).pushNamed(Routes.verifyPhone);
      // pushNewScreen(context,
      //     screen: PhoneVerifyScreen(referer: 'login'),
      //     withNavBar: false,
      //     pageTransitionAnimation: PageTransitionAnimation.fade);
    });

    return Container(
        // child: Center(
        //   child: Text('test'),
        // ),
        );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    // _formStore.isLoading = false;

    print("error: $message");

    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        Helpers.showInfoMessage(context, message);
        // FlushbarHelper.createError(
        //   message: message,
        //   title: AppLocalizations.of(context).translate('home_tv_error'),
        //   duration: Duration(seconds: 3),
        // )..show(context);
      });
    }

    return SizedBox.shrink();
  }
}

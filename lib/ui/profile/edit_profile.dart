import 'package:another_flushbar/flushbar_helper.dart';
import 'package:esentai/stores/form/form_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/default_input_field_widget.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenWidgetState createState() =>
      _EditProfileScreenWidgetState();
}

class _EditProfileScreenWidgetState extends State<EditProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _inputKeyPhone = GlobalKey<DefaultInputFieldWidgetState>();
  final _inputKeyPhone2 = GlobalKey<DefaultInputFieldWidgetState>();
  final _inputKeyName = GlobalKey<DefaultInputFieldWidgetState>();
  final _inputKeyEmail = GlobalKey<DefaultInputFieldWidgetState>();

  late UserStore _userStore;
  late FormStore _formStore;

  late DefaultInputFieldWidget _phoneInput;
  late DefaultInputFieldWidget _userInput;
  late DefaultInputFieldWidget _emailInput;

  var _maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _formStore = Provider.of<FormStore>(context);

    if (_userStore.profile != null) {
      _fullnameController.text = _userStore.profile!.fullname!;
      _emailController.text = _userStore.profile!.email!;
      // _phoneController.text = _userStore.profile!.username!;

      _phoneController.value = TextEditingValue(
          text: _maskFormatter.maskText(_userStore.profile!.username!));
    }
  }

  @override
  Widget build(BuildContext context) {
    _phoneInput = DefaultInputFieldWidget(
      key: _inputKeyPhone,
      label: 'Номер телефона',
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
      hint: 'Имя Фамилия',
      keyboardType: TextInputType.name,
      leadingIconDefault: 'assets/images/ic_user_grey.png',
      leadingIconActive: 'assets/images/ic_user.png',
      color: DefaultAppTheme.textColor,
      controller: _fullnameController,
    );

    _emailInput = DefaultInputFieldWidget(
      key: _inputKeyEmail,
      label: 'Электронная почта',
      leadingIconDefault: 'assets/images/ic_email_grey.png',
      leadingIconActive: 'assets/images/ic_email.png',
      hint: 'Электронная почта',
      keyboardType: TextInputType.emailAddress,
      color: DefaultAppTheme.textColor,
      controller: _emailController,
    );

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: DefaultAppTheme.primaryColor,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            'Профиль',
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
        body: _buildBody());
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          _buildMainBody(),
          Observer(builder: (context) {
            return _userStore.successProfile
                ? navigate(context)
                : Helpers.showErrorMessage(
                    context, _formStore.errorStore.errorMessage);
          }),
          Observer(builder: (context) {
            return Visibility(
              visible: _userStore.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMainBody() {
    return Observer(builder: (context) {
      return Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 0),
                child: _userInput,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: _phoneInput,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: _emailInput,
              )
            ],
          ),
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 32),
              child: ElevatedButton(
                  onPressed: () async {
                    var username =
                        "+7" + _maskFormatter.unmaskText(_phoneController.text);
                    var fullname = _fullnameController.text;
                    var email = _emailController.text;

                    print("$username, $fullname, $email");

                    if (username.isEmpty || fullname.isEmpty || email.isEmpty) {
                      Future.delayed(Duration(seconds: 0), () {
                        FlushbarHelper.createError(
                            message: 'Заполните все поля',
                            title: 'Ошибка',
                            duration: Duration(seconds: 3))
                          ..show(context);
                      });
                      return;
                    }

                    await _userStore.editProfile(username, fullname, email);
                    Navigator.of(context).pop();
                  },
                  child: Text('Сохранить'),
                  style: DefaultAppTheme.buttonDefaultStyle),
            ),
          )
        ],
      );
    });
  }

  Widget navigate(BuildContext context) {
    if (_userStore.profile != null) {
      Future.delayed(Duration(seconds: 0), () {
        FlushbarHelper.createSuccess(
            message: 'Профиль обновлен',
            title: 'Успех',
            duration: Duration(seconds: 3))
          ..show(context);
      });
    }

    _userStore.successProfile = false;

    print("navigate called... edit profile");

    return Container();
  }
}

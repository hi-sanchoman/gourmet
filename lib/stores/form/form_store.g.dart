// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_FormStore.canLogin'))
      .value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_FormStore.canRegister'))
          .value;
  Computed<bool>? _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_FormStore.canForgetPassword'))
      .value;
  Computed<bool>? _$canEditProfileComputed;

  @override
  bool get canEditProfile =>
      (_$canEditProfileComputed ??= Computed<bool>(() => super.canEditProfile,
              name: '_FormStore.canEditProfile'))
          .value;

  final _$userIdAtom = Atom(name: '_FormStore.userId');

  @override
  String get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$emailAtom = Atom(name: '_FormStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$birthdayAtom = Atom(name: '_FormStore.birthday');

  @override
  String get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(String value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  final _$fullNameAtom = Atom(name: '_FormStore.fullName');

  @override
  String get fullName {
    _$fullNameAtom.reportRead();
    return super.fullName;
  }

  @override
  set fullName(String value) {
    _$fullNameAtom.reportWrite(value, super.fullName, () {
      super.fullName = value;
    });
  }

  final _$codeAtom = Atom(name: '_FormStore.code');

  @override
  String get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  final _$authModeAtom = Atom(name: '_FormStore.authMode');

  @override
  String get authMode {
    _$authModeAtom.reportRead();
    return super.authMode;
  }

  @override
  set authMode(String value) {
    _$authModeAtom.reportWrite(value, super.authMode, () {
      super.authMode = value;
    });
  }

  final _$successAtom = Atom(name: '_FormStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$successSMSAtom = Atom(name: '_FormStore.successSMS');

  @override
  bool get successSMS {
    _$successSMSAtom.reportRead();
    return super.successSMS;
  }

  @override
  set successSMS(bool value) {
    _$successSMSAtom.reportWrite(value, super.successSMS, () {
      super.successSMS = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_FormStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$loginResponseAtom = Atom(name: '_FormStore.loginResponse');

  @override
  LoginResponse? get loginResponse {
    _$loginResponseAtom.reportRead();
    return super.loginResponse;
  }

  @override
  set loginResponse(LoginResponse? value) {
    _$loginResponseAtom.reportWrite(value, super.loginResponse, () {
      super.loginResponse = value;
    });
  }

  final _$tokenResponseAtom = Atom(name: '_FormStore.tokenResponse');

  @override
  TokenResponse? get tokenResponse {
    _$tokenResponseAtom.reportRead();
    return super.tokenResponse;
  }

  @override
  set tokenResponse(TokenResponse? value) {
    _$tokenResponseAtom.reportWrite(value, super.tokenResponse, () {
      super.tokenResponse = value;
    });
  }

  final _$registerAsyncAction = AsyncAction('_FormStore.register');

  @override
  Future<dynamic> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  final _$resendSMSAsyncAction = AsyncAction('_FormStore.resendSMS');

  @override
  Future<dynamic> resendSMS() {
    return _$resendSMSAsyncAction.run(() => super.resendSMS());
  }

  final _$loginAsyncAction = AsyncAction('_FormStore.login');

  @override
  Future<dynamic> login({dynamic mode = 'login'}) {
    return _$loginAsyncAction.run(() => super.login(mode: mode));
  }

  final _$activateUserAsyncAction = AsyncAction('_FormStore.activateUser');

  @override
  Future<dynamic> activateUser({dynamic mode = 'login'}) {
    return _$activateUserAsyncAction.run(() => super.activateUser(mode: mode));
  }

  final _$registerDeviceAsyncAction = AsyncAction('_FormStore.registerDevice');

  @override
  Future<dynamic> registerDevice() {
    return _$registerDeviceAsyncAction.run(() => super.registerDevice());
  }

  final _$getTokenAsyncAction = AsyncAction('_FormStore.getToken');

  @override
  Future<dynamic> getToken() {
    return _$getTokenAsyncAction.run(() => super.getToken());
  }

  final _$forgotPasswordAsyncAction = AsyncAction('_FormStore.forgotPassword');

  @override
  Future<dynamic> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
  }

  final _$logoutAsyncAction = AsyncAction('_FormStore.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void setUserId(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFullName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setFullName');
    try {
      return super.setFullName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setBirthday');
    try {
      return super.setBirthday(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCode(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAuthMode(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setAuthMode');
    try {
      return super.setAuthMode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoginResponse(LoginResponse value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setLoginResponse');
    try {
      return super.setLoginResponse(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserId(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUserId');
    try {
      return super.validateUserId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateFullName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateFullName');
    try {
      return super.validateFullName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userId: ${userId},
email: ${email},
birthday: ${birthday},
fullName: ${fullName},
code: ${code},
authMode: ${authMode},
success: ${success},
successSMS: ${successSMS},
isLoading: ${isLoading},
loginResponse: ${loginResponse},
tokenResponse: ${tokenResponse},
canLogin: ${canLogin},
canRegister: ${canRegister},
canForgetPassword: ${canForgetPassword},
canEditProfile: ${canEditProfile}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_FormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_FormErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool>? _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_FormErrorStore.hasErrorInForgotPassword'))
      .value;

  final _$userIdAtom = Atom(name: '_FormErrorStore.userId');

  @override
  String? get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String? value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$fullNameAtom = Atom(name: '_FormErrorStore.fullName');

  @override
  String? get fullName {
    _$fullNameAtom.reportRead();
    return super.fullName;
  }

  @override
  set fullName(String? value) {
    _$fullNameAtom.reportWrite(value, super.fullName, () {
      super.fullName = value;
    });
  }

  final _$emailAtom = Atom(name: '_FormErrorStore.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$registerAtom = Atom(name: '_FormErrorStore.register');

  @override
  String? get register {
    _$registerAtom.reportRead();
    return super.register;
  }

  @override
  set register(String? value) {
    _$registerAtom.reportWrite(value, super.register, () {
      super.register = value;
    });
  }

  @override
  String toString() {
    return '''
userId: ${userId},
fullName: ${fullName},
email: ${email},
register: ${register},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword}
    ''';
  }
}

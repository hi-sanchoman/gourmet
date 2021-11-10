import 'package:dio/dio.dart';
import 'package:esentai/constants/app_config.dart';
import 'package:esentai/data/repository.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/auth/login_response.dart';
import 'package:esentai/models/auth/token_response.dart';
import 'package:esentai/stores/error/error_store.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _FormStore(Repository repository) : this._repository = repository {
    _setupDisposers();
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => successSMS, (_) => successSMS = false, delay: 200),
    ];
  }

  void _setupValidations() {
    _disposers = [
      reaction((_) => userId, validateUserId),
      reaction((_) => email, validateEmail),
      reaction((_) => fullName, validateFullName)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userId = '';

  @observable
  String email = '';

  @observable
  String birthday = '';

  @observable
  String fullName = '';

  @observable
  String code = '';

  @observable
  String authMode = '';

  @observable
  bool success = false;

  @observable
  bool successSMS = false;

  @observable
  bool isLoading = false;

  @observable
  LoginResponse? loginResponse;

  @observable
  TokenResponse? tokenResponse;

  @computed
  bool get canLogin => !formErrorStore.hasErrorsInLogin && userId.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userId.isNotEmpty &&
      email.isNotEmpty &&
      fullName.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userId.isNotEmpty;

  @computed
  bool get canEditProfile =>
      !formErrorStore.hasErrorsInRegister &&
      userId.isNotEmpty &&
      email.isNotEmpty &&
      fullName.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userId = value;
  }

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setFullName(String value) {
    fullName = value;
  }

  @action
  void setBirthday(String value) {
    birthday = value;
  }

  @action
  void setCode(String value) {
    code = value;
  }

  @action
  setAuthMode(String value) {
    authMode = value;
  }

  @action
  void setLoginResponse(LoginResponse value) {
    loginResponse = value;
  }

  @action
  void validateUserId(String value) {
    // print("validate: ${value.length}");

    if (value.isEmpty) {
      formErrorStore.userId = "Phone number can't be empty";
    } else if (value.length != AppConfig.phone_number_length) {
      formErrorStore.userId = 'Please enter a valid phone number';
    } else {
      formErrorStore.userId = null;
    }
  }

  @action
  void validateEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.register = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.register = "Please enter a valid email address";
    } else {
      formErrorStore.email = null;
    }
  }

  @action
  void validateFullName(String value) {
    // print(value);

    if (value.isEmpty) {
      formErrorStore.register = "FullName can't be empty";
    } else {
      formErrorStore.register = null;
    }
  }

  @action
  Future register() async {
    isLoading = true;
    authMode = 'register';

    await _repository.register(userId, email, fullName, birthday).then((res) {
      isLoading = false;

      if (res is LoginResponse) {
        success = true;
        loginResponse = res;
      }
    }).catchError((e) {
      isLoading = false;
      success = false;

      // throw e;

      late DioError? err;
      bool isRx = false;

      try {
        err = e as DioError;
      } catch (e) {
        isRx = true;
        err = null;
      }

      if (err is DioError && err.response != null && !isRx) {
        print("login error: ${e.response!.data['error']}");

        if (err.response!.data['email'] != null) {
          errorStore.errorMessage = 'Пользователь с такой почтой существует';
        } else if (err.response!.data['birthday'] != null) {
          errorStore.errorMessage = 'Укажите ваш день рождения';
        } else if (err.response!.data['error'] != null) {
          errorStore.errorMessage = 'Пользователь с таким номером существует';
        } else {
          errorStore.errorMessage =
              'Ошибка на сервере. Попробуйте другой сотовый оператор';
        }
      } else {
        errorStore.errorMessage = 'Ошибка на сервере. Попробуйте еще раз.';
      }
    });
  }

  @action
  Future resendSMS() async {
    isLoading = false;
    await _repository.resendSMS(userId).then((res) {
      isLoading = false;

      if (res is LoginResponse) {
        successSMS = true;
        loginResponse = res;
      }
    }).catchError((e) {
      isLoading = false;
      successSMS = false;

      errorStore.errorMessage = 'Ошибка на сервере. Попробуйте еще раз.';
    });
  }

  @action
  Future login({mode = 'login'}) async {
    isLoading = true;
    authMode = 'login';

    await _repository.login(userId).then((res) {
      isLoading = false;

      if (res is LoginResponse) {
        loginResponse = res;

        if (mode == 'login')
          success = true;
        else
          successSMS = true;
      }

      // print("login response: $res");
    }).catchError((e) {
      isLoading = false;

      if (mode == 'login')
        success = false;
      else
        successSMS = false;

      DioError err = e as DioError;

      if (err.response != null) {
        print("login error: ${e.response!.data['error']}");

        if (err.response!.data['error'].contains('No such user')) {
          errorStore.errorMessage = 'Пользователь не существует';
        }
      } else {
        errorStore.errorMessage = 'Ошибка на сервере. Попробуйте еще раз.';
      }
    });
  }

  @action
  Future activateUser({mode = 'login'}) async {
    isLoading = true;

    await _repository.activateUser(userId, code).then((res) {
      isLoading = false;

      if (res is LoginResponse) {
        loginResponse = res;

        if (res.message!.contains('RX loyalty')) {
          throw Exception();
        } else {
          successSMS = true;
        }
      }

      // print("login response: $res");
    }).catchError((e) {
      isLoading = false;
      successSMS = false;

      // DioError err = e as DioError;
      errorStore.errorMessage = 'Ошибка: неверный код';
    });
  }

  @action
  Future registerDevice() async {
    // isLoading = true;

    // await _repository.registerDevice(userId, code).then((res) {
    //   isLoading = false;

    //   if (res is LoginResponse) {
    //     loginResponse = res;

    //     if (mode == 'login')
    //       success = true;
    //     else
    //       successSMS = true;
    //   }

    //   // print("login response: $res");
    // }).catchError((e) {
    //   isLoading = false;

    //   if (mode == 'login')
    //     success = false;
    //   else
    //     successSMS = false;

    //   errorStore.errorMessage = e.toString().contains('No such user')
    //       ? 'Нет такого пользователя'
    //       : e.toString();
    //   print(e);
    // });
  }

  @action
  Future getToken() async {
    isLoading = true;

    await _repository.getToken(userId, userId).then((res) {
      isLoading = false;

      if (res is TokenResponse) {
        successSMS = true;
        tokenResponse = res;
      }
    }).catchError((e) {
      isLoading = false;
      successSMS = false;

      errorStore.errorMessage = e.toString();
      // print(e);
    });
  }

  @action
  Future forgotPassword() async {
    isLoading = true;
  }

  @action
  Future logout() async {
    isLoading = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateFullName(fullName);
    validateEmail(email);
    validateUserId(userId);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? userId;

  @observable
  String? fullName;

  @observable
  String? email;

  @observable
  String? register;

  @computed
  bool get hasErrorsInLogin => userId != null;

  @computed
  bool get hasErrorsInRegister =>
      userId != null || fullName != null || email != null;

  @computed
  bool get hasErrorInForgotPassword => userId != null;
}

import 'package:esentai/ui/cart/cart.dart';
import 'package:esentai/ui/food_details/food_details.dart';
import 'package:esentai/ui/home/home.dart';
import 'package:esentai/ui/home/navbarscreen.dart';
import 'package:esentai/ui/login/login.dart';
import 'package:esentai/ui/login/success.dart';
import 'package:esentai/ui/onboarding/onboarding.dart';
import 'package:esentai/ui/orders/orders.dart';
import 'package:esentai/ui/payment/payment_result.dart';
import 'package:esentai/ui/profile/edit_profile.dart';
import 'package:esentai/ui/profile/profile.dart';
import 'package:esentai/ui/splash/splash.dart';
import 'package:esentai/ui/verify_phone/verify_phone.dart';
import 'package:esentai/widgets/order_details_widget.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';

  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String verifyPhone = '/verifyPhone';
  static const String success = '/success';

  static const String home = '/home';
  static const String search = '/search';
  static const String infoPage = '/infoPage';
  static const String bannerPage = '/bannerPage';
  static const String product = '/product';
  static const String packages = '/packages';

  static const String catalog = '/catalog';
  static const String category = '/category';
  static const String subcategory = '/subcategory';

  static const String cart = '/cart';
  static const String newOrder = '/newOrder';
  static const String addAddress = '/addAddress';
  static const String addressFromMap = '/addressFromMap';
  static const String confirmOrder = '/confirmOrder';
  static const String promocode = '/promocode';
  static const String payWithBonus = '/payWithBonus';
  static const String addCard = '/addCard';

  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String myOrders = '/myOrders';
  static const String order = '/orderDetails';

  static const String favorites = '/favorites';

  static const String paymentResult = '/payment/result';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),

    onboarding: (BuildContext context) => OnBoardingScreen(),
    login: (BuildContext context) => LoginScreen(),
    verifyPhone: (BuildContext context) => PhoneVerifyScreen(
          referer: '',
        ),
    success: (BuildContext context) => SuccessScreen(),

    home: (BuildContext context) => NavBarScreen(),
    // search: (BuildContext context) => ,
    // infoPage: (BuildContext context) => ,
    // bannerPage: (BuildContext context) => ,
    product: (BuildContext context) => FoodDetailsScreen(),
    // packages: (BuildContext context) => ,

    cart: (BuildContext context) => CartScreen(),
    // newOrder: (BuildContext context) => ,
    // addAddress: (BuildContext context) => ,
    // addressFromMap: (BuildContext context) => ,
    // confirmOrder: (BuildContext context) => ,
    // promocode: (BuildContext context) => ,
    // payWithBonus (BuildContext context) => ,
    // addCard: (BuildContext context) => ,

    profile: (BuildContext context) => ProfileScreen(),
    editProfile: (BuildContext context) => EditProfileScreen(),
    myOrders: (BuildContext context) => OrdersScreen(),
    // +orderDetails

    // +paymentResult: (BuildContext context) => PaymentResultScreen(message: 'message')

    // favorites: (BuildContext context) => FavoritesScreen(),
  };
}

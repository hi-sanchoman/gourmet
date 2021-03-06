import 'dart:convert';

import 'package:esentai/constants/app_theme.dart';
import 'package:esentai/constants/strings.dart';
import 'package:esentai/data/navigation_service.dart';
import 'package:esentai/data/repository.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/di/components/service_locator.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/payment/creditcard.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/cart/gift_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/stores/form/form_store.dart';
import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/ui/home/navbarscreen.dart';
import 'package:esentai/ui/orders/orders.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/stores/language/language_store.dart';
import 'package:esentai/stores/post/post_store.dart';
import 'package:esentai/stores/theme/theme_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/onboarding/onboarding.dart';
import 'package:esentai/utils/locale/app_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  '???????????? ??????????????????????', // title
  description: '???????? ?????????? ???????????????????????? ?????? ???????????? ??????????????????????.', // description
  importance: Importance.high,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('data: ${message.data}');

  Helpers.setNotificationsBadge();

  // flutterLocalNotificationsPlugin.show(
  //     message.data.hashCode,
  //     message.data['title'],
  //     message.data['body'],
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         channelDescription: channel.description,
  //       ),
  //     ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, this.initScreen}) : super(key: key);

  int? initScreen;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final PostStore _postStore = PostStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());
  final FormStore _formStore = FormStore(getIt<Repository>());
  final CatalogStore _catalogStore = CatalogStore(getIt<Repository>());
  final CartStore _cartStore = CartStore();
  final GiftStore _giftStore = GiftStore();
  final OrderStore _orderStore = OrderStore(getIt<Repository>());

  final GlobalKey<NavigatorState> _navigatorKey =
      // GlobalKey(debugLabel: "MainNavigator");
      getIt<NavigationService>().navigatorKey;

  @override
  void initState() {
    super.initState();

    // init fcm
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print("fireabse closed app msg");

      if (message != null) {
        RemoteNotification? notification = message.notification;

        if (notification != null && !kIsWeb) {
          print("data: ${message.data}");

          if (message.data.containsKey('order_id')) {
            _navigatorKey.currentState!
                .push(MaterialPageRoute(builder: (context) {
              return OrdersScreen();
            }));
          }
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("on foreground message");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && !kIsWeb) {
        print('if case');
        print('data: ${message.data}');

        Helpers.setNotificationsBadge();

        if (android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: 'launch_background',
                ),
              ));
        }
      } else {
        print('else case');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

      RemoteNotification? notification = message.notification;

      if (notification != null && !kIsWeb) {
        print("data onmessageopened: ${message.data}");

        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return OrdersScreen();
        // }));

        if (message.data.containsKey("order_id")) {
          _navigatorKey.currentState!
              .push(MaterialPageRoute(builder: (context) {
            return OrdersScreen();
          }));
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // print("from my app: ${_userStore.isLoggedIn}");

    _initFromShared();

    _initLastOrder();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<FormStore>(create: (_) => _formStore),
        Provider<CatalogStore>(create: (_) => _catalogStore),
        Provider<CartStore>(create: (_) => _cartStore),
        Provider<GiftStore>(create: (_) => _giftStore),
        Provider<OrderStore>(create: (_) => _orderStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            locale: Locale(_languageStore.locale),
            routes: Routes.routes,
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            // home: TestScreen(),
            home: _userStore.isLoggedIn ? NavBarScreen() : _initScreen(),
          );
        },
      ),
    );
  }

  Widget SomethingWentWrong() {
    return Container(
      child: Center(child: Text('???????????? ??????????????????????????. ???????????????????? ??????????')),
    );
  }

  Widget _initScreen() {
    return widget.initScreen == 1 ? NavBarScreen() : OnBoardingScreen();
  }

  void _initFromShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // current address
    String? currentAddressString =
        await prefs.getString(Preferences.current_address);

    if (currentAddressString != null && currentAddressString.isNotEmpty) {
      _userStore.currentAddress = Address.fromJson(currentAddressString);
      _orderStore.address = _userStore.currentAddress;
    }

    // current payment card
    String? currentCardString = await prefs.getString(Preferences.current_card);

    if (currentCardString != null && currentCardString.isNotEmpty) {
      print("current card: $currentCardString");

      _userStore.currentCard = CreditCard.fromJson(currentCardString);
      _userStore.currentPaymentMethod = 1;
      _orderStore.paymentId = '1'; // by credit card
      print('current card: ${_userStore.currentCard}');
    }
  }

  void _initLastOrder() {
    // _orderStore.getLastOrder();
  }

  Widget _buildLastOrder() {
    return Observer(builder: (context) {
      return Container(
        color: Colors.red,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
      );
    });
  }
}

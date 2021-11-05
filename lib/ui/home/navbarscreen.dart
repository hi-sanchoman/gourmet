import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/cart/cart.dart';
import 'package:esentai/ui/catalog/catalog.dart';
import 'package:esentai/ui/home/home.dart';
import 'package:esentai/ui/login/login.dart';
import 'package:esentai/ui/payment/payment_result.dart';
import 'package:esentai/ui/profile/profile.dart';
import 'package:esentai/ui/verify_phone/verify_phone.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class NavBarScreen extends StatefulWidget {
  NavBarScreen({Key? key, this.initialPage}) : super(key: key);

  String? initialPage = 'HomeScreen';

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

/// This is the private State class that goes with NavBarScreen.
class _NavBarScreenState extends State<NavBarScreen> {
  String _currentPage = 'HomeScreen';
  int _currentIndex = 0;

  late UserStore _userStore;
  late CartStore _cartStore;
  late PersistentTabController _controller;
  bool _hideNavBar = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;

    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _cartStore = Provider.of<CartStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    // GlobalKey navbarKey = GlobalKey();

    return Scaffold(
        // key: navbarKey,
        backgroundColor: Color(0xFFFCFCFC),
        body: Observer(builder: (context) {
          print(_cartStore.cartResponseWrapper);

          return PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: false,
            navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                ? 0.0
                : kBottomNavigationBarHeight,
            hideNavigationBarWhenKeyboardShows: true,
            margin: EdgeInsets.all(0.0),
            popActionScreens: PopActionScreensType.all,
            bottomScreenMargin: 0.0,
            hideNavigationBar: _hideNavBar,
            navBarStyle: NavBarStyle.style5,
          );
        }));
  }

  List<Widget> _buildScreens() {
    return [HomeScreen(), CatalogScreen(), CartScreen(), ProfileScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: ImageIcon(AssetImage('assets/images/ic_navbar_home.png'),
              size: 25),
          activeColorPrimary: DefaultAppTheme.primaryColor,
          inactiveColorPrimary: DefaultAppTheme.grayDark,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
            // '/home': (context) => NavBarScreen(),
            '/login': (context) => LoginScreen(),
            '/verifyPhone': (context) => PhoneVerifyScreen(referer: 'referer')
          }),
          title: 'Home'),
      PersistentBottomNavBarItem(
          icon: ImageIcon(AssetImage('assets/images/ic_navbar_catalog.png'),
              size: 25),
          activeColorPrimary: DefaultAppTheme.primaryColor,
          inactiveColorPrimary: DefaultAppTheme.grayDark,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
            // '/home': (context) => NavBarScreen(),
            '/login': (context) => LoginScreen(),
            '/verifyPhone': (context) => PhoneVerifyScreen(referer: 'referer')
          }),
          title: 'Catalog'),
      PersistentBottomNavBarItem(
          // icon: ImageIcon(AssetImage('assets/images/ic_navbar_cart.png'),
          icon: new Stack(alignment: Alignment.center, children: <Widget>[
            new ImageIcon(AssetImage('assets/images/ic_navbar_cart.png'),
                size: 25),
            if (!_cartStore.cartIsEmpty())
              new Positioned(
                // draw a red marble
                top: 6,
                right: 0,
                child: new Icon(Icons.brightness_1,
                    size: 12.0, color: DefaultAppTheme.secondaryColor),
              )
          ]),
          activeColorPrimary: DefaultAppTheme.primaryColor,
          inactiveColorPrimary: DefaultAppTheme.grayDark,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
            // '/home': (context) => NavBarScreen(),
            '/login': (context) => LoginScreen(),
            '/verifyPhone': (context) => PhoneVerifyScreen(referer: 'referer')
          }),
          title: 'Cart'),
      PersistentBottomNavBarItem(
          icon: ImageIcon(AssetImage('assets/images/ic_navbar_user.png'),
              size: 25),
          activeColorPrimary: DefaultAppTheme.primaryColor,
          inactiveColorPrimary: DefaultAppTheme.grayDark,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
            // '/home': (context) => NavBarScreen(),
            '/login': (context) => LoginScreen(),
            '/verifyPhone': (context) => PhoneVerifyScreen(referer: 'referer')
          }),
          title: 'Profile'),
    ];
  }
}

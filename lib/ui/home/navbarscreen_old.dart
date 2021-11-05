import 'package:esentai/ui/cart/cart.dart';
import 'package:esentai/ui/catalog/catalog.dart';
import 'package:esentai/ui/home/home.dart';
import 'package:esentai/ui/profile/profile.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      HomeScreen(),
      CatalogScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: DefaultAppTheme.grayLight,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  activeIcon: ImageIcon(
                      AssetImage('assets/images/ic_navbar_home_active.png'),
                      size: 25),
                  icon: ImageIcon(
                      AssetImage('assets/images/ic_navbar_home.png'),
                      size: 25),
                  label: 'Home'),
              BottomNavigationBarItem(
                  activeIcon: ImageIcon(
                      AssetImage('assets/images/ic_navbar_catalog_active.png'),
                      size: 25),
                  icon: ImageIcon(
                      AssetImage('assets/images/ic_navbar_catalog.png'),
                      size: 25),
                  label: 'Catalog'),
              BottomNavigationBarItem(
                  activeIcon: ImageIcon(
                      AssetImage('assets/images/ic_navbar_cart_active.png'),
                      size: 25),
                  icon: ImageIcon(
                      AssetImage('assets/images/ic_navbar_cart.png'),
                      size: 25),
                  label: 'Cart'),
              BottomNavigationBarItem(
                  activeIcon: ImageIcon(
                      AssetImage('assets/images/ic_navbar_user_active.png'),
                      size: 25),
                  icon: ImageIcon(
                      AssetImage('assets/images/ic_navbar_user.png'),
                      size: 25),
                  label: 'Profile'),
            ],
            elevation: 8.0,
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: DefaultAppTheme.primaryColor,
            unselectedItemColor: Color(0xFF313234),
            onTap: (i) {
              setState(() {
                _currentIndex = i;
              });
            },
          ),
        ),
        body: _tabs[_currentIndex]);
    // body: IndexedStack(
    //   index: _currentIndex,
    //   children: _tabs,
    // ));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:esentai/models/info/banner.dart';
import 'package:esentai/models/info/info.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/ui/info/banner.dart';
// import 'package:esentai/ui/info/banner.dart';
import 'package:esentai/ui/info/info.dart';
import 'package:esentai/ui/notifications/notifications.dart';
import 'package:esentai/ui/orders/order_prepare.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/ui/catalog/product_card_widget.dart';
import 'package:esentai/widgets/category_card_widget.dart';
import 'package:esentai/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreen> {
  late TextEditingController searchFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late CatalogStore _catalogStore;
  late CartStore _cartStore;

  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
    searchFieldController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _catalogStore = Provider.of<CatalogStore>(context);
    _cartStore = Provider.of<CartStore>(context);

    if (!_catalogStore.isLoading) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: DefaultAppTheme.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(
          'Главная',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                _onNotificationPressed();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Image.asset('assets/images/ic_notification.png',
                    width: 20, height: 20),
              )),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFCFCFC),
      drawer: Container(
        width: 258,
        child: Drawer(
          elevation: 16,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(10),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 64, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo_black.svg',
                    width: 144,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 55, 0, 0),
                    child: Text(
                      'Сервис и помощь',
                      style: DefaultAppTheme.title2.override(
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pushNewScreen(context,
                          screen: InfoScreen(slug: 'delivery'),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.fade);
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(14, 21, 0, 0),
                      child: Text(
                        'Доставка',
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(14, 21, 0, 0),
                    child: InkWell(
                      onTap: () {
                        pushNewScreen(context,
                            screen: InfoScreen(slug: 'products'),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade);
                      },
                      child: Text(
                        'Товары',
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(14, 21, 0, 0),
                    child: InkWell(
                      onTap: () {
                        pushNewScreen(context,
                            screen: InfoScreen(slug: 'cousine'),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade);
                      },
                      child: Text(
                        'Кулинария',
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(14, 21, 0, 0),
                    child: InkWell(
                      onTap: () {
                        pushNewScreen(context,
                            screen: InfoScreen(slug: 'bar'),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade);
                      },
                      child: Text(
                        'Бар',
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(14, 21, 0, 0),
                    child: InkWell(
                      onTap: () {
                        pushNewScreen(context,
                            screen: InfoScreen(slug: 'loyalty'),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade);
                      },
                      child: Text(
                        'Программа лояльности',
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Text(
                      'О компании',
                      style: DefaultAppTheme.title2.override(
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(14, 21, 0, 0),
                    child: InkWell(
                      onTap: () {
                        pushNewScreen(context,
                            screen: InfoScreen(slug: 'contacts'),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade);
                      },
                      child: Text(
                        'Контакты',
                        style: DefaultAppTheme.bodyText1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Observer(builder: (context) {
        return SafeArea(
          child: Stack(children: [
            RefreshIndicator(
              onRefresh: () async {
                _loadData();
              },
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 44,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 22,
                              decoration: BoxDecoration(
                                color: DefaultAppTheme.primaryColor,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 22,
                              decoration: BoxDecoration(
                                color: Color(0xFFFCFCFC),
                              ),
                            )
                          ],
                        ),
                        SearchWidget(),
                      ],
                    ),
                  ),
                  _buildBannerList(),
                  _buildIndicators(),
                  SizedBox(height: 16),
                  _buildGifts(),
                  SizedBox(height: 32),
                  _buildCategories(),
                  SizedBox(height: 32),
                  _buildProducts(),
                ],
              ),
            ),
            _buildCartTotal(),
          ]),
        );
      }),
    );
  }

  Widget _buildBannerList() {
    return Observer(builder: (context) {
      // hide print
      // if (_catalogStore.bannerList != null) {
      //   for (var banner in _catalogStore.bannerList!.items!) print(banner);
      // }
      print("banner items");
      // print(_catalogStore.bannerList?.items?.length);

      return _catalogStore.bannerList != null
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: CarouselSlider(
                carouselController: _controller,
                items: _catalogStore.bannerList!.items!
                    .map((item) => InkWell(
                          onTap: () {
                            _onBannerPressed(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                boxShadow: [
                                  // BoxShadow(
                                  //   color: Colors.grey,
                                  //   offset: Offset(0.0, 1.0), //(x,y)
                                  //   blurRadius: 6.0,
                                  // ),
                                ],
                              ),
                              height: 193,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 0),
                                    fadeOutDuration: Duration(milliseconds: 0),
                                    imageUrl: '${item.image}',
                                    // placeholder: (context, url) =>
                                    //     CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/images/nophoto.png',
                                            width: double.infinity,
                                            height: 193),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  // autoPlay: true,
                  height: 210,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            )

          // ? Padding(
          //     padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Container(
          //             width: 16,
          //           ),
          //           for (BannerPage banner in _catalogStore.bannerList!.items!)
          //             InkWell(
          //               onTap: () {
          //                 _onBannerPressed(banner);
          //               },
          //               child: Padding(
          //                 padding: const EdgeInsets.only(right: 16.0),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(10),
          //                   child: SizedBox(
          //                     width: 200,
          //                     height: 145,
          //                     child: CachedNetworkImage(
          //                       fadeInDuration: Duration(milliseconds: 0),
          //                       fadeOutDuration: Duration(milliseconds: 0),
          //                       imageUrl: '${banner.image}',
          //                       // placeholder: (context, url) =>
          //                       //     CircularProgressIndicator(),
          //                       errorWidget: (context, url, error) =>
          //                           Image.asset('assets/images/nophoto.png',
          //                               width: 200, height: 146),
          //                       fit: BoxFit.cover,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //         ],
          //       ),
          //     ),
          //   )
          : Container();
    });
  }

  Widget _buildIndicators() {
    return Observer(builder: (context) {
      // print(_catalogStore.bannerList?.items?.length);

      return _catalogStore.bannerList != null
          ? Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _catalogStore.bannerList!.items!
                    .asMap()
                    .entries
                    .map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? DefaultAppTheme.textColor
                              : DefaultAppTheme.grayLight,
                        )),
                  );
                }).toList(),
              ),
            )
          : Container();
    });
  }

  // List<Widget> _getBanners() {
  //   List<Widget> widgets = [];

  //   for (BannerPage banner in _catalogStore.bannerList!.items!) {
  //     InkWell(
  //       onTap: () {
  //         _onBannerPressed(banner);
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.only(right: 16.0),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: SizedBox(
  //             width: MediaQuery.of(context).size.width,
  //             height: 193,
  //             child: CachedNetworkImage(
  //               fadeInDuration: Duration(milliseconds: 0),
  //               fadeOutDuration: Duration(milliseconds: 0),
  //               imageUrl: '${banner.image}',
  //               // placeholder: (context, url) =>
  //               //     CircularProgressIndicator(),
  //               errorWidget: (context, url, error) => Image.asset(
  //                   'assets/images/nophoto.png',
  //                   width: MediaQuery.of(context).size.width,
  //                   height: 193,
  //                   fit: BoxFit.cover),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  //   return widgets;
  // }

  Widget _buildGifts() {
    return Observer(builder: (context) {
      // hide print
      print(_catalogStore.mainGifts?.items?.length);

      return _catalogStore.mainGifts != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            child: Text(
                              'Подарочные наборы',
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                        ),
                        // Text(
                        //   'Все товары',
                        //   style: DefaultAppTheme.bodyText1.override(
                        //     fontFamily: 'Gilroy',
                        //     color: DefaultAppTheme.primaryColor,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  if (_catalogStore.mainGifts != null &&
                      _catalogStore.mainGifts!.items != null)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 0),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   width: 16,
                              // ),
                              for (var product
                                  in _catalogStore.mainGifts!.items!)
                                ProductCardWidget(
                                  product: product,
                                )
                            ]),
                      ),
                    ),
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildCategories() {
    return Observer(builder: (context) {
      // hide print
      print(_catalogStore.catalogList?.items?.length);

      return _catalogStore.catalogList != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                            child: Text(
                              'Категории',
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                        ),
                        // Text(
                        //   'Все товары',
                        //   style: DefaultAppTheme.bodyText1.override(
                        //     fontFamily: 'Gilroy',
                        //     color: DefaultAppTheme.primaryColor,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  if (_catalogStore.mainGifts != null &&
                      _catalogStore.mainGifts!.items != null)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 0),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              for (var category
                                  in _catalogStore.catalogList!.items!)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                  child: CategoryCardWidget(
                                    category: category,
                                  ),
                                )
                            ]),
                      ),
                    ),
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildProducts() {
    return Observer(builder: (context) {
      // hide print
      print(_catalogStore.mainList?.items?.length);

      var size = MediaQuery.of(context).size;

      /*24 is for notification bar on Android*/
      final double itemHeight = (size.height - kToolbarHeight - 96) / 2;
      final double itemWidth = size.width / 2;

      return _catalogStore.mainList != null
          ? Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                            child: Text(
                              'Новинки',
                              style: DefaultAppTheme.title2.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                        ),
                        // Text(
                        //   'Все товары',
                        //   style: DefaultAppTheme.bodyText1.override(
                        //     fontFamily: 'Gilroy',
                        //     color: DefaultAppTheme.primaryColor,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 108),
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 9,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        for (var product in _catalogStore.mainList!.items!)
                          ProductCardWidget(
                            product: product,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildCartTotal() {
    return Observer(builder: (context) {
      // hide print
      print(_cartStore.cartResponseWrapper);

      return Visibility(
          visible: !_cartStore.cartIsEmpty(),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 56),
              child: Container(
                height: 51,
                decoration: BoxDecoration(
                    color: DefaultAppTheme.tertiaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0))),
                child: InkWell(
                  onTap: () {
                    _onCheckout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text('Перейти к оплате: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text(
                            '${NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru").format(_cartStore.getTotalAmount())} тг',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }

  void _onCheckout() {
    pushNewScreen(context,
        screen: OrderPrepareScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  void _onBannerPressed(BannerPage banner) {
    pushNewScreen(context,
        screen: BannerScreen(
          banner: banner,
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  void _loadData() {
    _catalogStore.bannerList?.items?.clear();

    if (!_catalogStore.isLoading) {
      _catalogStore.getBanners();
      _catalogStore.getCategoryList();
      _catalogStore.getMainGifts();
      _catalogStore.getMainProducts();
    }
  }

  void _onNotificationPressed() {
    pushNewScreen(context,
        screen: NotificationsScreen(),
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

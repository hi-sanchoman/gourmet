import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/data/sharedpref/shared_preference_helper.dart';
import 'package:esentai/models/catalog/category.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/ui/_bottomsheets/bs_subcategory_filter.dart';
import 'package:esentai/ui/catalog/product_card_widget.dart';
import 'package:esentai/ui/orders/order_prepare.dart';
import 'package:esentai/utils/extensions/gourmet_gridview_delegate.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/choice_chips.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:esentai/widgets/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  _CategoryScreenScreenWidgetState createState() =>
      _CategoryScreenScreenWidgetState();
}

class _CategoryScreenScreenWidgetState extends State<CategoryScreen> {
  late Category _category;
  String _sortBy = 'name';
  bool _isActive = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late CatalogStore _catalogStore;
  late CartStore _cartStore;

  @override
  void initState() {
    super.initState();

    _category = widget.category;

    _checkPermissions();
  }

  void _checkPermissions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? hasPermissions = prefs.getInt(Preferences.hasPermissions);

    if (_category.hasPermissions == true && hasPermissions == null) {
      bool res = await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: new Text("Вам 21 год или больше?"),
                content: Text('${_category.permissionsText}'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Да'),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text("Нет"),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  )
                ],
              ));

      if (res == true) {
        // it's ok
        await prefs.setInt(Preferences.hasPermissions, 1);
        return;
      }

      // not ok
      Navigator.of(context).pop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // stores
    _catalogStore = Provider.of<CatalogStore>(context);
    _cartStore = Provider.of<CartStore>(context);

    _catalogStore.subcategoryList?.items?.clear();
    _catalogStore.filter?.clear();

    // get category
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, Category>;
    // print(args);

    // get products
    _catalogStore.filter = _category.subcategories!.items!.map((item) {
      print("subcategory: $item");
      return item.id!;
    }).toList();

    if (!_catalogStore.isLoading) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildMainBody(),
        Observer(builder: (context) {
          return _catalogStore.successProducts
              ? navigate(context)
              : Helpers.showErrorMessage(
                  context, _catalogStore.errorStore.errorMessage);
        }),
        Observer(builder: (context) {
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
        }),
      ],
    );
  }

  Widget _buildMainBody() {
    return Observer(builder: (context) {
      return RefreshIndicator(
        onRefresh: () async {
          _loadData();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                floating: false,
                pinned: true,
                snap: false,
                centerTitle: true,
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
                  '${_category.name}',
                  style: DefaultAppTheme.title2.override(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Observer(
                    builder: (context) {
                      print(_catalogStore.catalogList?.items?.length);

                      return _catalogStore.filter != null
                          ? Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: InkWell(
                                  onTap: () async {
                                    print(
                                        "filter length before: ${_catalogStore.filter!.length}");

                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      builder: (context) {
                                        return Wrap(
                                          children: [
                                            BsSubcategoryFilterWidget(
                                              subcategories:
                                                  _category.subcategories!,
                                            )
                                          ],
                                        );
                                      },
                                    );

                                    print(
                                        "filter length after: ${_catalogStore.filter!.length}");

                                    print('${_catalogStore.filter!.length}');

                                    _loadData();
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ImageIcon(
                                            AssetImage(
                                                'assets/images/ic_filter_new.png'),
                                            size: 25,
                                            color: Colors.white),
                                        Observer(builder: (context) {
                                          return _catalogStore.filter!.length <
                                                  _category.subcategories!
                                                      .items!.length
                                              ? Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(20, 0, 0, 0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      child: Container(
                                                        width: 16,
                                                        height: 16,
                                                        child: Center(
                                                            // child: Text(
                                                            //   '${_catalogStore.filter?.length}',
                                                            //   style: TextStyle(
                                                            //       color: Colors.white),
                                                            // ),
                                                            ),
                                                        color: DefaultAppTheme
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        })
                                      ],
                                    ),
                                  )))
                          : Container();
                    },
                  ),
                ],
                elevation: 0,
                bottom: AppBar(
                    backgroundColor: Color(0xFFFCFCFC),
                    titleSpacing: 0,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    title: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 22,
                          // color: Colors.red,
                          color: DefaultAppTheme.primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: SearchWidget(),
                        )
                      ],
                    ))),
            SliverList(
              delegate: SliverChildListDelegate([
                _buildFilter(),
                Stack(children: [
                  _buildListView(),
                  Observer(builder: (context) {
                    return Visibility(
                      visible: _catalogStore.isLoading,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          color: Color(0xFFFCFCFC),
                          // color: Colors.transparent,
                          child: Center(child: CircularProgressIndicator())),
                    );
                  }),
                ]),
                Container(
                  height: 120,
                ),
              ]),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildListView() {
    return Observer(builder: (context) {
      print(_catalogStore.subcategoryList?.items?.length);

      var size = MediaQuery.of(context).size;

      /*24 is for notification bar on Android*/
      final double itemHeight = (size.height - kToolbarHeight - 96) / 2;
      final double itemWidth = size.width / 2;

      return _catalogStore.subcategoryList != null &&
              _catalogStore.subcategoryList!.items != null &&
              _catalogStore.subcategoryList!.items!.length > 0
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 72),
              child: _buildSubcategory())
          : Container(
              padding: EdgeInsets.only(top: 150),
              width: double.infinity,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('Ничего не найдено',
                    //     style: DefaultAppTheme.title1
                    //         .override(color: DefaultAppTheme.grayLight)),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    //   child: Text(
                    //     'К сожалению, этих товаров сейчас нет',
                    //     style: DefaultAppTheme.bodyText2,
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                  ]),
            );
    });
  }

  Widget _buildSubcategory() {
    print(_catalogStore.subcategoryList?.items?.length);

    // get count
    int count = 0;

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 96) / 2;
    final double itemWidth = size.width / 2;

    return _catalogStore.subcategoryList != null &&
            _catalogStore.subcategoryList!.items != null &&
            _catalogStore.subcategoryList!.items!.length > 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                for (var subcategory in _catalogStore.subcategoryList!.items!)
                  if (subcategory.products != null &&
                      subcategory.products!.items != null &&
                      subcategory.products!.items!.length > 0)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Text(
                              '${subcategory.name}',
                              style: DefaultAppTheme.title2,
                            ),
                          ),
                          if (subcategory.products != null &&
                              subcategory.products!.items != null &&
                              subcategory.products!.items!.length > 0)
                            GridView(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: GourmetGridViewDelegate(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 9,
                                  mainAxisSpacing: 9,
                                  // childAspectRatio: 0.66,
                                  // childAspectRatio: itemWidth / itemHeight,
                                  height: 262),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                for (var product
                                    in subcategory.products!.items!)
                                  ProductCardWidget(
                                    product: product,
                                  )
                              ],
                            ),
                        ],
                      ),
                    )
              ],
            ))
        : Container(
            padding: EdgeInsets.only(top: 200),
            child: Text('not found'),
          );
  }

  Widget _buildFilter() {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: ChoiceChip(
                    label: Text('Есть в наличии'),
                    selected: _isActive == true,
                    onSelected: (val) {
                      _filter();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: ChoiceChip(
                  label: Text('По алфавиту'),
                  onSelected: (val) {
                    _sort('name');
                  },
                  selected: _sortBy == 'name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: ChoiceChip(
                  label: Text('По популярности'),
                  onSelected: (val) {
                    _sort('-name');
                  },
                  selected: _sortBy == '-name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: ChoiceChip(
                  label: Text('Сначала подешевле'),
                  onSelected: (val) {
                    _sort('price');
                  },
                  selected: _sortBy == 'price',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: ChoiceChip(
                  label: Text('Сначала подороже'),
                  onSelected: (val) {
                    _sort('-price');
                  },
                  selected: _sortBy == '-price',
                ),
              ),

              //   FlutterFlowChoiceChips(
              //     options: [
              //       // ChipData('Есть в наличие'),
              //       ChipData('По алфавиту'),
              //       ChipData('По популярности'),
              //       ChipData('Сначала подешевле'),
              //       ChipData('Сначала подороже'),
              //     ],
              //     onChanged: (val) {
              //       _sort(val);
              //     },
              //     selectedChipStyle: ChipStyle(
              //       backgroundColor: Color(0x00000000),
              //       textStyle: DefaultAppTheme.bodyText1.override(
              //         fontFamily: 'Gilroy',
              //         color: DefaultAppTheme.primaryColor,
              //       ),
              //       iconColor: Colors.white,
              //       iconSize: 18,
              //       elevation: 0,
              //     ),
              //     unselectedChipStyle: ChipStyle(
              //       backgroundColor: Color(0xFFF0F0F0),
              //       textStyle: DefaultAppTheme.bodyText2,
              //       iconColor: DefaultAppTheme.primaryColor,
              //       iconSize: 18,
              //       elevation: 0,
              //     ),
              //     chipSpacing: 20,
              //   ),
            ],
          ),
        ));
  }

  void _loadData() {
    // _catalogStore.getProducts(_catalogStore.filter!, _sortBy, _isActive);
    _catalogStore.getSubcategories(_catalogStore.filter!, _sortBy, _isActive);
  }

  void _filter() {
    setState(() {
      _isActive = !_isActive;
    });

    _loadData();
  }

  void _sort(String val) {
    setState(() {
      _sortBy = val;
    });

    print(' sort by $_sortBy');

    _loadData();
  }

  Widget navigate(BuildContext context) {
    print("navigate called... category");

    return Container();
  }

  void _onCheckout() {
    pushNewScreen(context,
        screen: OrderPrepareScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

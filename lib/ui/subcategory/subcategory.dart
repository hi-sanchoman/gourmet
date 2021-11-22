import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/catalog/category.dart';
import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/catalog/subcategory_list.dart';
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

class SubcategoryScreen extends StatefulWidget {
  SubcategoryScreen(
      {Key? key, required this.subcategory, required this.category})
      : super(key: key);

  final Subcategory subcategory;
  final Category category;

  @override
  _SubcategoryScreenWidgetState createState() =>
      _SubcategoryScreenWidgetState();
}

class _SubcategoryScreenWidgetState extends State<SubcategoryScreen> {
  late Subcategory _subcategory;
  List<int> _filterSubs = [];
  String _sortBy = 'name';

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isActive = true;

  late CatalogStore _catalogStore;
  late CartStore _cartStore;

  @override
  void initState() {
    super.initState();

    _checkPermissions();
  }

  void _checkPermissions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? hasPermissions = prefs.getInt(Preferences.hasPermissions);

    if (widget.category.hasPermissions == true && hasPermissions == null) {
      bool res = await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => WillPopScope(
              child: CupertinoAlertDialog(
                title: new Text("Вам 21 год или больше?"),
                content: Text('${widget.category.permissionsText}'),
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
              ),
              onWillPop: () async {
                return false;
              }));

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

    _catalogStore.productsList?.items?.clear();

    // get category
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, Category>;
    // print(args);

    _subcategory = widget.subcategory;

    // get products
    _filterSubs = [_subcategory.id!];

    if (!_catalogStore.isLoading) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFCFCFC),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildMainBody(),
        // Observer(builder: (context) {
        //   return Visibility(
        //     visible: _catalogStore.isLoading,
        //     child: CustomProgressIndicatorWidget(),
        //   );
        // }),
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
                automaticallyImplyLeading: true,
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
                  '${_subcategory.name}',
                  style: DefaultAppTheme.title2.override(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                  ),
                ),
                elevation: 0,
                bottom: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Color(0xFFFCFCFC),
                    titleSpacing: 0,
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
                _buildListView(),
                Container(
                  height: 140,
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
      print(_catalogStore.productsList?.items?.length);

      if (_catalogStore.productsList != null &&
          _catalogStore.productsList!.items!.isEmpty) {
        return Container(
          padding: EdgeInsets.only(top: 150),
          width: double.infinity,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ничего не найдено',
                    style: DefaultAppTheme.title1
                        .override(color: DefaultAppTheme.grayLight)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Text(
                    'К сожалению, этих товаров сейчас нет',
                    style: DefaultAppTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
        );
      }

      var size = MediaQuery.of(context).size;

      /*24 is for notification bar on Android*/
      final double itemHeight = (size.height - kToolbarHeight - 96) / 2;
      final double itemWidth = size.width / 2;

      return _catalogStore.productsList != null &&
              _catalogStore.productsList!.items != null
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 72),
              child: GridView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: GourmetGridViewDelegate(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    // childAspectRatio: itemWidth / itemHeight,
                    height: 262),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  for (var product in _catalogStore.productsList!.items!)
                    ProductCardWidget(
                      product: product,
                    )
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                  // child: Text('Нет товаров'),
                  ),
            );
    });
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
    print("in filter: $_filterSubs");
    // _catalogStore.productsList = null;
    _catalogStore.getProducts(_filterSubs, _sortBy, _isActive);
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

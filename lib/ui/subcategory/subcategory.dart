import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/catalog/subcategory_list.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/ui/_bottomsheets/bs_subcategory_filter.dart';
import 'package:esentai/ui/catalog/product_card_widget.dart';
import 'package:esentai/ui/orders/order_prepare.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/choice_chips.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:esentai/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SubcategoryScreen extends StatefulWidget {
  SubcategoryScreen({Key? key, required this.subcategory}) : super(key: key);

  final Subcategory subcategory;

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
      appBar: AppBar(
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
        actions: [
          // Padding(
          //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
          //     child: InkWell(
          //       onTap: () async {
          //         // print("${_category.subcategories?.items}");

          //         await showModalBottomSheet(
          //           isScrollControlled: true,
          //           useRootNavigator: true,
          //           context: context,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(10),
          //                 topRight: Radius.circular(10)),
          //           ),
          //           builder: (context) {
          //             return Wrap(
          //               children: [
          //                 CheckboxListTile(
          //                     value: _isActive,
          //                     title: Text('Есть в наличие'),
          //                     onChanged: (val) {
          //                       setState(() {
          //                         _isActive = val ?? false;
          //                       });
          //                     }),
          //               ],
          //             );
          //           },
          //         );

          //         _loadData();
          //       },
          //       child: Icon(
          //         Icons.filter_alt_outlined,
          //         color: Colors.white,
          //         size: 24,
          //       ),
          //     )),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFCFCFC),
      // backgroundColor: Colors.blue,
      body: SafeArea(child: _buildBody()),
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
      return Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              _loadData();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                SearchWidget(),
                _buildFilter(),
                _buildListView(),
                Container(
                  height: 140,
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Widget _buildListView() {
    print(_catalogStore.productsList?.items?.length);

    return Observer(builder: (context) {
      return _catalogStore.productsList != null &&
              _catalogStore.productsList!.items != null
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 72),
              child: GridView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                  childAspectRatio: 0.66,
                ),
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
      child: FlutterFlowChoiceChips(
        options: [
          // ChipData('Есть в наличие'),
          ChipData('По алфавиту'),
          ChipData('По популярности'),
          ChipData('Сначала подешевле'),
          ChipData('Сначала подороже'),
        ],
        onChanged: (val) => setState(() {
          _sort(val);
        }),
        selectedChipStyle: ChipStyle(
          backgroundColor: Color(0x00000000),
          textStyle: DefaultAppTheme.bodyText1.override(
            fontFamily: 'Gilroy',
            color: DefaultAppTheme.primaryColor,
          ),
          iconColor: Colors.white,
          iconSize: 18,
          elevation: 0,
        ),
        unselectedChipStyle: ChipStyle(
          backgroundColor: Color(0xFFF0F0F0),
          textStyle: DefaultAppTheme.bodyText2,
          iconColor: DefaultAppTheme.primaryColor,
          iconSize: 18,
          elevation: 0,
        ),
        chipSpacing: 20,
      ),
    );
  }

  void _loadData() {
    print("in filter: $_filterSubs");
    _catalogStore.getProducts(_filterSubs, _sortBy);
  }

  void _sort(String val) {
    // TODO:
    var orderBy = 'name';

    if (val.contains('Сначала подешевле')) {
      _sortBy = 'price';
    } else if (val.contains('Сначала подороже')) {
      _sortBy = '-price';
    } else if (val.contains('По алфавиту')) {
      _sortBy = 'name';
    }

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

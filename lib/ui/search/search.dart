import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/ui/catalog/product_card_widget.dart';
import 'package:esentai/ui/orders/order_prepare.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenWidgetState createState() => _SearchScreenWidgetState();
}

final _formKey = GlobalKey<FormState>();

class _SearchScreenWidgetState extends State<SearchScreen> {
  late CatalogStore _catalogStore;
  late CartStore _cartStore;

  late TextEditingController _textController;

  String _query = '';
  // FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // stores
    _catalogStore = Provider.of<CatalogStore>(context);
    _cartStore = Provider.of<CartStore>(context);

    _catalogStore.searchList?.items?.clear();
    // _catalogStore.filter?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _buildBody(),
      ),
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
        // Observer(builder: (context) {
        //   print(_cartStore.cartResponseWrapper);

        //   return Visibility(
        //       visible: !_cartStore.cartIsEmpty(),
        //       child: Align(
        //         alignment: Alignment.bottomCenter,
        //         child: Padding(
        //           padding: const EdgeInsets.only(bottom: 56),
        //           child: Container(
        //             height: 51,
        //             decoration: BoxDecoration(
        //                 color: DefaultAppTheme.tertiaryColor,
        //                 borderRadius: BorderRadius.only(
        //                     topLeft: Radius.circular(16.0),
        //                     topRight: Radius.circular(16.0))),
        //             child: InkWell(
        //               onTap: () {
        //                 _onCheckout();
        //               },
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Padding(
        //                     padding: EdgeInsets.only(left: 16.0),
        //                     child: Text('Перейти к оплате: ',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.w600,
        //                           fontSize: 17,
        //                         )),
        //                   ),
        //                   Padding(
        //                     padding: EdgeInsets.only(right: 16.0),
        //                     child: Text(
        //                         '${NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "ru").format(_cartStore.getTotalAmount())} тг',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.w600,
        //                           fontSize: 17,
        //                         )),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ));
        // }),
      ],
    );
  }

  Widget _buildMainBody() {
    return Observer(builder: (context) {
      return Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              _onSearch();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [_buildSearchInput(), _buildListView()],
            ),
          ),
          Observer(builder: (context) {
            return _catalogStore.isLoading
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container();
          }),
        ],
      );
    });
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: DefaultAppTheme.primaryColor),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: DefaultAppTheme.grayLight,
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(36),
            ),
            child: TextFormField(
              controller: _textController,
              onChanged: (val) {
                // print(val);

                setState(() {
                  _query = val;
                });

                _onSearch();
              },
              autofocus: true,
              // obscureText: false,
              decoration: InputDecoration(
                hintText: 'Поиск среди 5000 товаров',
                hintStyle: DefaultAppTheme.bodyText2,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(36),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(36),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 13, 20, 13),
              ),
              style: DefaultAppTheme.bodyText1,
              maxLines: 1,
              // focusNode: _focusNode,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        //   child: TextButton(
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //       child: Text('Отменить')),
        // )
      ]),
    );
  }

  Widget _buildListView() {
    return Observer(builder: (context) {
      print('rebuild');
      print(_catalogStore.searchList?.items?.length);

      // for (var subcategory in _catalogStore.searchList!.items!) {
      //   print(subcategory);

      //   for (var product in subcategory.products!) {
      //     print(product);
      //   }
      // }

      return _catalogStore.searchList != null &&
              _catalogStore.searchList!.items != null
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 92),
              child: Column(
                children: [
                  for (var subcategory in _catalogStore.searchList!.items!)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Text('${subcategory.name}'),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: GridView(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 9,
                              mainAxisSpacing: 9,
                              childAspectRatio: 0.66,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              if (subcategory.products != null)
                                for (var product in subcategory.products!)
                                  ProductCardWidget(
                                    product: Product(
                                        id: product['id'],
                                        name: product['name'],
                                        mainImage: product['main_image'],
                                        amount: product['amount'] ?? 0,
                                        price: double.tryParse(
                                            product['price'] ?? '0'),
                                        itemType: product['item_type'],
                                        isActive: product['is_active'] ?? false,
                                        isLiked: product['is_liked'] ?? false),
                                  ),
                              // Text('${product['name']}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
          : Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(''),
              ),
            );
    });
  }

  void _onCheckout() {
    pushNewScreen(context,
        screen: OrderPrepareScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  void _onSearch() {
    print("query is $_query");

    if (_query.length >= 2) {
      // print(_query);
      Future.delayed(Duration(milliseconds: 400), () {
        _catalogStore.searchProducts(_query);
      });
    }
  }
}

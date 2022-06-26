import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/favorites/favorite.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  _SubcategoryScreenWidgetState createState() =>
      _SubcategoryScreenWidgetState();
}

class _SubcategoryScreenWidgetState extends State<FavoritesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late CatalogStore _catalogStore;
  late CartStore _cartStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // stores
    _catalogStore = Provider.of<CatalogStore>(context);
    _cartStore = Provider.of<CartStore>(context);

    _catalogStore.favoritesList = null;
    _loadData();
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
          'Избранные товары',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
            color: Colors.white,
          ),
        ),
        actions: [],
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
      print(_catalogStore.favoritesList?.items?.length);

      // if (_catalogStore.favoritesList != null) {
      //   print(_catalogStore.favoritesList!.items);
      // }

      return Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              _loadData();
            },
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [_buildListView()],
            ),
          )
        ],
      );
    });
  }

  Widget _buildListView() {
    return Observer(builder: (context) {
      print("favorites... ${_catalogStore.favoritesList?.items?.length}");

      // if (_catalogStore.favoritesList == null) {
      //   return Container();
      // }

      var size = MediaQuery.of(context).size;

      /*24 is for notification bar on Android*/
      final double itemHeight = (size.height - kToolbarHeight - 96) / 2;
      final double itemWidth = size.width / 2;

      if (_catalogStore.favoritesList != null &&
          _catalogStore.favoritesList!.items != null &&
          _catalogStore.favoritesList!.items!.length <= 0) {
        return Container(
          padding: EdgeInsets.only(top: 200),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Тут пусто',
                    style: DefaultAppTheme.title1
                        .override(color: DefaultAppTheme.grayLight)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Text(
                    'Добавьте товар в избранные, нажав на иконку «сердце»',
                    style: DefaultAppTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
        );
      }

      return _catalogStore.favoritesList != null &&
              _catalogStore.favoritesList!.items != null &&
              _catalogStore.favoritesList!.items!.length > 0
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
              child: GridView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: GourmetGridViewDelegate(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    height: 262),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  for (Favorite favorite in _catalogStore.favoritesList!.items!)
                    _buildItem(favorite),
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildItem(Favorite product) {
    // print("build product... ${product}");

    if (product.favorite != null)
      return ProductCardWidget(
        product: Product(
            id: product.favorite!.id,
            name: product.favorite!.name,
            mainImage: product.favorite!.mainImage,
            amount: product.favorite!.amount,
            price: double.tryParse('${product.favorite!.price}'),
            itemType: product.favorite!.itemType,
            isActive: product.favorite!.isActive,
            minimumGram: product.favorite!.minimumGram,
            isLiked: true),
        // isFav: true,
      );

    if (product.gift != null)
      return ProductCardWidget(
        product: Product(
            id: product.gift!.id,
            name: product.gift!.name,
            mainImage: product.gift!.mainImage,
            amount: product.gift!.amount,
            price: double.tryParse("${product.gift!.price}"),
            itemType: product.gift!.itemType,
            isActive: product.gift!.isActive,
            isLiked: true),
        // isFav: true,
      );

    return Container();
  }

  Widget navigate(BuildContext context) {
    print("navigate called... favorites");

    return Container();
  }

  void _onCheckout() {
    pushNewScreen(context,
        screen: OrderPrepareScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  void _loadData() {
    // ?
    _catalogStore.favoritesList?.items?.clear();

    // get favorites
    if (!_catalogStore.isLoading) {
      _catalogStore.getFavorites();
    }
  }
}

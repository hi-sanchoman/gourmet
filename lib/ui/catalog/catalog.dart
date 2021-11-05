import 'package:esentai/models/catalog/category.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/stores/post/post_store.dart';
import 'package:esentai/ui/category/category.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/ui/catalog/category_header_widget.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:esentai/widgets/search_widget.dart';
import 'package:esentai/ui/catalog/subcategory_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatefulWidget {
  CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenWidgetState createState() => _CatalogScreenWidgetState();
}

class _CatalogScreenWidgetState extends State<CatalogScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late CatalogStore _catalogStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // catalog store
    _catalogStore = Provider.of<CatalogStore>(context);

    // check to see if already called api
    if (!_catalogStore.isLoading) {
      _catalogStore.getCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: DefaultAppTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Каталог',
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
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Stack(children: [
      _buildMainBody(),
      Observer(builder: (context) {
        return Container();
      }),
      Observer(builder: (context) {
        return Container();
      }),
    ]);
  }

  Widget _buildMainBody() {
    return Observer(builder: (context) {
      return _catalogStore.isLoading
          ? CustomProgressIndicatorWidget()
          : Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    if (!_catalogStore.isLoading) {
                      _catalogStore.getCategoryList();
                    }
                  },
                  child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        SearchWidget(),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Material(
                            child: _buildListView(),
                            color: Color(0xFFFCFCFC),
                          ),
                        )
                      ]),
                )
              ],
            );
    });
  }

  Widget _buildListView() {
    // print("catalog: ${_catalogStore.catalogList}");

    return _catalogStore.catalogList != null &&
            _catalogStore.catalogList!.items != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _catalogStore.catalogList!.items!.length,
            itemBuilder: (context, position) {
              return _buildListItem(position);
            })
        : Container(
            padding: EdgeInsets.only(top: 20),
            height: 120,
            color: Color(0xFFFCFCFC),
            child: Center(
              child: Text('Нет категорий'),
            ),
          );
  }

  Widget _buildListItem(int position) {
    return _catalogStore
            .catalogList!.items![position].subcategories!.items!.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: CategoryHeaderWidget(
                title: '${_catalogStore.catalogList?.items?[position].name}',
                onHeaderTap: () {
                  _onCategoryOpen(_catalogStore.catalogList?.items?[position]);
                },
                onAllItemsPressed: () {
                  _onCategoryOpen(_catalogStore.catalogList?.items?[position]);
                },
                subcategoryList:
                    _catalogStore.catalogList?.items?[position].subcategories),
          )
        : Container();
  }

  // on category clicked
  void _onCategoryOpen(Category? category) {
    pushNewScreen(context,
        screen: CategoryScreen(category: category!),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

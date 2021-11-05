import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/gift/package.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/ui/gift/postcard_picker.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class PackagePickerScreen extends StatefulWidget {
  PackagePickerScreen({Key? key, required this.gift}) : super(key: key);

  final Product gift;

  @override
  _PackagePickerScreenState createState() => _PackagePickerScreenState();
}

class _PackagePickerScreenState extends State<PackagePickerScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late CatalogStore _catalogStore;

  Package? _chosen;
  bool _picked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _catalogStore = Provider.of<CatalogStore>(context);

    // set curretn gift id
    _catalogStore.setGift(widget.gift);

    // load packages
    if (!_catalogStore.isLoading) {
      _catalogStore.getPackages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: DefaultAppTheme.primaryColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Выберите упаковку',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: DefaultAppTheme.background,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(
          builder: (context) {
            return _catalogStore.packageList == null
                ? _buildEmpty()
                : _buildList();
          },
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: ElevatedButton(
        //         onPressed: !_picked
        //             ? null
        //             : () {
        //                 _onSubmit();
        //               },
        //         child: Text('Готово'),
        //         style: DefaultAppTheme.buttonDefaultStyle),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildEmpty() {
    return Container(
        child: Center(
      child: Text(''),
    ));
  }

  Widget _buildList() {
    return Observer(builder: (context) {
      // print('rebuild');
      print(_catalogStore.packageList?.items?.length);

      return _catalogStore.packageList != null
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: ListView(
                padding: EdgeInsets.zero,
                // shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  ListTile(
                      onTap: () {
                        setState(() {
                          _picked = true;
                          _chosen = null;
                        });

                        _onSubmit();
                      },
                      title: Text('Без упаковки'),
                      trailing: Icon(Icons.arrow_forward_ios,
                          size: 24, color: DefaultAppTheme.grayLight)),
                  Divider(),
                  for (Package item in _catalogStore.packageList!.items!)
                    _buildItem(item),
                  Container(
                    height: 108,
                  ),
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

  Widget _buildItem(Package item) {
    return InkWell(
      onTap: () {
        setState(() {
          _chosen = item;
          _picked = true;
        });

        _onSubmit();
      },
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: SizedBox(
                        width: 125,
                        height: 125,
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 0),
                          fadeOutDuration: Duration(milliseconds: 0),
                          imageUrl: '${item.mainImage}',
                          errorWidget: (context, url, error) => Image.asset(
                              'assets/images/nophoto.png',
                              width: 125,
                              height: 125),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${item.name}',
                                        style: DefaultAppTheme.title2),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 16, 0, 0),
                                        child: Text('${item.price} тг',
                                            style: DefaultAppTheme.subtitle1
                                                .override(
                                                    color: DefaultAppTheme
                                                        .primaryColor))),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    size: 24, color: DefaultAppTheme.grayLight)
                              ],
                            ),
                          ],
                        )),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Divider(),
              ),
            ],
          )),
    );
  }

  void _onSubmit() {
    // set curret packageId in the store
    _catalogStore.setPackage(_chosen);

    // go to postcard chooser
    pushNewScreen(context,
        screen: PostcardPickerScreen(gift: widget.gift),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

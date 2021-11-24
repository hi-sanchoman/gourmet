import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/gift/package.dart';
import 'package:esentai/models/gift/postcard.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/postcard_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class PostcardPickerScreen extends StatefulWidget {
  PostcardPickerScreen({Key? key, required this.gift}) : super(key: key);

  final Product gift;

  @override
  _PackagePickerScreenState createState() => _PackagePickerScreenState();
}

class _PackagePickerScreenState extends State<PostcardPickerScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // final _inputKey = GlobalKey<DefaultInputFieldWidgetState>();

  late CatalogStore _catalogStore;
  late CartStore _cartStore;

  Postcard? _chosen;
  bool _picked = false;

  // late PostcardTextFieldWidget _textInput;
  // TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _catalogStore = Provider.of<CatalogStore>(context);
    _cartStore = Provider.of<CartStore>(context);

    // set curretn gift id
    _catalogStore.setGift(widget.gift);

    // load items
    if (!_catalogStore.isLoading) {
      _catalogStore.getPostcards();
    }
  }

  @override
  void dispose() {
    // _textController.dispose();
    super.dispose();
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
          'Выберите открытку',
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
      print(_catalogStore.postcardList?.items?.length);

      // print('rebuild');
      return _catalogStore.postcardList != null
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
                      title: Text('Без открытки'),
                      trailing: Icon(Icons.arrow_forward_ios,
                          size: 24, color: DefaultAppTheme.grayLight)),
                  Divider(),
                  for (Postcard item in _catalogStore.postcardList!.items!)
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

  Widget _buildItem(Postcard item) {
    return InkWell(
      onTap: () {
        setState(() {
          _chosen = item;
          _picked = true;
        });

        _showTextWidget();
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      child: Text('${item.name}',
                                          style: DefaultAppTheme.title2),
                                    ),
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
                                    size: 24, color: DefaultAppTheme.grayLight),
                              ],
                            ),
                          ],
                        )),
                  )
                ],
              ),
              // if (_chosen?.id == item.id) _textInput,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Divider(),
              ),
            ],
          )),
    );
  }

  void _showTextWidget() async {
    String message = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Wrap(
        children: [PostcardTextFieldWidget()],
      ),
    );

    if (_chosen != null && message.isNotEmpty) {
      _chosen!.setText(message);
    }

    _onSubmit();
  }

  void _onSubmit() {
    // set curret postcard in the store
    _catalogStore.setPostcard(_chosen);

    // submit to cart
    print(
        "add to cart: ${_catalogStore.gift}, ${_catalogStore.package} and ${_catalogStore.postcard}");

    _cartStore.addToCart(_catalogStore.gift!,
        package: _catalogStore.package, postcard: _catalogStore.postcard);

    // clear
    _catalogStore.setPostcard(null);
    _catalogStore.setPackage(null);
    _catalogStore.setGift(null);

    // go to home
    // return;
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.home, (route) => false);
    });
  }
}

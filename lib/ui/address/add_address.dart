import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/address/pick_on_map.dart';
import 'package:esentai/ui/address/suggestion.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/default_input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddNewAddressScreen extends StatefulWidget {
  AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  _AddNewAddressScreenWidgetState createState() =>
      _AddNewAddressScreenWidgetState();
}

class _AddNewAddressScreenWidgetState extends State<AddNewAddressScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;
  late OrderStore _orderStore;

  late TextEditingController _streetController;
  late TextEditingController _aptController;
  late TextEditingController _porchController;
  late TextEditingController _floorController;

  FocusNode _focus = FocusNode();

  String _address = '';

  // final _list = <Widget>[];
  // final _addressesFound = [];

  @override
  void initState() {
    super.initState();

    _streetController = TextEditingController();
    _aptController = TextEditingController();
    _porchController = TextEditingController();
    _floorController = TextEditingController();

    // _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _streetController.dispose();
    _aptController.dispose();
    _porchController.dispose();
    _floorController.dispose();

    // _focus.removeListener(_onFocusChange);
    // _focus.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _orderStore = Provider.of<OrderStore>(context);

    _orderStore.listOfSuggestions = [];
    _orderStore.addressesFound = [];
    _orderStore.queryMode = true;
    _orderStore.deliveryPoint = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          'Добавить адрес',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Align(
            //   alignment: AlignmentDirectional(0, 1),
            //   child: Padding(
            //       padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 80),
            //       child: ElevatedButton(
            //         onPressed: () {
            //           print('ok');
            //           _onAddressAdded();
            //         },
            //         child: Text('Сохранить адрес'),
            //         // style: DefaultAppTheme.buttonDefaultStyle,
            //       )),
            // ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  InkWell(
                    onTap: () {
                      _onPickOnMap();
                    },
                    child: Container(
                      height: 50,
                      color: Color(0xFF4F4F4F),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                            child: Text(
                              'Указать на карте',
                              style: DefaultAppTheme.title2
                                  .override(color: Colors.white),
                            ),
                          ),
                          Icon(Icons.map, color: DefaultAppTheme.primaryColor),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: TextFormField(
                      // focusNode: _focus,
                      // onTap: () {
                      //   _onPickOnMap();
                      // },
                      controller: _streetController,
                      onChanged: (val) {
                        if (!_orderStore.queryMode ||
                            _streetController.text.length <= 1) {
                          setState(() {
                            _orderStore.listOfSuggestions?.clear();
                            _orderStore.addressesFound?.clear();
                            _orderStore.deliveryPoint = null;
                          });

                          return;
                        }

                        _suggestPlaces(_streetController.text);
                      },
                      decoration: InputDecoration(hintText: 'Улица'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      children: _orderStore.listOfSuggestions!,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: TextFormField(
                      // keyboardType: TextInputType.number,
                      controller: _aptController,
                      decoration: InputDecoration(hintText: 'Кв./офис'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: TextFormField(
                      // keyboardType: TextInputType.number,
                      controller: _porchController,
                      decoration: InputDecoration(hintText: 'Подъезд'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: TextFormField(
                      // keyboardType: TextInputType.number,
                      controller: _floorController,
                      decoration: InputDecoration(hintText: 'Этаж'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                    child: ElevatedButton(
                      onPressed: _orderStore.deliveryPoint == null
                          ? null
                          : () {
                              _onAddressAdded();
                            },
                      child: Text('Сохранить адрес'),
                      style: DefaultAppTheme.buttonDefaultStyle,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPickOnMap() async {
    var res = await pushNewScreen(context,
        screen: PickOnMapScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);

    if (res != null && res.isNotEmpty) {
      setState(() {
        _streetController.text = res['address'];

        // save delivery info
        _orderStore.deliveryPrice = res['delivery'];
        _orderStore.deliveryTreshold = res['delivery_treshold'];
        _orderStore.freeTreshold = res['free_treshold'];
      });
    }
  }

  void _onAddressAdded() async {
    var address = _streetController.text;
    var apt = _aptController.text;
    var porch = _porchController.text;
    var floor = _floorController.text;

    if (address.isEmpty || _orderStore.deliveryPoint == null) {
      Helpers.showInfoMessage(context, 'Заполните адрес');
      return;
    }

    var data = {
      "address": address,
      "apartment_office": apt,
      "porch": porch,
      "floor": floor,
      "delivery_price": _orderStore.deliveryPrice,
      "delivery_threshold": _orderStore.deliveryTreshold,
      "free_threshold": _orderStore.freeTreshold,
      "latitude": _orderStore.deliveryPoint!.latitude,
      "longitude": _orderStore.deliveryPoint!.longitude,
    };

    await _userStore.addAddress(data);

    if (_userStore.success == true) Navigator.of(context).pop();

    // TODO: on error?
  }

  // void _onFocusChange() {
  //   _onPickOnMap();
  // }

  _suggestPlaces(String query) async {
    print("query is $query");

    final List<SuggestSessionResult> results = [];

    // clear list of suggestions
    setState(() {
      _orderStore.listOfSuggestions?.clear();
      _orderStore.addressesFound?.clear();
      _orderStore.deliveryPoint = null;
    });

    final resultWithSession = YandexSuggest.getSuggestions(
      text: query,
      boundingBox: BoundingBox(
        northEast: Point(
          latitude: 43.3687955910072,
          longitude: 77.03463234707239,
        ),
        southWest: Point(
          latitude: 43.16930537074969,
          longitude: 76.74040475112342,
        ),
      ),
      suggestOptions: SuggestOptions(
        suggestType: SuggestType.geo,
        suggestWords: true,
        userPosition: null,
      ),
    );

    await resultWithSession.result.then((result) {
      setState(() {
        results.add(result);
      });

      if (results.isEmpty) {
        _orderStore.listOfSuggestions?.add((Text('Ничего не найдено')));
      }

      for (var r in results) {
        r.items!.asMap().forEach((i, item) {
          if (!_orderStore.addressesFound!.contains(item.title)) {
            _orderStore.addressesFound?.add(item.title);

            _orderStore.listOfSuggestions?.add(
              SuggestionWidget(
                  address: item.title,
                  controller: _streetController,
                  onTap: (Point point) {
                    // validate address
                    if (!_valididateAddress(point)) {
                      Helpers.showErrorMessage(context,
                          'Указаный адрес находится вне зоны доставки');
                      return;
                    }

                    setState(() {
                      _orderStore.deliveryPoint =
                          LatLng(point.latitude, point.longitude);

                      _orderStore.queryMode = false;
                      _orderStore.listOfSuggestions?.clear();
                      _orderStore.addressesFound?.clear();

                      _streetController.text = item.title;
                      _streetController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _streetController.text.length));

                      _orderStore.queryMode = true;
                    });
                  }),
            );
          }
        });
      }
    });
  }

  bool _valididateAddress(Point point) {
    // Esentai Gourmet
    List<LatLng> points = [];
    points.add(LatLng(43.217447858542506, 76.9278968248326));
    points.add(LatLng(43.21835455689957, 76.92610642685327));
    points.add(LatLng(43.22051139404288, 76.92853732003714));
    points.add(LatLng(43.22120796995651, 76.93020633510261));
    points.add(LatLng(43.22009676174443, 76.93163258434038));
    points.add(LatLng(43.217447858542506, 76.9278968248326));

    if (PolygonUtil.containsLocation(
            LatLng(point.latitude, point.longitude), points, true) ==
        true) {
      _orderStore.deliveryTreshold = 10000;
      _orderStore.deliveryPrice = 500;
      _orderStore.freeTreshold = 10000;

      return true;
    }

    // oblast - 2
    points = [];
    points.add(LatLng(43.24118334655078, 76.83895211904309));
    points.add(LatLng(43.25198896461259, 76.89324329362789));
    points.add(LatLng(43.257892255406674, 76.98087383739434));
    points.add(LatLng(43.169248, 77.033919));
    points.add(LatLng(43.209358, 76.950635));
    points.add(LatLng(43.178018, 76.897173));
    points.add(LatLng(43.17022, 76.861167));
    points.add(LatLng(43.219378, 76.845674));
    points.add(LatLng(43.24118334655078, 76.83895211904309));
    points.add(LatLng(43.24118334655078, 76.83895211904309));

    if (PolygonUtil.containsLocation(
            LatLng(point.latitude, point.longitude), points, true) ==
        true) {
      _orderStore.deliveryTreshold = 15000;
      _orderStore.deliveryPrice = 1500;
      _orderStore.freeTreshold = 15000;

      return true;
    }

    // oblast - 3 (rest)
    points = [];
    points.add(LatLng(43.233979, 76.786722));
    points.add(LatLng(43.243907, 76.826495));
    points.add(LatLng(43.254138, 76.822045));
    points.add(LatLng(43.272869, 76.884748));
    points.add(LatLng(43.351572, 76.921545));
    points.add(LatLng(43.356122, 76.945603));
    points.add(LatLng(43.348437, 76.968826));
    points.add(LatLng(43.348235, 77.010824));
    points.add(LatLng(43.320966, 77.025474));
    points.add(LatLng(43.296983, 76.997383));
    points.add(LatLng(43.265028, 76.985407));
    points.add(LatLng(43.171522, 77.04291));
    points.add(LatLng(43.165339, 76.840425));
    points.add(LatLng(43.233979, 76.786722));

    if (PolygonUtil.containsLocation(
            LatLng(point.latitude, point.longitude), points, true) ==
        true) {
      _orderStore.deliveryTreshold = 999999999;
      _orderStore.deliveryPrice = 3000;
      _orderStore.freeTreshold = 999999999;

      return true;
    }

    return false;
  }
}

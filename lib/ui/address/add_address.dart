import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/address/pick_on_map.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/default_input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();

    _streetController = TextEditingController();
    _aptController = TextEditingController();
    _porchController = TextEditingController();
    _floorController = TextEditingController();

    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _streetController.dispose();
    _aptController.dispose();
    _porchController.dispose();
    _floorController.dispose();

    _focus.removeListener(_onFocusChange);
    _focus.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
    _orderStore = Provider.of<OrderStore>(context);
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
                      onTap: () {
                        _onPickOnMap();
                      },
                      controller: _streetController,
                      decoration: InputDecoration(hintText: 'Улица'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: TextFormField(
                      controller: _aptController,
                      decoration: InputDecoration(hintText: 'Кф./офис'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: TextFormField(
                      controller: _porchController,
                      decoration: InputDecoration(hintText: 'Подъезд'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: TextFormField(
                      controller: _floorController,
                      decoration: InputDecoration(hintText: 'Этаж'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                    child: ElevatedButton(
                      onPressed: () {
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

    if (res.isNotEmpty) {
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

    if (address.isEmpty) {
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
    };

    await _userStore.addAddress(data);

    if (_userStore.success == true) Navigator.of(context).pop();

    // TODO: on error?
  }

  void _onFocusChange() {
    _onPickOnMap();
  }
}

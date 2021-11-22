import 'dart:convert';

import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/address/add_address.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPickerWidget extends StatefulWidget {
  AddressPickerWidget({Key? key}) : super(key: key);
  @override
  _ChooseDefaultAddressWidgetWidgetState createState() =>
      _ChooseDefaultAddressWidgetWidgetState();
}

class _ChooseDefaultAddressWidgetWidgetState
    extends State<AddressPickerWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;

  String _mode = 'MODE_PICK'; // MODE_PICK, MODE_EDIT

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);

    if (!_userStore.isLoading) {
      _userStore.getAddresses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: DefaultAppTheme.grey3,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          // height: 100,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 0),
                  child: Text(
                    'Адрес для быстрой оплаты',
                    style: DefaultAppTheme.title2.override(
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
              ),
              _buildController(),
              _buildAddresses(),
              _buildEmpty(),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: ElevatedButton(
                    child: Text('Добавить новый адрес'),
                    onPressed: () {
                      _onNewAddress();
                    },
                    style: DefaultAppTheme.buttonDefaultStyle,
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildEmpty() {
    return Observer(builder: (context) {
      print(_userStore.addressList?.items?.length);

      if (_userStore.addressList == null) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 32, 0, 20),
          child: Text(
            'Нет добавленных адресов.',
            style: DefaultAppTheme.bodyText2,
          ),
        );
      }

      if (_userStore.addressList != null) {
        if (_userStore.addressList!.items!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 20),
            child: Text(
              'Нет добавленных адресов.',
              style: DefaultAppTheme.bodyText2,
            ),
          );
        }
      }

      return Container();
    });
  }

  Widget _buildController() {
    return Observer(builder: (context) {
      print(_userStore.addressList?.items?.length);

      return _userStore.addressList != null &&
              _userStore.addressList!.items!.isNotEmpty
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: _mode == 'MODE_PICK'
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (_mode == 'MODE_EDIT')
                  //   TextButton(
                  //     onPressed: () {
                  //       _onWidgetCancel();
                  //     },
                  //     child: Text(
                  //       'Отменить',
                  //       style: DefaultAppTheme.title3.override(
                  //         fontFamily: 'Gilroy',
                  //         color: DefaultAppTheme.primaryColor,
                  //       ),
                  //     ),
                  //   ),
                  if (_mode == 'MODE_EDIT')
                    TextButton(
                      onPressed: () {
                        _onWidgetOk();
                      },
                      child: Text(
                        'Удалить',
                        style: DefaultAppTheme.title3.override(
                          fontFamily: 'Gilroy',
                          color: DefaultAppTheme.primaryColor,
                        ),
                      ),
                    ),
                  if (_mode == 'MODE_PICK')
                    TextButton(
                      onPressed: () {
                        _onWidgetEdit();
                      },
                      child: Text(
                        'Удалить',
                        style: DefaultAppTheme.title3.override(
                          fontFamily: 'Gilroy',
                          color: DefaultAppTheme.primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildAddresses() {
    return Observer(builder: (context) {
      return _userStore.addressList != null
          ? Column(children: [
              for (var address in _userStore.addressList!.items!)
                Column(children: [
                  InkWell(
                    onTap: () {
                      _onAddressPicked(address);
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (_mode == 'MODE_EDIT')
                            InkWell(
                              onTap: () {
                                _onAddressDeleted(address);
                              },
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 19, 0),
                                child: Image.asset(
                                  'assets/images/ic_trash_red.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          Image.asset(
                            'assets/images/ic_marker_orange.png',
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
                              child: Text(
                                Address.getFullStr(address),
                                style: DefaultAppTheme.bodyText1.override(
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            address.id != _userStore.currentAddress?.id
                                ? 'assets/images/radio_back.png'
                                : 'assets/images/radio_front.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ]),
            ])
          : Container();
    });
  }

  void _onWidgetCancel() {
    setState(() {
      _mode = 'MODE_PICK';
    });
  }

  void _onWidgetEdit() {
    setState(() {
      _mode = 'MODE_EDIT';
    });
  }

  void _onWidgetOk() {
    setState(() {
      _mode = 'MODE_PICK';
    });
  }

  void _onNewAddress() async {
    await pushNewScreen(context,
        screen: AddNewAddressScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
    _userStore.getAddresses();
  }

  void _onAddressPicked(Address address) async {
    _userStore.currentAddress = address;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        Preferences.current_address, _userStore.currentAddress!.toJson());

    Navigator.of(context).pop();
  }

  void _onAddressDeleted(Address address) async {
    print('delete');

    // clear default address
    if (_userStore.currentAddress?.id == address.id) {
      _userStore.currentAddress = null;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(Preferences.current_address, '');
    }

    await _userStore.deleteAddress(address.id!);
    _userStore.getAddresses();
  }
}

import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/payment/creditcard.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/address/add_address.dart';
import 'package:esentai/ui/creditcard/add_creditcard.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CreditCardPickerWidget extends StatefulWidget {
  CreditCardPickerWidget({Key? key}) : super(key: key);
  @override
  _ChooseDefaultCreditCardWidgetWidgetState createState() =>
      _ChooseDefaultCreditCardWidgetWidgetState();
}

class _ChooseDefaultCreditCardWidgetWidgetState
    extends State<CreditCardPickerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;

  String _mode = 'MODE_PICK'; // MODE_PICK, MODE_EDIT

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);

    if (!_userStore.isLoading) {
      _userStore.getCards();
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
                    'Карта для быстрой оплаты',
                    style: DefaultAppTheme.title2.override(
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
              ),
              _buildController(),
              _buildCards(),
              _buildEmpty(),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: ElevatedButton(
                    child: Text('Добавить новую карту'),
                    onPressed: () {
                      _onNewCard();
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
      print(_userStore.cardList);

      if (_userStore.cardList == null) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 32, 0, 20),
          child: Text(
            'Нет добавленных карт.',
            style: DefaultAppTheme.bodyText2,
          ),
        );
      }

      if (_userStore.cardList != null) {
        if (_userStore.cardList!.items!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 20),
            child: Text(
              'Нет добавленных карт.',
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
      print(_userStore.cardList);

      return _userStore.cardList != null &&
              _userStore.cardList!.items!.isNotEmpty
          ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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

  Widget _buildCards() {
    return Observer(builder: (context) {
      return _userStore.cardList != null
          ? Column(children: [
              for (var card in _userStore.cardList!.items!)
                Column(children: [
                  InkWell(
                    onTap: () {
                      _onCardPicked(card);
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (_mode == 'MODE_EDIT')
                            InkWell(
                              onTap: () {
                                _onCardDeleted(card);
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
                          // Image.asset(
                          //   'assets/images/ic_bonus_card.png',
                          //   width: 32,
                          //   height: 32,
                          //   fit: BoxFit.contain,
                          // ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(14, 0, 14, 0),
                              child: Helpers.getFullCard(card),
                            ),
                          ),
                          Image.asset(
                            card.cardId != _userStore.currentCard?.cardId
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

  void _onNewCard() async {
    await _userStore.addCard();

    if (_userStore.paymentLink == null) {
      Helpers.showInfoMessage(context, "Ошибка. Попробуйте еще раз");
      return;
    }

    await pushNewScreen(context,
        screen: AddNewCreditCardScreen(link: _userStore.paymentLink!),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
    _userStore.getCards();
  }

  void _onCardPicked(CreditCard card) {
    _userStore.currentCard = card;

    Navigator.of(context).pop();
  }

  void _onCardDeleted(CreditCard card) async {
    print('delete');

    // clear default address
    if (_userStore.currentCard?.cardId == card.cardId) {
      _userStore.currentCard = null;
    }

    // await _userStore.deleteCard(card.id!);
    _userStore.deleteCard(card.cardId!);
  }
}

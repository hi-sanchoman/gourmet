import 'package:another_flushbar/flushbar.dart';
import 'package:esentai/models/order/order.dart';
import 'package:esentai/models/order/order_item.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/order_details_widget.dart';
import 'package:esentai/widgets/order_history_card.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);

    if (!_userStore.isLoading) {
      _userStore.getOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: DefaultAppTheme.primaryColor,
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
            'История заказов',
            style: DefaultAppTheme.title2.override(
              fontFamily: 'Gilroy',
              color: Colors.white,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFE5E5E5),
        body: SafeArea(child: _buildBody()));
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(builder: (context) {
          return RefreshIndicator(
              onRefresh: () async {
                _userStore.getOrders();
              },
              child: _buildMainBody());
        }),
        Observer(builder: (context) {
          return Visibility(
            visible: _userStore.isLoading,
            child: CustomProgressIndicatorWidget(),
          );
        }),
        Observer(builder: (context) {
          return _userStore.success
              ? navigate(context)
              : Helpers.showErrorMessage(
                  context, _userStore.errorStore.errorMessage);
        }),
      ],
    );
  }

  Widget _buildMainBody() {
    return _userStore.orderList != null &&
            _userStore.orderList!.items != null &&
            _userStore.orderList!.items!.length > 0
        ? Stack(
            children: [
              ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    for (Order order in _userStore.orderList!.items!)
                      // _buildOrder(order),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: InkWell(
                            onTap: () {
                              _onOrderPressed(order);
                            },
                            child: OrderHistoryCardWidget(order: order)),
                      ),
                    Container(height: 82),
                  ]),
            ],
          )
        : Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.only(top: 0),
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
                      'Здесь появятся ваши заказы',
                      style: DefaultAppTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
          );
    ;
  }

  void _onOrderPressed(Order order) async {
    print('order');

    // Helpers.showInfoMessage(context, 'Order #${order.id}');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: OrderDetailsWidget(order: order)),
    );
  }

  Widget navigate(BuildContext context) {
    print("navigate called...orders");

    return Container();
  }
}

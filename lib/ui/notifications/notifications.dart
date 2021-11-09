import 'package:esentai/models/notification/back_notification.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/login/login.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/notification_card_widget.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;
  late final SlidableController _slidableController;
  Animation<double>? _rotationAnimation;
  Color _fabColor = Colors.blue;

  @override
  void initState() {
    super.initState();

    _slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);

    if (!_userStore.isLoggedIn) {
      Future.delayed(Duration(milliseconds: 0), () {
        // print("user is not logged in");
        pushNewScreen(context,
            screen: LoginScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);
      });

      return;
    }

    _loadData();
  }

  void handleSlideAnimationChanged(Animation<double>? slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool? isOpen) {
    setState(() {
      _fabColor = isOpen! ? Colors.green : Colors.blue;
    });
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
            'Мои уведомления',
            style: DefaultAppTheme.title2.override(
              fontFamily: 'Gilroy',
              color: Colors.white,
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                _onDeleteAll();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 21, 16, 0),
                child: Text(
                  'Очистить все',
                  style:
                      DefaultAppTheme.subtitle2.override(color: Colors.white),
                ),
              ),
            )
          ],
          centerTitle: true,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFCFCFC),
        body: SafeArea(child: _buildBody()));
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(builder: (context) {
          print(_userStore.notificationList?.items?.length);

          return Stack(children: [
            RefreshIndicator(
                onRefresh: () async {
                  _loadData();
                },
                child: _buildMainBody())
          ]);
        }),
        Observer(builder: (context) {
          return Visibility(
            visible: _userStore.isLoading,
            child: Container(
                color: Colors.white, child: CustomProgressIndicatorWidget()),
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
    return _userStore.notificationList != null &&
            _userStore.notificationList!.items!.isNotEmpty
        ? ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
                for (BackNotification item
                    in _userStore.notificationList!.items!)
                  Slidable(
                    key: Key(item.id.toString()),
                    controller: _slidableController,
                    direction: Axis.horizontal,
                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                      onDismissed: (actionType) {
                        _onNotificationRemove(item);
                      },
                    ),
                    actionPane: SlidableScrollActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        // caption: 'Delete',
                        color: DefaultAppTheme.background,
                        iconWidget: Image.asset(
                          'assets/images/ic_trash_red.png',
                        ),
                        onTap: () => _onNotificationRemove(item),
                      ),
                    ],
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                      child: NotificationCardWidget(
                        notification: item,
                      ),
                    ),
                  ),
                Container(height: 82),
              ])
        : Container(
            child: Center(
              child: Text('Нет уведомлений'),
            ),
          );
  }

  Widget navigate(BuildContext context) {
    print("navigate called...notifications");

    return Container();
  }

  void _loadData() {
    if (!_userStore.isLoading) {
      _userStore.getNotifications();
    }
  }

  void _onNotificationRemove(BackNotification item) async {
    await _userStore.removeNotificationById(item.id!);
    _loadData();
  }

  void _onDeleteAll() async {
    await _userStore.removeAllNotifications();
    _loadData();
  }
}

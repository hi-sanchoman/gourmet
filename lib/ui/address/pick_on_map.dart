import 'package:another_flushbar/flushbar_helper.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/locale/app_localization.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PickOnMapScreen extends StatefulWidget {
  PickOnMapScreen({Key? key}) : super(key: key);

  @override
  _ChooseAddressScreenState createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<PickOnMapScreen> {
  // final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late UserStore _userStore;
  late YandexMapController controller;

  late Map<String, Object> _data;
  String _address = '';
  Point? _point;

  Position? _position;
  bool _noLocation = true;

  final MapObjectId _placemarkId = MapObjectId('pin_icon');
  final List<MapObject> _mapObjects = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFCFC),
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            _onClose();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: DefaultAppTheme.textColor,
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
      body: Stack(
        children: <Widget>[
          _buildMainContent(),
          // _buildErrorContent()
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildPage();
        // return Container();
      },
    );
  }

  Widget _buildPage() {
    return Stack(alignment: AlignmentDirectional(0, 0), children: [
      // map
      Align(
          alignment: AlignmentDirectional(0, 0),
          child: Container(
              color: Colors.grey,
              child: YandexMap(
                onMapCreated: (YandexMapController yandexMapController) async {
                  controller = yandexMapController;
                  _onMapRendered();
                },
              ))),
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20, 16, 20),
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(100))),
            // color: Colors.white,
            height: 50,
            width: double.infinity,
            child: Center(
                child: Text(
              '${_address}',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
          ),
        ),
      ),
      Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 50),
          child: ElevatedButton(
            child: Text('Подтвердить'),
            onPressed: () {
              _onClose();
            },
            style: DefaultAppTheme.buttonDefaultStyle,
            // borderRadius: 19
          ),
        ),
      )
    ]);
  }

  void _onClose() {
    Navigator.pop(context, _address);
  }

  Future<void> cameraPositionChanged(
      CameraPosition cameraPosition, bool finished) async {
    if (!finished) {
      // controller.updateMapObjects([]);

      Point point = cameraPosition.target;
      addPlacemark(cameraPosition.target);
    }

    if (finished) {
      double zoom = await controller.getZoom();
      Point point = cameraPosition.target;

      var search = YandexSearch.searchByPoint(
          point: point,
          zoom: zoom,
          searchOptions: SearchOptions(searchType: SearchType.geo));

      search.result.then((res) {
        var found = res.items![0].toponymMetadata!.addressComponents;
        print("found: $found");

        // String? locality = found[SearchComponentKind.locality];
        // String? district = found[SearchComponentKind.district];
        String? street = found[SearchComponentKind.street];
        String? house = found[SearchComponentKind.house];

        String fullAddress = '';
        // fullAddress += locality!.isNotEmpty ? "$locality, " : '';
        // fullAddress += district!.isNotEmpty ? "$district, " : '';
        fullAddress += street != null ? "$street" : "";
        fullAddress += house != null ? ", $house" : "";

        String address = res.items![0].toponymMetadata!.formattedAddress;
        Point point = res.items![0].toponymMetadata!.balloonPoint;

        setState(() {
          _address = fullAddress;
          _point = point;
        });
      }).onError((error, stackTrace) {
        print("yandex search: " + error.toString());
      });
    }
  }

  Future<void> addPlacemark(Point point) async {
    print("put point: $point");

    // _mapObjects.clear();

    var marker = Placemark(
      point: point,
      style: PlacemarkStyle(
        iconName: 'assets/images/pin.png',
        opacity: 0.9,
        scale: 2,
        iconAnchor: Offset(0.5, 1),
      ),
      mapId: _placemarkId,
    );

    await controller.updateMapObjects([marker]);
  }

  // on map rendered
  void _onMapRendered() async {
    print('Map rendered');

    // enable camera tracking
    final currentCameraTracking = await controller.enableCameraTracking(
        onCameraPositionChange: cameraPositionChanged);

    await Helpers.determinePosition().then((position) async {
      setState(() {
        _position = position;
        _noLocation = false;
      });

      print("found position: $_position");

      var point =
          Point(latitude: position.latitude, longitude: position.longitude);

      addPlacemark(point);

      controller.move(cameraPosition: CameraPosition(target: point));
    }).catchError((e) {
      print("map current location erorr: " + e.toString());

      if (e.toString() == 'no_service') {
        print('show alert');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                    'У вас отключен сервис геолокации. Для продолжения работы, включите его.'),
              );
            });
      } else if (e.toString() == 'no_permissions') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Text(
                      'Вы отключили разрешение на геолокацию. Для продолжения работы, включите его.'));
            });
      } else if (e.toString() == 'denied') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Text('Определение геолокации запрещено'));
            });
      }

      // TODO: show message to turn on location
      setState(() {
        _noLocation = true;
      });
    });
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/locale/app_localization.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/progress_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
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
  late Map<String, Object> _result;
  String _address = '';
  late int _freeTreshold = 999999999;
  late int _delivery = 3000;
  late int _deliveryTreshold = 999999999;
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
            setState(() {
              _address = '';
            });
            Navigator.of(context).pop();
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
                mapObjects: _mapObjects,
                onMapCreated: (YandexMapController yandexMapController) async {
                  controller = yandexMapController;
                  _onMapRendered();
                },
                onCameraPositionChanged: (cameraPosition, reason, finished) {
                  cameraPositionChanged(cameraPosition, finished);
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

  void _onClose() async {
    // validate address
    if (!_valididateAddress()) {
      // show wrong address dialog
      await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => WillPopScope(
              child: CupertinoAlertDialog(
                // title: new Text(""),
                content: Text('Указаный адрес находится вне зоны доставки'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Выбрать другой адрес'),
                    onPressed: () {
                      setState(() {
                        _address = '';
                      });
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
              onWillPop: () async {
                return false;
              }));

      return;
    }

    _result = {
      "delivery": _delivery,
      "delivery_treshold": _deliveryTreshold,
      "free_treshold": _freeTreshold,
      "address": _address,
    };

    Navigator.pop(context, _result);
  }

  bool _valididateAddress() {
    if (_point == null) return false;

    // Esentai Gourmet
    List<LatLng> points = [];
    points.add(LatLng(43.217447858542506, 76.9278968248326));
    points.add(LatLng(43.21835455689957, 76.92610642685327));
    points.add(LatLng(43.22051139404288, 76.92853732003714));
    points.add(LatLng(43.22120796995651, 76.93020633510261));
    points.add(LatLng(43.22009676174443, 76.93163258434038));
    points.add(LatLng(43.217447858542506, 76.9278968248326));

    if (PolygonUtil.containsLocation(
            LatLng(_point!.latitude, _point!.longitude), points, true) ==
        true) {
      _deliveryTreshold = 10000;
      _delivery = 500;
      _freeTreshold = 10000;

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
            LatLng(_point!.latitude, _point!.longitude), points, true) ==
        true) {
      _deliveryTreshold = 15000;
      _delivery = 1500;
      _freeTreshold = 15000;

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
            LatLng(_point!.latitude, _point!.longitude), points, true) ==
        true) {
      _deliveryTreshold = 999999999;
      _delivery = 3000;
      _freeTreshold = 999999999;

      return true;
    }

    return false;
  }

  Future<void> cameraPositionChanged(
      CameraPosition cameraPosition, bool finished) async {
    if (!finished) {
      // controller.updateMapObjects([]);

      Point point = cameraPosition.target;
      addPlacemark(cameraPosition.target);
    }

    if (finished) {
      CameraPosition cameraPosition = await controller.getCameraPosition();
      double zoom = cameraPosition.zoom;
      Point point = cameraPosition.target;

      var search = YandexSearch.searchByPoint(
          point: point,
          zoom: zoom.toInt(),
          searchOptions: SearchOptions(searchType: SearchType.geo));

      search.result.then((res) {
        var found = res.items![0].toponymMetadata!.address;
        print("found: $found");

        // String? locality = found[SearchComponentKind.locality];
        // String? district = found[SearchComponentKind.district];
        String? street = found.addressComponents[SearchComponentKind.street];
        String? house = found.addressComponents[SearchComponentKind.house];

        String fullAddress = '';
        // fullAddress += locality!.isNotEmpty ? "$locality, " : '';
        // fullAddress += district!.isNotEmpty ? "$district, " : '';
        fullAddress += street != null ? "$street" : "";
        fullAddress += house != null ? ", $house" : "";

        // String fullAddress =
        // res.items![0].toponymMetadata!.address.formattedAddress;
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
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage('assets/images/pin.png'),
        scale: 2,
        anchor: Offset(0.5, 1),
      )),
      // style: PlacemarkStyle(
      //   iconName: 'assets/images/pin.png',
      //   opacity: 0.9,
      //   scale: 2,
      //   iconAnchor: Offset(0.5, 1),
      // ),
      mapId: _placemarkId,
    );

    setState(() {
      _mapObjects.add(marker);
    });

    // await controller.updateMapObjects([marker]);
  }

  // on map rendered
  void _onMapRendered() async {
    print('Map rendered');

    // enable camera tracking
    // final currentCameraTracking = await controller.enableCameraTracking(
    //     onCameraPositionChange: cameraPositionChanged);

    await Helpers.determinePosition().then((position) async {
      setState(() {
        _position = position;
        _noLocation = false;
      });

      print("found position: $_position");

      var point =
          Point(latitude: position.latitude, longitude: position.longitude);

      addPlacemark(point);

      controller.moveCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: point)));
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
        Helpers.showInfoMessage(
            context, 'Ошибка на сервере. Попробуйте еще раз');
      }
    });

    return SizedBox.shrink();
  }
}

import 'package:flutter/material.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../stores/order/order_store.dart';

class SuggestionWidget extends StatefulWidget {
  SuggestionWidget(
      {Key? key,
      required this.address,
      required this.controller,
      required this.onTap})
      : super(key: key);

  String address;
  TextEditingController controller;
  Function onTap;

  @override
  State<SuggestionWidget> createState() => _SuggestionWidgetState();
}

class _SuggestionWidgetState extends State<SuggestionWidget> {
  late OrderStore _orderStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orderStore = Provider.of<OrderStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _searchGeopoint();
      },
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: Text(
                  widget.address,
                ),
              ),
              // Text('>'),
            ],
          )),
    );
  }

  _searchGeopoint() async {
    final resultWithSession = YandexSearch.searchByText(
      searchText: widget.address,
      geometry: Geometry.fromBoundingBox(BoundingBox(
        northEast: Point(
          latitude: 43.3687955910072,
          longitude: 77.03463234707239,
        ),
        southWest: Point(
          latitude: 43.16930537074969,
          longitude: 76.74040475112342,
        ),
      )),
      searchOptions: SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );

    await resultWithSession.result.then((result) {
      if (result.error != null) {
        // error
        return;
      }

      if (result.items != null && result.items!.isNotEmpty) {
        print(
            "found geo: ${result.items!.first.toponymMetadata!.balloonPoint}");
        Point point = result.items!.first.toponymMetadata!.balloonPoint;

        widget.onTap(point);
      }
    });
  }
}

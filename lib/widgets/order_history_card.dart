import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/models/order/order.dart';
import 'package:esentai/models/order/order_item.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryCardWidget extends StatefulWidget {
  OrderHistoryCardWidget({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  _OrderCardWidgetState createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderHistoryCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Color(0xFFF5F5F5),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              // height: 217,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            '№ ${widget.order.id}',
                            style: DefaultAppTheme.bodyText1.override(
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                        Text(
                          '${widget.order.totalPrice != null ? Helpers.prettyNum(double.tryParse(widget.order.totalPrice!)) : 0} тг',
                          style: DefaultAppTheme.title2.override(
                            fontFamily: 'Gilroy',
                            color: DefaultAppTheme.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 2, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.order.updatedAt}',
                            style: DefaultAppTheme.subtitle1.override(
                              fontFamily: 'Gilroy',
                              fontSize: 13,
                            ),
                          ),
                        ),
                        if (widget.order.bonusReturned != null)
                          Text(
                            '+${widget.order.bonusReturned} тг',
                            style: DefaultAppTheme.subtitle2.override(
                              fontFamily: 'Gilroy',
                              color: DefaultAppTheme.tertiaryColor,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // products
                  _buildProducts(),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 16.0, right: 16.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   'assets/images/ic_clock_grey.png',
                        //   width: 16,
                        //   height: 16,
                        //   fit: BoxFit.cover,
                        // ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            '${widget.order.status ?? 'Нет статуса'}',
                            style: DefaultAppTheme.title2.override(
                              fontFamily: 'Gilroy',
                              // color: DefaultAppTheme.tertiaryColor,
                            ),
                          ),
                        )
                      ],
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

  Widget _buildProducts() {
    if (widget.order.goods != null)
      return Column(
        children: [
          for (var item in widget.order.goods!.items!) _buildProduct(item),
        ],
      );

    return Container();
  }

  Widget _buildProduct(OrderItem item) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (item.product != null)
            SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 0),
                fadeOutDuration: Duration(milliseconds: 0),
                imageUrl: item.product!.mainImage!,
                // placeholder: (context, url) =>
                //     CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/nophoto.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          _buildGiftImage(item),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(
              '${item.count} х ',
              style: DefaultAppTheme.bodyText1.override(
                fontFamily: 'Gilroy',
                color: DefaultAppTheme.primaryColor,
              ),
            ),
          ),
          if (item.product != null)
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 16, 0),
                child: Text(
                  '${item.product!.name}',
                  style: DefaultAppTheme.bodyText1.override(
                    fontFamily: 'Gilroy',
                  ),
                ),
              ),
            ),
          if (item.gift != null)
            Expanded(
              child: _buildGiftName(item),
            ),
        ],
      ),
    );
  }

  Widget _buildGiftImage(OrderItem item) {
    if (item.gift != null) {
      if (item.gift!.gift != null) {
        if (item.gift!.gift!.mainImage != null) {
          return SizedBox(
            width: 50,
            height: 50,
            child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 0),
              fadeOutDuration: Duration(milliseconds: 0),
              imageUrl: item.gift!.gift!.mainImage!,
              // placeholder: (context, url) =>
              //     CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/nophoto.png',
              ),
              fit: BoxFit.cover,
            ),
          );
        }
      }
    }

    return Container();
  }

  Widget _buildGiftName(OrderItem item) {
    if (item.gift != null) {
      if (item.gift!.gift != null) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 16, 0),
          child: Text(
            '${item.gift!.gift?.name}',
            style: DefaultAppTheme.bodyText1.override(
              fontFamily: 'Gilroy',
            ),
          ),
        );
      }
    }

    return Container();
  }
}

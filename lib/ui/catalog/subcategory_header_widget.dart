import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubcategoryHeaderWidget extends StatefulWidget {
  SubcategoryHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final String title;
  final Function() onTap;

  @override
  _SubcategoryHeaderWidgetState createState() =>
      _SubcategoryHeaderWidgetState();
}

class _SubcategoryHeaderWidgetState extends State<SubcategoryHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: 70,
          height: 128,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 0),
                    fadeOutDuration: Duration(milliseconds: 0),
                    imageUrl: widget.image,
                    // placeholder: (context, url) =>
                    //     CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/nophoto.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Text(
                  widget.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: DefaultAppTheme.subtitle2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

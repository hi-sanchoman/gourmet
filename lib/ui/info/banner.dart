import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/models/info/banner.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BannerScreen extends StatefulWidget {
  BannerScreen({Key? key, required this.banner}) : super(key: key);

  final BannerPage banner;

  @override
  _InfoScreenWidgetState createState() => _InfoScreenWidgetState();
}

class _InfoScreenWidgetState extends State<BannerScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: DefaultAppTheme.primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Helpers.share();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Icon(Icons.share_outlined, size: 25, color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  // alignment: AlignmentDirectional(-1, -1),
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 29 / 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFB9D86F),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, 1),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 29 / 40,
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 0),
                          fadeOutDuration: Duration(milliseconds: 0),
                          imageUrl: '${widget.banner.image}',
                          // placeholder: (context, url) =>
                          //     CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                              'assets/images/nophoto.png',
                              width: double.infinity,
                              height: 274),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Align(
                    //     alignment: Alignment(-1, 1),
                    //     child: InkWell(
                    //       onTap: () {
                    //         // print('iknwe');
                    //         Navigator.of(context).pop();
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
                    //         child: Icon(Icons.arrow_back_ios,
                    //             color: Colors.white, size: 40),
                    //       ),
                    //     )),
                    // Align(
                    //   alignment: AlignmentDirectional(-1, 1),
                    //   child: Padding(
                    //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                    //     child: Text(
                    //       'Кулинария',
                    //       style: DefaultAppTheme.title1.override(
                    //         fontFamily: 'Gilroy',
                    //         color: Colors.white,
                    //         fontSize: 40,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.banner.title}',
                        style: DefaultAppTheme.title1.override(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      //   child: Text(
                      //     'ГОРДОСТЬ ГАСТРОНОМА ESENTAI GOURMET',
                      //     style: DefaultAppTheme.subtitle1.override(
                      //       fontFamily: 'Gilroy',
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                        child: Html(data: '${widget.banner.content}'),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

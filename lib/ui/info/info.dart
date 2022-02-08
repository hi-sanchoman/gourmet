import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key, required this.slug}) : super(key: key);

  final String slug;

  @override
  _InfoScreenWidgetState createState() => _InfoScreenWidgetState();
}

class _InfoScreenWidgetState extends State<InfoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late CatalogStore _catalogStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _catalogStore = Provider.of<CatalogStore>(context);

    _catalogStore.pages = null;

    if (!_catalogStore.isLoading) {
      _catalogStore.getInfoPage(widget.slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
          backgroundColor: DefaultAppTheme.primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Информация',
            style: DefaultAppTheme.title2.override(
              fontFamily: 'Gilroy',
              color: Colors.white,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          actions: [
            InkWell(
              onTap: () {
                Helpers.share();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child:
                    Icon(Icons.share_outlined, size: 25, color: Colors.white),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0),
      body: Observer(builder: (context) {
        if (_catalogStore.pages != null) {
          var infoPage = _catalogStore.pages!.items![0];
          // print("infopage + ${infoPage}");

          return ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Text(
                  '${infoPage.title}',
                  style: DefaultAppTheme.title1.override(
                    fontFamily: 'Gilroy',
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 16, 16, 0),
                child: Html(data: '${infoPage.content}'),
              )
            ],
          );
        }

        return Container();
      }),
    );
  }
}

import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/ui/search/search.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetWidgetState createState() => _SearchWidgetWidgetState();
}

class _SearchWidgetWidgetState extends State<SearchWidget> {
  late TextEditingController _searchFieldController;

  @override
  void initState() {
    super.initState();

    _searchFieldController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFCFCFC),
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 22,
                decoration: BoxDecoration(
                  color: DefaultAppTheme.primaryColor,
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 22,
                decoration: BoxDecoration(
                  color: Color(0xFFFCFCFC),
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              _onSearchPressed();
            },
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: DefaultAppTheme.grayLight,
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(36),
                ),
                child: TextFormField(
                  // controller: _searchFieldController,
                  // onChanged: (val) {
                  //   _onSearch(val);
                  // },
                  obscureText: false,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Поиск среди 5000 товаров',
                    hintStyle: DefaultAppTheme.bodyText2,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(52, 13, 20, 13),
                  ),
                  style: DefaultAppTheme.bodyText1,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(36, 14, 0, 0),
            child: Image.asset(
              'assets/images/search.png',
              width: 16,
              height: 16,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  void _onSearchPressed() {
    pushNewScreen(context,
        screen: SearchScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}

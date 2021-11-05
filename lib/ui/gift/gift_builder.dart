import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GiftBuilderScreen extends StatefulWidget {
  GiftBuilderScreen({Key? key}) : super(key: key);

  @override
  _PackagesScreenWidgetState createState() => _PackagesScreenWidgetState();
}

class _PackagesScreenWidgetState extends State<GiftBuilderScreen> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxListTileValue = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: DefaultAppTheme.primaryColor,
        automaticallyImplyLeading: true,
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
          'Упаковки и открытки',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                labelColor: DefaultAppTheme.primaryColor,
                indicatorColor: DefaultAppTheme.secondaryColor,
                tabs: [
                  Tab(
                    text: 'Упаковки',
                  ),
                  Tab(
                    text: 'Открытки',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPackages(),
                    _buildPostcards(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackages() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 43, 16, 0),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            // Image.asset(
                            //   'assets/images/package_2.png',
                            //   width: 200,
                            //   height: 227,
                            //   fit: BoxFit.cover,
                            // ),
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 13, 13, 0),
                                child: Image.asset(
                                  'assets/images/search_close.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ]),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 14, 0, 0),
                            child: Text(
                              'Красная упаковка !',
                              style: DefaultAppTheme.bodyText1.override(
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Color(0xFFCECFD2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2, 0, 0, 0),
                                      child: ElevatedButton(
                                        child: Text('x'),
                                        onPressed: () {},
                                      )),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 15, 0),
                                      child: Text(
                                        '2',
                                        textAlign: TextAlign.center,
                                        style: DefaultAppTheme.title2.override(
                                          fontFamily: 'Gilroy',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 2, 0),
                                    child: ElevatedButton(
                                      child: Text('x'),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: CheckboxListTile(
                                value: checkboxListTileValue ??= false,
                                onChanged: (newValue) => setState(
                                    () => checkboxListTileValue = newValue!),
                                title: Text(
                                  'Один текст для всех открыток',
                                  style: DefaultAppTheme.title3.override(
                                    fontFamily: 'Gilroy',
                                  ),
                                ),
                                tileColor: Color(0xFFF5F5F5),
                                dense: true,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Текст для открытки 1',
                                style: DefaultAppTheme.title2.override(
                                  fontFamily: 'Gilroy',
                                  color: DefaultAppTheme.grayLight,
                                ),
                              ),
                              TextButton(
                                  child: Text('Черно-белая'), onPressed: () {}),
                            ],
                          ),
                          Container(
                            width: 200,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: TextFormField(
                                controller: textController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: DefaultAppTheme.grayLight,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: DefaultAppTheme.grayLight,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: DefaultAppTheme.bodyText2.override(
                                  fontFamily: 'Gilroy',
                                  color: DefaultAppTheme.textColor,
                                ),
                                maxLines: 4,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: DefaultAppTheme.grayLight,
                          )
                        ],
                      ),
                    ),
                  ]),
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0, 1),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 40),
            child: ElevatedButton(child: Text('Готово'), onPressed: () {}),
          ),
        ),
      ],
    );
  }

  Widget _buildPostcards() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 43, 16, 0),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/package_2.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 14, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/package_2.png',
                      width: 125,
                      height: 83,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Красная упаковка',
                            style: DefaultAppTheme.bodyText1.override(
                              fontFamily: 'Gilroy',
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: ElevatedButton(
                                child: Text('1000 тг'), onPressed: () {}),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0, 1),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 40),
            child: ElevatedButton(child: Text('Gotovo'), onPressed: () {}),
          ),
        )
      ],
    );
  }
}

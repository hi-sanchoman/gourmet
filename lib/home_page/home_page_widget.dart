import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(56, 56, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/images/Vector.png',
                        width: 22,
                        height: 14,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment(-1, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(56, 44, 0, 0),
                  child: Text(
                    'Самые вкусные \nблюда для тебя',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(56, 28, 56, 0),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Найди новое блюдо...',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFEFEEEE),
                    contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  ),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(56, 46, 0, 0),
                  child: DefaultTabController(
                    length: 5,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          labelColor: Color(0xFFFA4A0C),
                          unselectedLabelColor: Color(0xFF9A9A9D),
                          labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          indicatorColor: Color(0xFFFA4A0C),
                          indicatorWeight: 2,
                          tabs: [
                            Tab(
                              text: 'Горячее',
                              iconMargin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                            ),
                            Tab(
                              text: 'Десерты',
                              iconMargin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                            ),
                            Tab(
                              text: 'Салаты',
                            ),
                            Tab(
                              text: 'Супы',
                            ),
                            Tab(
                              text: 'Мясо',
                            )
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment: Alignment(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment: Alignment(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment: Alignment(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment: Alignment(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 0),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 250,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 1),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment: Alignment(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 1),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment: Alignment(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    height: 312,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                      child: Container(
                                        width: 220,
                                        height: 312,
                                        child: Stack(
                                          alignment: Alignment(0, -1),
                                          children: [
                                            Align(
                                              alignment: Alignment(0, 1),
                                              child: Container(
                                                width: 220,
                                                height: 270,
                                                constraints: BoxConstraints(
                                                  maxWidth: 220,
                                                  maxHeight: 270,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment: Alignment(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 32),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Томатный микс',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 16, 0, 0),
                                                        child: Text(
                                                          'Томаты с индейкой и \nсоусом черри',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 49.png',
                                              width: 168,
                                              height: 189,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

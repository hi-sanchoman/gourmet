import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/ui/catalog/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailsScreen extends StatefulWidget {
  FoodDetailsScreen({Key? key}) : super(key: key);

  @override
  _FoodScreenWidgetState createState() => _FoodScreenWidgetState();
}

class _FoodScreenWidgetState extends State<FoodDetailsScreen> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFCFCFC),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/product_big.png',
                width: MediaQuery.of(context).size.width,
                height: 330,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 720,
            decoration: BoxDecoration(
              color: DefaultAppTheme.background,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                  child: Text(
                    'Осталось: 2',
                    style: DefaultAppTheme.bodyText1.override(
                      fontFamily: 'Gilroy',
                      color: DefaultAppTheme.secondaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 0),
                  child: Text(
                    'Напиток QNT - протеин шейк клубника',
                    style: DefaultAppTheme.title1.override(
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Text(
                            '22 600 тг/шт',
                            style: DefaultAppTheme.title1.override(
                              fontFamily: 'Gilroy',
                              color: DefaultAppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      print('removeBtn pressed ...');
                                    },
                                    child: Text('-'),
                                    style: DefaultAppTheme.buttonCircular),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 0),
                                  child: Text(
                                    '100',
                                    textAlign: TextAlign.center,
                                    style: DefaultAppTheme.title2.override(
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    print('addBtn pressed ...');
                                  },
                                  child: Text('+'),
                                  style: DefaultAppTheme.buttonCircular,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                  child: Text(
                    'Мини описание продукта, раскрывающее его суть и дает возможность лучге понять продукт. Мини описание продукта, раскрывающее его суть и дает возможность лучге понять продукт. \nМини описание продукта, раскрывающее его суть и дает возможность лучге понять продукт. \nМини описание продукта, раскрывающее его суть и дает возможность лучге понять продукт. ',
                    style: DefaultAppTheme.bodyText1.override(
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                  child: Text(
                    'Похожие товары',
                    style: DefaultAppTheme.title2.override(
                      fontFamily: 'Gilroy',
                      color: DefaultAppTheme.grayLight,
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 11, 0, 0),
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: SizedBox(
                //       height: 260,
                //       child: Row(
                //         mainAxisSize: MainAxisSize.max,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding:
                //                 EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                //             child: ProductCardWidget(),
                //           ),
                //           Padding(
                //             padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                //             child: ProductCardWidget(),
                //           ),
                //           Padding(
                //             padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                //             child: ProductCardWidget(),
                //           ),
                //           Padding(
                //             padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                //             child: ProductCardWidget(),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}

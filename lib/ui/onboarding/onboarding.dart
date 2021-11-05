import 'package:esentai/ui/home/home.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  // TODO: download from api
  final List<String> _slides = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png',
    'assets/images/slide4.png',
    'assets/images/slide5.png',
  ];

  final List<Map<String, String>> _texts = [
    {
      "header": "Информация о кулинарии",
      "body":
          "В частности, выбранный нами инновационный путь, а также свежий взгляд на привычные вещи - безусловно открывает новые горизонты для поставленных обществом задач."
    },
    {
      "header": "Информация о товарах",
      "body":
          "В частности, выбранный нами инновационный путь, а также свежий взгляд на привычные вещи - безусловно открывает новые горизонты для поставленных обществом задач."
    },
    {
      "header": "Информация о программе лояльности",
      "body":
          "В частности, выбранный нами инновационный путь, а также свежий взгляд на привычные вещи - безусловно открывает новые горизонты для поставленных обществом задач."
    },
    {
      "header": "Информация о баре",
      "body":
          "В частности, выбранный нами инновационный путь, а также свежий взгляд на привычные вещи - безусловно открывает новые горизонты для поставленных обществом задач."
    },
    {
      "header": "Информация о доставке",
      "body":
          "В частности, выбранный нами инновационный путь, а также свежий взгляд на привычные вещи - безусловно открывает новые горизонты для поставленных обществом задач."
    },
  ];

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 36, 0, 0),
                child: SvgPicture.asset(
                  'assets/images/logo_black.svg',
                  width: 115,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: 265,
                        // autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                        viewportFraction: 0.60,
                        // aspectRatio: 2,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true),
                    items: _slides
                        .map((item) => Container(
                              child: Center(child: Image.asset(item)),
                            ))
                        .toList(),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _slides.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == entry.key
                                ? DefaultAppTheme.primaryColor
                                : DefaultAppTheme.grayLight,
                          )),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  _texts[_current]['header']!,
                  textAlign: TextAlign.center,
                  style: DefaultAppTheme.title1,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                child: Text(
                  _texts[_current]['body']!,
                  textAlign: TextAlign.center,
                  style: DefaultAppTheme.bodyText1
                      .override(color: Color(0xFF8F8F8F)),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 18, 16, 0),
                child: ElevatedButton(
                  onPressed: () {
                    // go to login route
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  },
                  child: Text('Перейти к авторизации'),
                  style: DefaultAppTheme.buttonDefaultStyle,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(64, 0, 64, 16),
                child: ElevatedButton(
                  onPressed: () {
                    // go to nav home
                    Navigator.of(context).pushReplacementNamed(Routes.home);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      textStyle: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal)),
                  child: Text(
                    'Пропустить авторизацию',
                    style: TextStyle(color: DefaultAppTheme.primaryColor),
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

import 'package:esentai/stores/user/user_store.dart';
import 'package:esentai/ui/address/pick_on_map.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/default_input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddNewCreditCardScreen extends StatefulWidget {
  AddNewCreditCardScreen({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  _AddNewCreditCardScreenState createState() => _AddNewCreditCardScreenState();
}

class _AddNewCreditCardScreenState extends State<AddNewCreditCardScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          'Добавить карту',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 100),
              child: WebView(
                initialUrl: '${widget.link}',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            // Align(
            //   alignment: Alignment(0, 1),
            //   child: Padding(
            //       padding:
            //           const EdgeInsets.only(bottom: 32, left: 32, right: 32),
            //       child: Container(
            //         color: Colors.white,
            //         child: ElevatedButton(
            //           style: DefaultAppTheme.buttonDefaultStyle,
            //           onPressed: () {
            //             _onSubmit();
            //           },
            //           child: Text('Вернуться в приложение'),
            //         ),
            //       )),
            // ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    Navigator.of(context).pop();
  }
}

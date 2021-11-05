import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostcardTextFieldWidget extends StatefulWidget {
  PostcardTextFieldWidget({Key? key}) : super(key: key);

  @override
  _PostcardTextFieldWidgetState createState() =>
      _PostcardTextFieldWidgetState();
}

class _PostcardTextFieldWidgetState extends State<PostcardTextFieldWidget> {
  TextEditingController _textController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: 60,
          height: 5,
          decoration: BoxDecoration(
            color: DefaultAppTheme.grey3,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        // height: 100,
        decoration: BoxDecoration(
            // color: Colors.white,
            ),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 0),
            child: Text(
              'Текст на открытку',
              textAlign: TextAlign.center,
              style: DefaultAppTheme.title2,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 0),
            child: Text(
              'Чтобы подписать открытку самому, оставьте открытку незаполненной ',
              textAlign: TextAlign.center,
              style: DefaultAppTheme.title3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextFormField(
              controller: _textController,
              onChanged: (val) {
                // _textController.text = val;
                setState(() {
                  _hasText = _textController.text.isNotEmpty;
                });
              },
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Введите текст для открытки...',
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: DefaultAppTheme.grayLight, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: DefaultAppTheme.grayLight, width: 1.0),
                ),
                contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              ),
              style: DefaultAppTheme.bodyText1,
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                16, 10, 16, MediaQuery.of(context).viewInsets.bottom + 16),
            child: ElevatedButton(
              onPressed: () {
                _onSubmit();
              },
              child: Text(!_hasText
                  ? 'Оставить открытку пустой'
                  : 'Отправить открытку'),
              style: !_hasText
                  ? DefaultAppTheme.buttonOutlineStyle
                  : DefaultAppTheme.buttonDefaultStyle,
            ),
          ),
        ]),
      ),
    ]);
  }

  void _onSubmit() {
    String message = _textController.text;
    Navigator.pop(context, message);
  }
}

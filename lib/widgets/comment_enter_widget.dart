import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentEnterWidget extends StatefulWidget {
  CommentEnterWidget({Key? key}) : super(key: key);

  @override
  _CommentEnterWidgetState createState() => _CommentEnterWidgetState();
}

class _CommentEnterWidgetState extends State<CommentEnterWidget> {
  late OrderStore _orderStore;

  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orderStore = Provider.of<OrderStore>(context);

    if (_orderStore.comment != null) {
      _textController.text = _orderStore.comment!;
    }
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
          Align(
            alignment: AlignmentDirectional(-1, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 0),
              child: Text(
                'Комментарий',
                style: DefaultAppTheme.title2.override(
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: TextFormField(
              controller: _textController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Введите ваш комментарий...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                ),
                contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              ),
              style: DefaultAppTheme.bodyText1.override(
                fontFamily: 'Gilroy',
              ),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                16, 10, 16, MediaQuery.of(context).viewInsets.bottom + 16),
            child: ElevatedButton(
              onPressed: () {
                _onCommentSubmit();
              },
              child: Text('Отправить комментарий'),
              style: DefaultAppTheme.buttonDefaultStyle,
            ),
          ),
        ]),
      ),
    ]);
  }

  void _onCommentSubmit() {
    _orderStore.comment = _textController.text;

    if (_orderStore.comment!.isEmpty) {
      _orderStore.comment = null;
    }

    Navigator.of(context).pop();
  }
}

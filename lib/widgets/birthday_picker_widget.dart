import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BirthdayPickerWidget extends StatefulWidget {
  BirthdayPickerWidget({Key? key, required this.onPressed}) : super(key: key);

  final Function() onPressed;

  @override
  BirthdayPickerWidgetState createState() => BirthdayPickerWidgetState();
}

class BirthdayPickerWidgetState extends State<BirthdayPickerWidget> {
  // late TextEditingController _fieldController;
  bool _hasErrors = false;
  bool _hasDate = false;

  String _dateString = '';
  DateTime? _date = DateTime.now();

  void updateDate(DateTime newDate) {
    setState(() {
      _dateString = DateFormat('dd.MM.yyyy').format(newDate);
      _date = newDate;
      _hasDate = true;
    });
  }

  DateTime? getDate() {
    return _date;
  }

  String getString() {
    return _hasDate ? _dateString : '';
  }

  void clearDate() {
    setState(() {
      _dateString = 'ДД.ММ.ГГГГ';
      _date = null;
      _hasDate = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _dateString = 'ДД.ММ.ГГГГ';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'День рождения (не обязательно)',
                style: DefaultAppTheme.subtitle2.override(
                    fontFamily: 'Gilroy', color: DefaultAppTheme.textColor),
              ),
              if (_hasDate)
                InkWell(
                  onTap: () {
                    clearDate();
                  },
                  child: Icon(
                    Icons.cancel,
                    color: DefaultAppTheme.textColor,
                    size: 15,
                  ),
                ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // show leading icon
              Image.asset(
                _hasDate
                    ? 'assets/images/ic_birthday_active.png'
                    : 'assets/images/ic_birthday.png',
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),

              // show text controller
              Expanded(
                child: InkWell(
                  onTap: widget.onPressed,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    child: Text(
                      _dateString,
                      style: TextStyle(
                          color: _hasDate
                              ? DefaultAppTheme.textColor
                              : DefaultAppTheme.grayLight),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(0.0),
          //   child: Divider(
          //     // height: 1,
          //     thickness: 0.25,
          //     color: widget.color,
          //   ),
          // )
          Divider(
              height: 1,
              color: _hasErrors
                  ? DefaultAppTheme.secondaryColor
                  : DefaultAppTheme.textColor)
        ],
      ),
    );
  }

  void setErrors() {
    setState(() {
      _hasErrors = true;
    });
  }

  void clearErrors() {
    setState(() {
      _hasErrors = false;
    });
  }
}

typedef BirthdayCallback = void Function(String string);

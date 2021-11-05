import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DefaultInputFieldWidget extends StatefulWidget {
  DefaultInputFieldWidget(
      {Key? key,
      this.formatter,
      required this.label,
      this.leadingIconDefault,
      this.leadingIconActive,
      this.trailingIconDefault,
      this.trailingIconActive,
      required this.hint,
      required this.color,
      this.keyboardType = TextInputType.none,
      this.errorColor = DefaultAppTheme.secondaryColor,
      required this.controller})
      : super(key: key);

  final String label;
  final String? leadingIconDefault;
  final String? leadingIconActive;
  final String? trailingIconDefault;
  final String? trailingIconActive;
  final String hint;
  final Color color;
  final Color errorColor;
  final TextInputType keyboardType;
  final TextEditingController controller;
  MaskTextInputFormatter? formatter;

  @override
  DefaultInputFieldWidgetState createState() => DefaultInputFieldWidgetState();
}

class DefaultInputFieldWidgetState extends State<DefaultInputFieldWidget> {
  // late TextEditingController _fieldController;
  bool _hasErrors = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    // _fieldController = TextEditingController();

    setState(() {
      _hasText = widget.controller.text.isNotEmpty;
      _hasErrors = false;
    });
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
          Text(
            widget.label,
            style: DefaultAppTheme.subtitle2.override(
                fontFamily: 'Gilroy',
                color: _hasErrors ? widget.errorColor : widget.color),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // show leading icon
              if (widget.leadingIconDefault != null &&
                  widget.leadingIconDefault!.isNotEmpty)
                Image.asset(
                  _hasText
                      ? widget.leadingIconActive!
                      : widget.leadingIconDefault!,
                  width: 15,
                  height: 15,
                  fit: BoxFit.contain,
                ),

              // show text controller
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  onChanged: (value) {
                    if (widget.controller.text.isNotEmpty) {
                      clearErrors();
                      setState(() {
                        _hasText = true;
                      });
                    } else {
                      setState(() {
                        _hasText = false;
                      });
                    }
                  },
                  obscureText: false,
                  keyboardType: widget.keyboardType,
                  inputFormatters:
                      widget.formatter != null ? [widget.formatter!] : [],
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.hint,
                    hintStyle: DefaultAppTheme.bodyText2,
                    errorStyle: TextStyle(color: widget.errorColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(12, 5, 0, 12),
                  ),
                  style: DefaultAppTheme.bodyText1,
                ),
              ),

              // show trailing icon
              if (widget.trailingIconDefault != null &&
                  widget.trailingIconDefault!.isNotEmpty)
                Image.asset(
                  _hasText
                      ? widget.trailingIconDefault!
                      : widget.trailingIconActive!,
                  width: 15,
                  height: 15,
                  fit: BoxFit.contain,
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
              height: 1, color: _hasErrors ? widget.errorColor : widget.color)
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

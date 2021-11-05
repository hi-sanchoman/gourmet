import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double _kChoiceChipsHeight = 40.0;

class ChipData {
  const ChipData(this.label, [this.iconData]);
  final String label;
  final IconData? iconData;
}

class ChipStyle {
  const ChipStyle(
      {this.backgroundColor,
      this.textStyle,
      this.iconColor,
      this.iconSize,
      this.labelPadding,
      this.elevation});
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? labelPadding;
  final double? elevation;
}

class FlutterFlowChoiceChips extends StatefulWidget {
  const FlutterFlowChoiceChips({
    this.initialOption,
    required this.options,
    required this.onChanged,
    this.selectedChipStyle,
    this.unselectedChipStyle,
    this.chipSpacing,
    this.shape,
  });

  final String? initialOption;
  final List<ChipData> options;
  final void Function(String) onChanged;
  final ChipStyle? selectedChipStyle;
  final ChipStyle? unselectedChipStyle;
  final double? chipSpacing;
  final ShapeBorder? shape;

  @override
  State<FlutterFlowChoiceChips> createState() => _FlutterFlowChoiceChipsState();
}

class _FlutterFlowChoiceChipsState extends State<FlutterFlowChoiceChips> {
  String? _choice;

  @override
  void initState() {
    super.initState();
    _choice = widget.initialOption ?? widget.options.first.label;
  }

  @override
  Widget build(BuildContext context) => Container(
        height: _kChoiceChipsHeight,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: widget.options.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final option = widget.options[index];
            final selected = option.label == _choice;
            final style = selected
                ? widget.selectedChipStyle
                : widget.unselectedChipStyle;
            return ChoiceChip(
              selected: selected,
              onSelected: (isSelected) {
                if (isSelected) {
                  _choice = option.label;
                  widget.onChanged(_choice!);
                  setState(() {});
                }
              },
              label: Text(
                option.label,
                style: style?.textStyle,
              ),
              labelPadding: style?.labelPadding,
              avatar: option.iconData != null
                  ? FaIcon(
                      option.iconData,
                      size: style?.iconSize,
                      color: style?.iconColor,
                    )
                  : null,
              elevation: style?.elevation,
              selectedColor:
                  selected ? widget.selectedChipStyle?.backgroundColor : null,
              backgroundColor:
                  selected ? null : widget.unselectedChipStyle?.backgroundColor,
            );
          },
          separatorBuilder: (_, __) => SizedBox(width: widget.chipSpacing),
        ),
      );
}

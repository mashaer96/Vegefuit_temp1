import 'package:flutter/material.dart';
import 'package:vegefruit/localization/demo_localization.dart';

// ignore: must_be_immutable
class DropdownWidget extends StatefulWidget {
  final String hint;
  String newValue;
  String initValue;
  final Function getValue;
  final List<String> valuesList;

  DropdownWidget(
      {this.hint,
      this.newValue,
      this.getValue,
      this.valuesList,
      this.initValue});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;
    return Container(
      height: (height) * 0.08,
      width: (width) * 0.3,
      child: DropdownButtonFormField<String>(
        hint: Text(widget.hint),
        value: widget.initValue,
        onChanged: (input) {
          setState(() {
            widget.newValue = widget.getValue(input);
          });
        },
        validator: (String input) {
          if (widget.newValue == '') {
            return getTranslated(context, 'required');
          }
          return null;
        },
        items: widget.valuesList.map<DropdownMenuItem<String>>((String input) {
          return DropdownMenuItem<String>(
            value: input,
            child: Text(input),
          );
        }).toList(),
      ),
    );
  }
}

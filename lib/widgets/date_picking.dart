import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DatePickingWidget extends StatefulWidget {
  String textHint;
  DateTime pickedDate;

  Function pickerFunction;

  DatePickingWidget({this.textHint, this.pickedDate, this.pickerFunction});
  @override
  _DatePickingWidgetState createState() => _DatePickingWidgetState();
}

class _DatePickingWidgetState extends State<DatePickingWidget> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;

    return Row(
      children: [
        Container(
          width: (width) * 0.3,
          child: Text(
            widget.pickedDate == null
                ? widget.textHint
                : widget.textHint.substring(0, 5) +
                    DateFormat.yMd().format(widget.pickedDate),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.date_range),
          iconSize: 28,
          onPressed: widget.pickerFunction,
        ),
      ],
    );
  }
}

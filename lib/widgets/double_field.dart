import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../localization/demo_localization.dart';

class DoubleFieldWidget extends StatelessWidget {
  final String doubleHint;
  final TextEditingController doubleController;
  final bool isKilo;
  final String validateRelated;

  const DoubleFieldWidget(
      {this.doubleHint,
      this.doubleController,
      this.isKilo,
      this.validateRelated});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;
    return Container(
      height: (height) * 0.08,
      width: (width) * 0.17,
      child: TextFormField(
        controller: doubleController,
        decoration: InputDecoration(
          hintText: doubleHint.toString(),
        ),
        keyboardType: TextInputType.number,
        cursorColor: Theme.of(context).primaryColor,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        ],
        validator: (String input) {
          if (isKilo) {
            if (input.isEmpty) {
              if (validateRelated == getTranslated(context, 'perBox') ||
                  validateRelated == getTranslated(context, 'perBag')) {
                return getTranslated(context, 'required');
              }
              return null;
            }
          } else {
            if (input.isEmpty) {
              return getTranslated(context, 'required');
            }
          }
          return null;
        },
      ),
    );
  }
}

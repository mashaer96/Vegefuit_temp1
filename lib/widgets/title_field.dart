import 'package:flutter/material.dart';
import '../localization/demo_localization.dart';

class TitleFieldWidget extends StatelessWidget {
  final String titleHint;
  final TextEditingController titleController;
  

  TitleFieldWidget({this.titleHint, this.titleController});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;

    return Row(
      children: [
        Container(
          height: (height) * 0.08,
          width: (width) * 0.5,
          child: TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: titleHint,
            ),
            keyboardType: TextInputType.name,
            cursorColor: Theme.of(context).primaryColor,
            validator: (String input) {
              if (input.isEmpty) {
                return getTranslated(context, 'required');
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
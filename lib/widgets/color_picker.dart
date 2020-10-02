import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// ignore: must_be_immutable
class ColorPickerWidget extends StatefulWidget {
  Color currentColor;
  Function changeColor;
  ColorPickerWidget(this.currentColor, this.changeColor);
  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select a color'),
              content: SingleChildScrollView(
                child: Container(
                  height: (height) * 0.2,
                  child: BlockPicker(
                    pickerColor: widget.currentColor,
                    onColorChanged: widget.changeColor,
                    availableColors: [
                      // Color(0xffffeb3b),
                      // Color(0xFF8B84F3),
                      // Color(0xFF79DE64),
                      // Color(0xFFFF8D22),
                      // Color(0xFFEC75EA),
                      // Color(0xFFFF3B4A),
                      // Color(0xFF42B1FF),
                      Color(0xffffef62),
                      Color(0xFF9791f4),
                      Color(0xFF83e06f),
                      Color(0xFFf9913e),
                      Color(0xFFef8bed),
                      Color(0xFFff5562),
                      Color(0xFF5cbcff),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: (width) * 0.12,
        height: (height) * 0.07,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Icon(
          Icons.color_lens,
          color: Colors.black,
          size: 28,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app2/utils/colors/colors_contant.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onchangeBorder,
  });

  final int index;
  final int selectedIndex;
  final VoidCallback onchangeBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onchangeBorder,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Color(ColorsConstant.color[index]),
                border: Border.all(
                    width: 3,
                    color: selectedIndex == index
                        ? Colors.black
                        : Colors.transparent)),
          )),
    );
  }
}

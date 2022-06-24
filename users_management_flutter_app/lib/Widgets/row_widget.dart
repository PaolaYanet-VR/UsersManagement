import 'package:flutter/material.dart';
import '../Shared/responsive.dart';
import '../Utils/Global.dart';

class RowWidget extends StatelessWidget {
  final String? title;
  final bool? hasColor;
  final void Function()? onPressed;
  final Color? color;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool? otherColor;
  final Color? colorField;

  const RowWidget({
    Key? key,
    this.title,
    this.hasColor,
    this.onPressed,
    this.color,
    this.height = 20.0,
    this.width = -1.0,
    this.fontSize,
    this.otherColor = false,
    this.colorField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSizeButton = 0;

    if (isTab(context) || isDesktop(context)) {
      fontSizeButton = fontSize ?? 20;
    } else if (isMobile(context)) {
      fontSizeButton = fontSize ?? 14;
    }

    return Material(
      
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
        child: Ink(
          decoration: BoxDecoration(
              color: hasColor!
                  ? Colors.white
                  : otherColor!
                      ? colorField
                      : colorField),
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              height: height,
              width: width! < 0 ? MediaQuery.of(context).size.width : width!,
              child: Text(
                title!,
                style: TextStyle(
                  color: hasColor! ? Colors.black : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSizeButton,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

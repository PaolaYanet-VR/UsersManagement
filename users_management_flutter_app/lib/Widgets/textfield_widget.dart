import 'package:flutter/material.dart';
import '../Shared/responsive.dart';
import '../Utils/Global.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final bool? isSuffixIcon;
  final bool? isPrefixIcon;
  final void Function()? onTap;
  final bool? readOnly;
  final bool? otherColor;
  final Color? color;
  final int? maxlong;
  final void Function()? onSuffixIconTap;
  final bool? isMaxLong;
  final bool? isFilled;
  final TextEditingController? controller;
  final bool? isMyControllerActivated;

  const TextFieldWidget({
    Key? key,
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.onChanged,
    this.obscureText = false,
    this.isSuffixIcon = false,
    this.isPrefixIcon = false,
    this.onTap,
    this.readOnly = false,
    this.otherColor = false,
    this.color = Global.colorGray,
    this.maxlong = 50,
    this.onSuffixIconTap,
    this.isMaxLong = false,
    this.isFilled = false,
    this.controller,
    this.isMyControllerActivated = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSizeTextField = 0;

    if (isTab(context) || isDesktop(context)) {
      fontSizeTextField = 20;
    } else if (isMobile(context)) {
      fontSizeTextField = 14;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 50.0, left: 50.0),
      child: TextFormField(
        maxLength: isMaxLong == false ? null : maxlong,
        controller: isMyControllerActivated == false ? null : controller,
        textInputAction: TextInputAction.done,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly!,
        obscureText: obscureText!,
        cursorColor: color,
        style: TextStyle(color: color, fontSize: fontSizeTextField),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: color),
          focusColor: color,
          filled: isFilled,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: color!)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: color!)),
          labelText: hintText,
          prefixIcon: isPrefixIcon == false
              ? null
              : Icon(
                  prefixIconData,
                  size: 30,
                  color: color,
                ),
          suffixIcon: isSuffixIcon == false
              ? null
              : GestureDetector(
                  onTap: onSuffixIconTap,
                  child: Icon(
                    suffixIconData,
                    size: 25,
                    color: color,
                  ),
                ),
        ),
      ),
    );
  }
}
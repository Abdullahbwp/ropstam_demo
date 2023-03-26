// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final int? maxline;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final String? fontFamily;

  const CustomText({
    Key? key,
    this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.overflow,
    this.textAlign,
    this.maxline,
    this.decoration,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxline,
    );
  }
}

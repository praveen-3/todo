import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DSTextView extends StatelessWidget {
  String? data;
  TextStyle? style;
  TextAlign? textAlign;
  int? maxLines;

  DSTextView({
    Key? key,
    this.data,
    this.style,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? "",
      key: key,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

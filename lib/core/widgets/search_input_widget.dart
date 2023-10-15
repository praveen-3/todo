import 'package:flutter/material.dart';

import '../../../../core/res/dimens.dart';
import '../res/ac_colors.dart';
import '../res/ac_images.dart';
import 'ac_image_view.dart';
import 'text_input_widget.dart';

// ignore: must_be_immutable
class SearchInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final EdgeInsetsGeometry? margin;
  Color? bgColor;
  final Function() onPressed;
  int? textFlex;
  SearchInputWidget(this.controller, this.onPressed,
      {super.key,
      this.hintText = '',
      this.bgColor,
      this.margin,
      this.textFlex});
  @override
  _SearchInputWidget createState() => _SearchInputWidget();
}

class _SearchInputWidget extends State<SearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.all(Dimens.dimen_20),
      decoration: BoxDecoration(
        color: (widget.bgColor) ?? AcColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.dimen_30),
          bottomLeft: Radius.circular(Dimens.dimen_30),
          bottomRight: Radius.circular(Dimens.dimen_30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: Dimens.dimen_5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: Dimens.dimen_20,
                width: Dimens.dimen_20,
                child: AcImageView.fromLocal(
                  AcImages.icSearch,
                ),
              ),
            ),
            Expanded(
              flex: widget.textFlex ?? 8,
              child: TextInputWidget(
                controller: widget.controller,
                hintText: widget.hintText,
                onPressed: () {
                  widget.onPressed();
                },
                clearButtonIcon: AcImages.cancelButtonGrey,
                showCancelButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

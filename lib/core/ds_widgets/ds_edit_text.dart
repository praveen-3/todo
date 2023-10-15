import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_flutter/core/res/ac_colors.dart';
import 'package:todo_flutter/core/res/ac_images.dart';
import 'package:todo_flutter/core/widgets/ac_image_view.dart';

import '../constants/application_constants.dart';
import '../res/dimens.dart';
import '../res/styles/ac_text_styles.dart';

// ignore: must_be_immutable
class DSEditText extends StatefulWidget {
  String? labelText;
  TextEditingController? controller;
  bool isPasswordField;
  String? errorText;
  bool? hasError;
  FocusNode? focusNode;
  final void Function()? onTextChangedValidator;

  DSEditText(this.labelText, this.isPasswordField, this.controller,
      this.errorText, this.hasError, this.focusNode,
      {super.key, this.onTextChangedValidator});
  @override
  State<DSEditText> createState() => _DSEditTextWidgetState();
}

class _DSEditTextWidgetState extends State<DSEditText> {
  bool _obscured = true;
  String passwordToggleImage = AcImages.passwordUnhide;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscured & widget.isPasswordField,
      controller: widget.controller,
      onChanged: (text) {
        widget.hasError = null;
        if (widget.onTextChangedValidator != null)
          widget.onTextChangedValidator!();
        setState(() {});
      },
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: Dimens.dimen_9,
          bottom: Dimens.dimen_9,
          left: Dimens.dimen_14,
          right: Dimens.dimen_14,
        ),
        errorText: widget.hasError ?? false ? widget.errorText : null,
        errorStyle: AcTextStyles.getRed10dpRegTextStyle(),
        labelText: widget.labelText,
        labelStyle: AcTextStyles.getBlack4016dpSemiBoldTextStyle(),
        floatingLabelStyle: AcTextStyles.getBlack4012dpRegTextStyle(),
        filled: true,
        fillColor: AcColors.whitePurple,
        isDense: true,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          splashColor: AcColors.black,
          onPressed: () {
            !widget.isPasswordField
                ? setState(() {
                    widget.controller?.clear();
                  })
                : setState(
                    () {
                      _obscured = !_obscured;
                      passwordToggleImage = _obscured
                          ? AcImages.passwordUnhide
                          : AcImages.passwordHide;
                    },
                  );
          },
          icon: !widget.isPasswordField
              ? (widget.controller != null && widget.controller!.text.isNotEmpty
                  ? AcImageView.fromLocal(AcImages.clearText)
                  : Container())
              : SvgPicture.asset(
                  ApplicationConstants.IMAGES_DIR_LOCATION +
                      passwordToggleImage,
                ),
        ),
      ),
      style: AcTextStyles.getBlack8716dpSemiBoldTextStyle(),
    );
  }
}

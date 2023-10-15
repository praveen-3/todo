import 'package:flutter/material.dart';

import '../res/ac_colors.dart';
import '../res/ac_images.dart';
import '../res/styles/ac_text_styles.dart';
import 'clear_button_widget.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFee7b64), width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFee7b64), width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFee7b64), width: 2),
  ),
);

// ignore: must_be_immutable
class TextInputWidget extends StatefulWidget {
  final TextEditingController controller;
  Function() onPressed;
  final String hintText;
  final bool readOnly;
  TextInputType? textInputType;
  final bool showCancelButton;
  final bool clearDataOnTap;
  Function()? cancelButtonInteraction;
  final String clearButtonIcon;

  TextInputWidget({
    super.key,
    this.readOnly = false,
    required this.controller,
    required this.hintText,
    required this.onPressed,
    this.textInputType,
    this.showCancelButton = true,
    this.clearDataOnTap = true,
    this.cancelButtonInteraction,
    this.clearButtonIcon = AcImages.cancelButtonLightGrey,
  });

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  bool isEditing = false;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isEditing = _focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      smartDashesType: SmartDashesType.disabled,
      readOnly: widget.readOnly,
      focusNode: _focus,
      controller: widget.controller,
      cursorColor: AcColors.primary,
      style: AcTextStyles.getPrimary14dpSemiBoldTextStyle(),
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: widget.hintText,
        hintStyle: AcTextStyles.getGreyReg14TextStyle(),
        suffix: widget.showCancelButton &&
                widget.controller.text.isNotEmpty &&
                isEditing
            ? ClearButton(
                () {
                  if (widget.cancelButtonInteraction != null) {
                    widget.cancelButtonInteraction!();
                  }
                  if (widget.clearDataOnTap) {
                    widget.controller.clear();
                    widget.onPressed();
                  }
                },
                clearButtonIcon: widget.clearButtonIcon,
              )
            : null,
      ),
      onChanged: (text) {
        widget.onPressed();
      },
    );
  }
}

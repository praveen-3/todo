import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_flutter/core/res/ac_colors.dart';
import 'package:todo_flutter/core/res/ac_images.dart';

import '../res/dimens.dart';

enum ButtonType { primary, secondary, ghost }

extension MethodExtension on ButtonType {
  String get value => ['primary', 'secondary', 'ghost'][index];
}

class DSButton extends StatefulWidget {
  final void Function()? onPressed;
  final String lable;
  final bool isLoading;
  final TextStyle? textStyle;
  final ButtonType? buttonType;
  final double topBottomPadding;
  final bool isDisabled;
  final EdgeInsets? ghostButtonPadding;

  const DSButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    required this.lable,
    required this.textStyle,
    required this.topBottomPadding,
    required this.buttonType,
    required this.isDisabled,
    this.ghostButtonPadding,
  }) : super(key: key);

  @override
  State<DSButton> createState() => _DSButtonState();
}

class _DSButtonState extends State<DSButton> {
  bool isColorChanged = false;

  @override
  Widget build(BuildContext context) {
    return !widget.isLoading
        ? Opacity(
            opacity: widget.isDisabled ? 0.3 : 1,
            child: widget.buttonType == ButtonType.ghost
                ? TextButton(
                    onPressed: () {
                      if (widget.onPressed != null) widget.onPressed!();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AcColors.transparent,
                    ),
                    child: Padding(
                      padding: widget.ghostButtonPadding == null
                          ? EdgeInsets.zero
                          : widget.ghostButtonPadding!,
                      child: Text(widget.lable, style: widget.textStyle),
                    ))
                : TextButton(
                    onPressed: widget.onPressed,
                    style: ButtonStyle(
                      maximumSize: widget.buttonType == ButtonType.ghost
                          ? MaterialStateProperty.all(Size.zero)
                          : MaterialStateProperty.all(Size.infinite),
                      tapTargetSize: widget.buttonType == ButtonType.ghost
                          ? MaterialTapTargetSize.shrinkWrap
                          : MaterialTapTargetSize.padded,
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.dimen_8))),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          AcColors.transparent),
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return widget.buttonType == ButtonType.primary
                                ? AcColors.black69
                                : AcColors.purpleLight;
                          }
                          return widget.buttonType == ButtonType.primary
                              ? AcColors.primary
                              : AcColors.primaryLight;
                        },
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: widget.topBottomPadding,
                          bottom: widget.topBottomPadding),
                      child: Text(
                        widget.lable,
                        style: widget.textStyle,
                      ),
                    ),
                  ),
          )
        : Container(
            margin: EdgeInsets.only(
              left: Dimens.dimen_120,
              right: Dimens.dimen_120,
            ),
            height: Dimens.dimen_60,
            child: Lottie.asset(AcImages.ctaLoader, fit: BoxFit.fill),
          );
  }
}

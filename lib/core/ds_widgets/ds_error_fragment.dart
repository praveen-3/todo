import 'package:flutter/material.dart';
import 'package:todo_flutter/core/widgets/ac_image_view.dart';

import '../res/ac_images.dart';
import '../res/dimens.dart';
import '../res/styles/ac_text_styles.dart';
import 'data/models/error_data.dart';
import 'ds_button.dart';
import 'ds_text_view.dart';

// ignore: must_be_immutable
class DSErrorFragmentWidget extends StatefulWidget {
  final ErrorDataModel errData;

  DSErrorFragmentWidget(this.errData);

  @override
  State<DSErrorFragmentWidget> createState() => _DSErrorFragmentWidgetState();
}

class _DSErrorFragmentWidgetState extends State<DSErrorFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Dimens.dimen_200,
          height: Dimens.dimen_200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.dimen_8)),
          ),
          child: AcImageView.fromLocal(widget.errData.imageString == null
              ? AcImages.icErrorSomethingWentWrong
              : widget.errData.imageString!),
        ),
        Container(
            margin:
                EdgeInsets.only(top: Dimens.dimen_20, bottom: Dimens.dimen_8),
            child: DSTextView(
              data: widget.errData.heading,
              style: AcTextStyles.getBlack8722dpSemiBoldTextStyle(),
              textAlign: TextAlign.center,
            )),
        Container(
          margin: EdgeInsets.only(
            left: Dimens.dimen_48,
            right: Dimens.dimen_48,
            bottom: Dimens.dimen_24,
          ),
          child: DSTextView(
            data:
                (widget.errData.message == null ? '' : widget.errData.message!),
            style: AcTextStyles.getBlack6016dpRegTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(left: Dimens.dimen_16, right: Dimens.dimen_16),
          height: Dimens.dimen_48,
          width: double.infinity,
          child: Row(
            children: [
              Visibility(
                visible: widget.errData.btnType == 2 ? true : false,
                child: Expanded(
                  child: Container(
                    width: double.infinity,
                    height: Dimens.dimen_48,
                    margin: EdgeInsets.only(right: Dimens.dimen_16),
                    child: DSButton(
                      onPressed: () {
                        if (widget.errData.secondaryButtonAction != null)
                          widget.errData.secondaryButtonAction!();
                      },
                      topBottomPadding: Dimens.dimen_0,
                      lable: widget.errData.actionBtnSecondaryLabel == null
                          ? "TRY_AGAIN"
                          : widget.errData.actionBtnSecondaryLabel!,
                      isLoading: false,
                      isDisabled: false,
                      textStyle: AcTextStyles.getPrimary20dpBoldTextStyle(),
                      buttonType: ButtonType.secondary,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.errData.btnType == 0 ? false : true,
                child: Expanded(
                  child: Container(
                    width: double.infinity,
                    height: Dimens.dimen_48,
                    margin: EdgeInsets.zero,
                    child: DSButton(
                      onPressed: () {
                        if (widget.errData.primaryButtonAction != null) {
                          widget.errData.primaryButtonAction!();
                        }
                      },
                      topBottomPadding: Dimens.dimen_0,
                      lable: widget.errData.actionBtnPrimaryLabel == null
                          ? "CANCEL"
                          : widget.errData.actionBtnPrimaryLabel!,
                      isLoading: false,
                      isDisabled: false,
                      textStyle: AcTextStyles.getWhite20dpBoldTextStyle(),
                      buttonType: ButtonType.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

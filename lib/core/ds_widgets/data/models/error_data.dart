class ErrorDataModel {
  String? imageString;
  String heading;
  String? message;
  String? actionBtnPrimaryLabel;
  String? actionBtnSecondaryLabel;
  int btnType;
  Function()? primaryButtonAction;
  Function()? secondaryButtonAction;

  ErrorDataModel(
    this.imageString,
    this.heading,
    this.message,
    this.actionBtnPrimaryLabel,
    this.actionBtnSecondaryLabel,
    this.btnType,
    this.primaryButtonAction,
    this.secondaryButtonAction,
  );
}

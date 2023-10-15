import 'package:intl/intl.dart';

extension Parsing on num {
  String getIntOrNumberString() {
    if (this.isInteger()) {
      return this.toStringAsFixed(0);
    } else {
      return this.toString();
    }
  }

  String getShortenedNumber({int? decimaldigits}) {
    var _formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimaldigits ?? 0,
      symbol:
          '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(this);
    return _formattedNumber;
  }

  String addingZeroPrefix() {
    String returnString = this.toString();
    if (this < 10) {
      returnString = "0" + returnString;
    }
    return returnString;
  }

  num returnSpecific(num matchingValue) {
    if (this == matchingValue) return matchingValue;
    return this;
  }

  bool isInteger() => this is int || this == this.roundToDouble();
}

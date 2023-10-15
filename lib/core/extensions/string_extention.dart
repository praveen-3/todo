import '../app_data_types/tuple.dart';

extension Parsing on String {
  bool? checkAndParseBool() {
    String ignoreCase = toLowerCase();
    if (ignoreCase == "true") {
      return true;
    } else if (ignoreCase == "false") {
      return false;
    } else {
      return null;
    }
  }

  String breakWord() {
    String breakWord = '';
    for (var element in runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }

  double? checkAndParseDouble() {
    return double.tryParse(this);
  }

  int? checkAndParseInt() {
    return int.tryParse(this);
  }

  dynamic returnCastedPrimitiveType() {
    dynamic result;
    result = checkAndParseBool();
    if (result == null) {
      result = checkAndParseInt();
      if (result == null) {
        result = checkAndParseDouble();
        if (result == null) {
          return this;
        } else {
          return result;
        }
      } else {
        return result;
      }
    } else {
      return result;
    }
  }

  Tuple<String, String> splitByLast(String sepetator) {
    List<String> list = split(sepetator);
    String last;
    String first;
    if (list.length == 1) {
      first = list[0];
      last = "";
    } else {
      last = list.last;
      first = list.take(list.length - 1).join(sepetator);
    }
    return Tuple(first, last);
  }
}

extension TemplateParsing on String {
  String getStringFromTemplate(Map<String, dynamic> valueMap) {
    String resultString = "";
    int templateLength = length;

    for (int i = 0; i < templateLength; i++) {
      if (this[i] == "%" && i + 2 < templateLength && this[i + 1] == "{") {
        var variableName = "";
        var notFoundFallbackString = "%{";
        var endFound = false;
        for (int j = i + 2; j < templateLength; j++) {
          if (this[j] == "%" && j + 2 < templateLength && this[j + 1] == "{") {
            break;
          }
          i = j;
          if (this[j] == "}") {
            endFound = true;
            break;
          }
          notFoundFallbackString += this[j];
          variableName += this[j];
        }
        if (endFound) {
          resultString += valueMap[variableName].toString();
        } else {
          resultString += notFoundFallbackString;
        }
      } else {
        resultString += this[i];
      }
    }
    return resultString;
  }

  String removeAllHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return replaceAll(exp, '');
  }
}

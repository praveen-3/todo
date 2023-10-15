enum RequestMethod { GET, POST, PUT }

extension MethodExtension on RequestMethod {
  String get value => ['GET', 'POST', 'PUT'][index];
}

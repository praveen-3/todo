enum ResponseStatus {
  SUCCESS,
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  SERVICE_UNAVAILABLE,
  INTERNET_ERROR,
  PARSE_ERROR,
  SOCKET_ERROR,
  TIME_ZONE_ERROR,
  CONNECT_TIMEOUT_ERROR,
  SEND_TIMEOUT_ERROR,
  RECEIVE_TIMEOUT_ERROR,
  CANCEL_ERROR,
  UNKNOWN_ERROR
}

extension MethodExtension on ResponseStatus {
  int get value => getValue();

  getValue() {
    return [
      200,
      400,
      401,
      403,
      404,
      500,
      503,
      1000,
      1001,
      1002,
      1003,
      1004,
      1005,
      1006,
      1007,
      9999
    ][index];
  }
}

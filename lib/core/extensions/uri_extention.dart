extension UriHttpMethod on Uri {
  String normalized() {
    return "$scheme://$host$path";
  }
}

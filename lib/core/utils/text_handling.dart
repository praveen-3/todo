class TextHandling {
  static bool verifyIfTextIsEmail(String email, {String? regex}) {
    if (email.isEmpty) {
      return false;
    }

    return RegExp(
            (regex == null) ? r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" : "$regex")
        .hasMatch(email);
  }

  static bool verifyIfTextIsMobile(String phone, {String? regex}) {
    if (phone.isEmpty) {
      return false;
    }
    return RegExp((regex == null) ? r'^[0-9]{10}$' : "$regex\$")
        .hasMatch(phone);
  }

  static bool verifyIfTextIsFullName(String fullName, {String? regex}) {
    if (fullName.isEmpty) {
      return false;
    }
    return RegExp((regex == null) ? r'^[a-zA-Z ]*$' : "$regex\$")
        .hasMatch(fullName);
  }

  static bool verifyIfTextIsUsername(String userName, {String? regex}) {
    if (userName.isEmpty) {
      return false;
    }
    return RegExp((regex == null) ? r'^[A-Za-z][A-Za-z0-9]*$' : "$regex\$")
        .hasMatch(userName);
  }
}

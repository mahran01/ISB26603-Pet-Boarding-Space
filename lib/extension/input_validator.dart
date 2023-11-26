extension InputValidator on String {
  // static bool leadingWhitespace(String s) => RegExp(r"/^[\s]+/g").hasMatch(s);
  // static bool trailingWhitespace(String s) => RegExp(r"/[\s]+$/g").hasMatch(s);

  bool get isValidName {
    return RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| @ | ))*[A-Za-z]+\.?\s*$")
        .hasMatch(this);
  }

  bool get isValidAddress {
    return RegExp(
            r"^\s*([A-Za-z0-9]{1,}([\.,] |[-'_]| (\([\w.]+\))[.,]{0,1} | ))*[A-Za-z0-9]+\.?\s*$")
        .hasMatch(this);
  }

  bool get isValidEmail {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+(\.[a-zA-Z]+)+$").hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r"^[0-9]{4,14}$").hasMatch(this);
  }

  bool get isValidAge {
    return RegExp(r"^[0-9]{1,2}$").hasMatch(this);
  }
}

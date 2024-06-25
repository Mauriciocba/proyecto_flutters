extension StringValidationsExtension on String {
  bool isEmail() {
    return contains(RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-z\-0-9]+\.)+[a-z]{2,}))$'));
  }

  bool isPasswordGreaterThan7digits() {
    return length > 7;
  }
}

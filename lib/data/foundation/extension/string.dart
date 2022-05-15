extension StringExt on String? {
  bool isNullOrEmpty() {
    if (this == "" || this == null) {
      return true;
    }
    return false;
  }

  //Capitalize first character Ex: hello => Hello
  String capitalize() {
    return "${this?[0].toUpperCase()}${this?.substring(1).toLowerCase()}";
  }
}

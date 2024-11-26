class NumUtils {
  static int? getFirstDigit(int? data) {
    if (data == null) {
      return data;
    }
    while (data! >= 10) {
      data = data ~/ 10;
    }
    return data;
  }
}

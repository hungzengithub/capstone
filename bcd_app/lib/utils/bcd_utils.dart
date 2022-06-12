class MyUtil {
  MyUtil();

  static String convertToPercent(double number) {
    // return (((number ?? 0) * 100).toStringAsFixed(1)) + " %";
    return number.toStringAsFixed(1) + " %" ?? '1' + " %";
  }
}

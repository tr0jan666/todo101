import 'package:flutter/foundation.dart';

class CommonUtils {
  CommonUtils._();
  static isWeb() {
    return kIsWeb;
  }

  /// Check 2 strings equals without casesensitive
  static bool equalsTo(String s1, String s2) {
    return s1.toLowerCase() == s2.toLowerCase();
  }
}

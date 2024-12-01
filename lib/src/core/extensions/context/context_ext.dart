import 'dart:io';

import 'package:flutter/widgets.dart';

extension ContextExt on BuildContext {
  bool get isPhone => MediaQuery.of(this).size.shortestSide < 600.0;
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600.0;
  bool get isIpad =>
      Platform.isIOS && MediaQuery.of(this).size.shortestSide >= 600.0;
}

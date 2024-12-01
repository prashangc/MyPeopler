import 'package:flutter/widgets.dart';

class Nav {
  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  static get navKey => _navKey;

  static final BuildContext? _context = _navKey.currentContext;

  static get context => _context;

  static void pushNamed({required String route}) {
    Navigator.of(_context!).pushNamed(route);
  }

  static void pushReplacementNamed({required String route}) {
    Navigator.of(_context!).pushNamed(route);
  }

  static void pop() {
    Navigator.of(_context!).pop();
  }
}

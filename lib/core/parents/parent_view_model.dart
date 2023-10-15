import 'package:flutter/material.dart';

import '../router/route_manager.dart';

class ParentViewModel<T> extends ChangeNotifier {
  bool _disposed = false;
  BuildContext? context;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  navigateFromRouteString(String route) async {
    T? data = await RouteManager.navigateFromRouteString<T>(route);
    await onReload(data);
  }

  Future<void> onReload(T? data) async {}

  Future<T?> getResultData() async {
    return null;
  }
}

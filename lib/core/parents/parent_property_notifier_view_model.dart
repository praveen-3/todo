import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import '../../injection_container.dart';
import '../router/route_manager.dart';

class ParentPropertyNotifierViewModel<T extends ParentPropertiesContainer<U>,
    U extends ParentProperties, V> extends PropertyChangeNotifier<U> {
  bool _disposed = false;
  T? _propertiesConainter;
  BuildContext? context;
  CancelToken? cancelToken;

  T get propertiesConainter {
    if (_propertiesConainter != null) {
      return _propertiesConainter!;
    } else {
      var temp = inject<T>();
      _propertiesConainter = temp;
      return temp;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners([U? property]) {
    if (!_disposed) {
      super.notifyListeners(property);
    }
  }

  navigateFromRouteString(String route) async {
    V? data = await RouteManager.navigateFromRouteString<V>(route);
    await onReload(data);
  }

  Future<void> onReload(V? data) async {}

  Future<V?> getResultData() async {
    return null;
  }
}

// ignore: must_be_immutable
abstract class ParentProperties<T> extends Equatable {
  T propertyValue;
  ParentProperties(this.propertyValue);
}

abstract class ParentPropertiesContainer<T extends ParentProperties>
    extends Equatable {}

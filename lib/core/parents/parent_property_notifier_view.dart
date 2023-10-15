import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import '../logger/enum/logger_value.dart';
import '../logger/logger.dart';
import '../utils/app_utils.dart';
import 'parent_property_notifier_view_model.dart';

class ParentPropertyNotifierView<
    T extends StatefulWidget,
    M extends ParentPropertyNotifierViewModel<U, V, void>,
    U extends ParentPropertiesContainer<V>,
    V extends ParentProperties> extends State<T> with WidgetsBindingObserver {
  late M viewModel;
  M? _viewModelListener;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    try {
      viewModel =
          PropertyChangeProvider.of<M, V>(context, listen: false)!.value;
      viewModel.context = context;
      viewModel.cancelToken = CancelToken();
    } on Exception catch (e, s) {
      Logger.log(
          error: e, stackTrace: s, logValue: LoggerValue.FIREBASE_CRASHLYTICS);
      AppUtils.popScreen(context);
    }
  }

  M getViewModelListener(List<V>? properties) {
    try {
      _viewModelListener = _viewModelListener ??
          PropertyChangeProvider.of<M, V>(
            context,
            listen: true,
            properties: properties,
          )!
              .value;
    } on Exception catch (e, s) {
      Logger.log(
          error: e, stackTrace: s, logValue: LoggerValue.FIREBASE_CRASHLYTICS);
      AppUtils.popScreen(context);
    }
    return _viewModelListener!;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    Logger.log(value: 'LifeCycleState = $state');
    switch (state) {
      case AppLifecycleState.resumed:
        onResume();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPause();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      case AppLifecycleState.hidden:
        onHidden();
        break;
    }
  }

  executeAfterRebuild(RebuildCallback rebuildCallback) {
    AppUtils.executeAfterRebuild(rebuildCallback);
  }

  void onDetached() {}

  void onInactive() {}

  void onPause() {}

  void onHidden() {}

  void onResume() async {}
}

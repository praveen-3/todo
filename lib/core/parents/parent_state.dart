import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logger/logger.dart';
import '../utils/app_utils.dart';
import 'parent_view_model.dart';

class ParentState<T extends StatefulWidget, M extends ParentViewModel>
    extends State<T> with WidgetsBindingObserver {
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
    viewModel = context.read<M>();
    viewModel.context = context;
  }

  M getViewModelListener() {
    _viewModelListener = _viewModelListener ?? context.watch<M>();
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

  void onResume() {}

  void onHidden() {}
}

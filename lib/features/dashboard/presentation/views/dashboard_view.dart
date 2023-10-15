import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:todo_flutter/features/dashboard/presentation/widget/todo_widget.dart';

import '../../../../core/parents/parent_property_notifier_view.dart';
import '../../../../core/res/ac_colors.dart';
import '../../../../core/res/strings.dart';
import '../../../../core/states/view_loading_states.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../../core/widgets/custom_progress_widget.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../../core/widgets/search_input_widget.dart';
import '../change_notifier_properties/dashboard_change_notifier_properties.dart';
import '../view_models/dashboard_viewmodel.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardView();
}

class _DashboardView extends ParentPropertyNotifierView<DashboardView,
    DashboardViewModel, DashboardPropertiesContainer, DashboardProperties> {
  final TextEditingController _searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AcColors.blueBG,
      body: Center(
        child: getDashBoardViewUi(),
      ),
    );
  }

  Widget getDashBoardViewUi() {
    return PropertyChangeConsumer<DashboardViewModel, DashboardProperties>(
        properties: [viewModel.propertiesConainter.view_notifier],
        builder: (context, viewModel, child) {
          var state =
              viewModel!.propertiesConainter.view_notifier.propertyValue;
          if (state is Loading) {
            return CustomProgressWidget.getCustomProgressDialogWithMessage(
              Strings.LOADING,
            );
          } else if (state is Error) {
            showErrorPopUp(state.message);
            return Container();
          } else {
            return getDashBoardView();
          }
        });
  }

  Widget getDashBoardView() {
    return viewModel.todoEntityList.isEmpty
        ? EmptyWidget(Strings.EMPTY_PAGE)
        : Column(
            children: [
              SearchInputWidget(
                _searchTextController,
                () {
                  //implement device search
                },
                hintText: DashBoardStrings.DASHBOARD_SEARCH,
              ),
              Expanded(
                child: Listener(
                  onPointerDown: (_) {
                    AppUtils.unfocusKeyboard(context);
                  },
                  child: ListView.builder(
                    itemCount: viewModel.todoEntityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: TodoWidget(viewModel.todoEntityList[index]),
                        onTap: () {
                          viewModel.selectedTodo =
                              viewModel.todoEntityList[index];
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }

  void showErrorPopUp(String msg) {
    executeAfterRebuild(() => CustomDialog.getSimpleDialogWithSingleButton(
            context, msg, Strings.OK_MESSAGE, () {
          AppUtils.popScreen(context);
        }, () {
          AppUtils.popScreen(context);
        }, false));
  }
}

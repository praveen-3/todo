import 'package:todo_flutter/features/dashboard/data/entities/todo_entity.dart';

import '../../../../core/parents/parent_property_notifier_view_model.dart';
import '../../data/datasources/dashboard_data_source_contract.dart';
import '../change_notifier_properties/dashboard_change_notifier_properties.dart';

class DashboardViewModel extends ParentPropertyNotifierViewModel<
    DashboardPropertiesContainer, DashboardProperties, void> {
  List<TodoEntity> todoEntityList = [];

  TodoEntity? selectedTodo;
  DashboardDataSourceContract dashboardDataSourceContract;

  DashboardViewModel(
    this.dashboardDataSourceContract,
  );

  void updateTodoStatus(String id) {}

  void deleteTodo(String id) {}
}

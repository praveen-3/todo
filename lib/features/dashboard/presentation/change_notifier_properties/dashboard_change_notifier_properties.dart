import '../../../../core/parents/parent_property_notifier_view_model.dart';
import '../../../../core/states/view_loading_states.dart';

// ignore: must_be_immutable
class DashboardProperties<T> extends ParentProperties {
  DashboardProperties(T propertyValue) : super(propertyValue);

  @override
  List<T> get props => [propertyValue];
}

class DashboardPropertiesContainer
    extends ParentPropertiesContainer<DashboardProperties> {
  final DashboardProperties<ViewLoadingState> view_notifier;

  DashboardPropertiesContainer(this.view_notifier);

  @override
  List<Object> get props => [view_notifier];
}

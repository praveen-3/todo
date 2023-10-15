import '../../../../core/parents/parent_property_notifier_view_model.dart';
import '../../../../core/states/view_loading_states.dart';

// ignore: must_be_immutable
class LoginProperties<T> extends ParentProperties {
  LoginProperties(T propertyValue) : super(propertyValue);

  @override
  List<T> get props => [propertyValue];
}

class LoginPropertiesContainer
    extends ParentPropertiesContainer<LoginProperties> {
  final LoginProperties<ViewLoadingState> view_notifier;

  LoginPropertiesContainer(this.view_notifier);

  @override
  List<Object> get props => [view_notifier];
}

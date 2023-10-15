import '../../../../core/parents/parent_property_notifier_view_model.dart';
import '../../../../core/states/view_loading_states.dart';

// ignore: must_be_immutable
class SignUpProperties<T> extends ParentProperties {
  SignUpProperties(T propertyValue) : super(propertyValue);

  @override
  List<T> get props => [propertyValue];
}

class SignUpPropertiesContainer
    extends ParentPropertiesContainer<SignUpProperties> {
  final SignUpProperties<ViewLoadingState> view_notifier;

  SignUpPropertiesContainer(this.view_notifier);

  @override
  List<Object> get props => [view_notifier];
}
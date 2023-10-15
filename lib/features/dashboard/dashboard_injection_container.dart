import '../../core/states/view_loading_states.dart';
import '../../injection_container.dart';
import 'data/datasources/dashboard_data_source_contract.dart';
import 'data/datasources/dashboard_restful_data_source.dart';
import 'presentation/change_notifier_properties/dashboard_change_notifier_properties.dart';
import 'presentation/view_models/dashboard_viewmodel.dart';

class DashBoardInjectionContainer {
  static Future<void> setupInjection() async {
    ///Data
    inject.registerLazySingleton<DashboardDataSourceContract>(
        () => DashboardRestfulDataSource(inject()));

    ///Presentation
    inject.registerFactory(
      () => DashboardPropertiesContainer(
        DashboardProperties(Loading()),
      ),
    );

    inject.registerFactory(
      () => DashboardViewModel(
        inject(),
      ),
    );
  }
}

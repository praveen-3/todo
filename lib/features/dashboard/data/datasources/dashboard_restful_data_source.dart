import '../../../../core/network/contracts/network_manager_contract.dart';
import 'dashboard_data_source_contract.dart';

class DashboardRestfulDataSource extends DashboardDataSourceContract {
  final NetworkManagerContract networkManagerContract;
  DashboardRestfulDataSource(this.networkManagerContract);
}

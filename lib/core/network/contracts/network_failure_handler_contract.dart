import '../../errors/network_failure.dart';

abstract class NetworkFailureHandlerContract {
  /// Return [NetworkFailure] for given [failure]
  ///
  /// Params -
  /// [failure] error of dynamic type
  NetworkFailure handleFailure(dynamic failure);
}

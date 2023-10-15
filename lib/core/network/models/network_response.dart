import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class NetworkResponse extends Equatable {
  final Response<dynamic> response;

  const NetworkResponse({required this.response});

  @override
  List<Object?> get props => [response];
}

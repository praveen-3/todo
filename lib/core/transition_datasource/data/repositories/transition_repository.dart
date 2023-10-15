import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../errors/failure.dart';
import '../../../errors/transition_data_failure.dart';
import '../../domain/repositories/transition_repository_contract.dart';
import '../datasources/view_transition_data_source_contract.dart';

class TransitionRepository<View extends Widget>
    implements TransitionRepositoryContract<View> {
  final ViewTransitionDataSourceContract<View> viewTransitionDataSource;

  TransitionRepository({required this.viewTransitionDataSource});

  @override
  Future<Either<Failure, dynamic>> getData() async {
    return viewTransitionDataSource.getTransitionData();
  }

  @override
  Future<Either<Failure, void>> setData(dynamic data) async {
    try {
      return Right(viewTransitionDataSource.setTransitionData(data));
    } catch (e) {
      return const Left(TransitionDataFailure());
    }
  }
}

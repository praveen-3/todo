import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/parents/usecase.dart';
import '../../../errors/transition_data_failure.dart';
import '../repositories/transition_repository_contract.dart';

class SetTransitionData<Type, View extends Widget>
    implements UseCase<void, Params> {
  TransitionRepositoryContract<View> repository;

  SetTransitionData({required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (params.data is Type) {
      final result = await repository.setData(params.data);

      late Either<Failure, void> finalresult;

      result.fold((l) => {finalresult = const Left(TransitionDataFailure())},
          (r) => {finalresult = const Right(null)});

      return finalresult;
    } else {
      return const Left(TransitionDataFailure());
    }
  }
}

class Params extends Equatable {
  final dynamic data;

  @override
  List<Object?> get props => [data];

  const Params({required this.data});
}

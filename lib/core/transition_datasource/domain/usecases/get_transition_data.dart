import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/parents/usecase.dart';
import '../../../errors/transition_data_failure.dart';
import '../repositories/transition_repository_contract.dart';

class GetTransitionData<Type, View extends Widget>
    implements UseCase<Type, NoParams> {
  TransitionRepositoryContract<View> repository;

  GetTransitionData({required this.repository});

  @override
  Future<Either<Failure, Type>> call(NoParams params) async {
    final result = await repository.getData();

    late Either<Failure, Type> finalresult;

    result.fold(
        (l) => {finalresult = const Left(TransitionDataFailure())},
        (r) => {
              if (r is Type)
                {finalresult = Right(r)}
              else
                {finalresult = const Left(TransitionDataFailure())}
            });

    return finalresult;
  }
}

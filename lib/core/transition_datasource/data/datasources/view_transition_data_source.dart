import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../errors/failure.dart';
import '../../../errors/transition_data_failure.dart';
import 'view_transition_data_source_contract.dart';

class ViewTransitionDataSource<View extends Widget>
    implements ViewTransitionDataSourceContract<View> {
  @override
  dynamic data;

  @override
  Either<Failure, dynamic> getTransitionData() {
    if (data != null) {
      return Right(data!);
    } else {
      return const Left(TransitionDataFailure());
    }
  }

  @override
  setTransitionData(dynamic data) {
    this.data = data;
  }
}

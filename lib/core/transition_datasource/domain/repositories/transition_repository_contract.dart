import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../errors/failure.dart';

abstract class TransitionRepositoryContract<View extends Widget> {
  Future<Either<Failure, dynamic>> getData();
  Future<Either<Failure, void>> setData(dynamic data);
}

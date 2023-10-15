import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../errors/failure.dart';

abstract class ViewTransitionDataSourceContract<View extends Widget> {
  dynamic data;

  Either<Failure, dynamic> getTransitionData();

  setTransitionData(dynamic data);
}

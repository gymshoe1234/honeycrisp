import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:honeycrisp/core/error/failures.dart';

abstract class Service<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

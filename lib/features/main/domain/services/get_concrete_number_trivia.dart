import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:honeycrisp/core/error/failures.dart';
import 'package:honeycrisp/core/services/service.dart';
import 'package:honeycrisp/features/main/domain/entities/number_trivia.dart';
import 'package:honeycrisp/features/main/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements Service<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  @override
  List<Object> get props => [number];

  Params({@required this.number});
}
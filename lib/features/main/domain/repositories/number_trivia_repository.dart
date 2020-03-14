import 'package:dartz/dartz.dart';
import 'package:honeycrisp/core/error/failures.dart';
import 'package:honeycrisp/features/main/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}

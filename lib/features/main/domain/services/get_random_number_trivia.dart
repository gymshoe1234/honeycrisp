import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:honeycrisp/core/error/failures.dart';
import 'package:honeycrisp/core/services/service.dart';
import 'package:honeycrisp/features/main/domain/entities/number_trivia.dart';
import 'package:honeycrisp/features/main/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements Service<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);
  
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
  
}

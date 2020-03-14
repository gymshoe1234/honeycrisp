import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:honeycrisp/core/services/service.dart';
import 'package:honeycrisp/features/main/domain/entities/number_trivia.dart';
import 'package:honeycrisp/features/main/domain/repositories/number_trivia_repository.dart';
import 'package:honeycrisp/features/main/domain/services/get_random_number_trivia.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository 
  extends Mock 
  implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia service;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    service = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final testNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test('should get trivia from the repository', () async {
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
      .thenAnswer((_) async => Right(testNumberTrivia));
    
    final result = await service(NoParams());

    expect(result, Right(testNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });

}

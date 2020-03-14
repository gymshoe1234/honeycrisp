import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:honeycrisp/core/error/exceptions.dart';
import 'package:honeycrisp/core/error/failures.dart';
import 'package:honeycrisp/core/network/network_info.dart';
import 'package:honeycrisp/features/main/data/datasources/number_trivia_local_data_source.dart';
import 'package:honeycrisp/features/main/data/datasources/number_trivia_remote_data_source.dart';
import 'package:honeycrisp/features/main/data/models/number_trivia_model.dart';
import 'package:honeycrisp/features/main/data/repositories/number_trivia_repository_impl.dart';
import 'package:honeycrisp/features/main/domain/entities/number_trivia.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource 
  extends Mock 
  implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource 
  extends Mock 
  implements NumberTriviaLocalDataSource {}

class MockNetworkInfo
  extends Mock 
  implements NetworkInfo {}

  void main() {
    NumberTriviaRepositoryImpl repository;
    MockRemoteDataSource mockRemoteDataSource;
    MockLocalDataSource mockLocalDataSource;
    MockNetworkInfo mockNetworkInfo;

    setUp(() {
      mockRemoteDataSource = MockRemoteDataSource();
      mockLocalDataSource = MockLocalDataSource();
      mockNetworkInfo = MockNetworkInfo();
      repository = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
      );
    });

    void runTestsOnline(Function body) {
      group('device is online', () {
        setUp(() {
          // setup
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        body();
      });
    }

    void runTestsOffline(Function body) {
      group('device is offline', () {
        setUp(() {
          // setup
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });
        body();
      });
    }

    group('getConcreteNumberTrivia', () {

      final testNumber = 1;
      final testNumberTriviaModel = NumberTriviaModel(
        number: testNumber,
        text: 'test trivia',
      );
      final NumberTrivia testNumberTrivia = testNumberTriviaModel;

      test('should check if the device is online', () async {
        // setup
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        
        // test
        repository.getConcreteNumberTrivia(testNumber);

        // check that isConnected has been called
        verify(mockNetworkInfo.isConnected);
      });

      runTestsOnline(() {

        // NOTE: the description pattern is: "should [do something] when [something]"
        test('should return remote data when the call to remote data is successfull', () async {
          
          // setup
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => testNumberTriviaModel);

          // test
          final result = await repository.getConcreteNumberTrivia(testNumber);

          // check that called with the proper parameter
          verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
          expect(result, Right(testNumberTrivia));

        });

        test('should cache the data locally when the call to remote data is successfull', () async {
          
          // setup
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => testNumberTriviaModel);

          // test
          await repository.getConcreteNumberTrivia(testNumber);

          // check that called with the proper parameter
          verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
          verify(mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel));

        });

        test('should return server failure when the call to remote data is unsuccessfull', () async {
          
          // setup
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

          // test
          final result = await repository.getConcreteNumberTrivia(testNumber);

          // check that called with the proper parameter
          verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, Left(ServerFailure()));

        });

        test('should ???', () async {

        });

      });

      runTestsOffline(() {

        test('should return last locally cached data when the cached data is present', () async {
          when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);

          final result = await repository.getConcreteNumberTrivia(testNumber);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, Right(testNumberTrivia));

        });

        test('should return CacheFailure when there is no cached data present', () async {
          when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());

          final result = await repository.getConcreteNumberTrivia(testNumber);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, Left(CacheFailure()));

        });

      });

    });

    group('getRandomNumberTrivia', () {

      final testNumberTriviaModel = NumberTriviaModel(
        number: 123,
        text: 'test trivia',
      );
      final NumberTrivia testNumberTrivia = testNumberTriviaModel;

      test('should check if the device is online', () async {
        // setup
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        
        // test
        repository.getRandomNumberTrivia();

        // check that isConnected has been called
        verify(mockNetworkInfo.isConnected);
      });

      runTestsOnline(() {

        // NOTE: the description pattern is: "should [do something] when [something]"
        test('should return remote data when the call to remote data is successfull', () async {
          
          // setup
          when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);

          // test
          final result = await repository.getRandomNumberTrivia();

          // check that called with the proper parameter
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, Right(testNumberTrivia));

        });

        test('should cache the data locally when the call to remote data is successfull', () async {
          
          // setup
          when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);

          // test
          await repository.getRandomNumberTrivia();

          // check that called with the proper parameter
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          verify(mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel));

        });

        test('should return server failure when the call to remote data is unsuccessfull', () async {
          
          // setup
          when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());

          // test
          final result = await repository.getRandomNumberTrivia();

          // check that called with the proper parameter
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, Left(ServerFailure()));

        });

      });

      runTestsOffline(() {

        test('should return last locally cached data when the cached data is present', () async {
          when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);

          final result = await repository.getRandomNumberTrivia();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, Right(testNumberTrivia));

        });

        test('should return CacheFailure when there is no cached data present', () async {
          when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());

          final result = await repository.getRandomNumberTrivia();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, Left(CacheFailure()));

        });

      });

    });

  }
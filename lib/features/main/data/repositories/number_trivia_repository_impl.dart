import 'package:dartz/dartz.dart';
import 'package:honeycrisp/core/error/exceptions.dart';
import 'package:honeycrisp/core/error/failures.dart';
import 'package:honeycrisp/core/network/network_info.dart';
import 'package:honeycrisp/features/main/data/datasources/number_trivia_local_data_source.dart';
import 'package:honeycrisp/features/main/data/datasources/number_trivia_remote_data_source.dart';
import 'package:honeycrisp/features/main/domain/entities/number_trivia.dart';
import 'package:honeycrisp/features/main/domain/repositories/number_trivia_repository.dart';
import 'package:meta/meta.dart';

// Repository is responsible for deciding when to cache data
// and when to use cached data. For example, when the network
// is down, or if the user is not subscribed to online sync 
// and only uses the app in offline mode.

// Repository is also responsible for catching any exceptions
// from the lower levels, data sources, and converting them
// into Failure.

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource, 
    @required this.localDataSource, 
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom
  ) async {
    if(await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}
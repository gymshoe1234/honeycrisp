import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:honeycrisp/features/main/data/repositories/number_trivia_repository_impl.dart';
import 'package:honeycrisp/features/main/domain/services/get_concrete_number_trivia.dart';
import 'package:honeycrisp/features/main/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/main/data/datasources/number_trivia_local_data_source.dart';
import 'features/main/data/datasources/number_trivia_remote_data_source.dart';
import 'features/main/domain/repositories/number_trivia_repository.dart';
import 'features/main/domain/services/get_random_number_trivia.dart';

final sl = GetIt.instance;

// called in main.dart
Future<void> init() async {
  //* Features - Number Trivia

  // Blocs
  // NOTE: never register blocs as singleton
  sl.registerFactory(() => NumberTriviaBloc(
        concrete: sl(),
        inputConverter: sl(),
        random: sl(),
      ));

  // use cases (services)
  // these can be singletons (we don't need to clean up and class has no state)
  // NOTE: we're registering the Abstract use-cases (GetConcreteNumberTrivia, etc.)
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository (helps resolve the )
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            localDataSource: sl(),
            remoteDataSource: sl(),
            networkInfo: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

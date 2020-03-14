part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  @override
  List<Object> get props => [];
  const NumberTriviaState();
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  @override
  List<Object> get props => [trivia];

  Loaded({@required this.trivia});
}

class Error extends NumberTriviaState {
  final String message;

  @override
  List<Object> get props => [message];

  Error({@required this.message});
}


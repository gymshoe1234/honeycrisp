part of 'number_trivia_bloc.dart';

// Events should not be converting data
// They should only be passing data to the bloc
// Properties are Strings because that is what comes from UI
// before conversion.

// UI widgets should also not convert any data.
// They should only display data and dispatch events.
// They should NOT have any presentation logic inside of them.

// DO NOT put any logic in events

// ALSO note how events are named
//      not describing what UI element triggered it (ie not OnSomeButtonPressed)
//      but describing the action that is being triggered
//      ??? is that a good practice ???

abstract class NumberTriviaEvent extends Equatable {
  @override
  List<Object> get props => [];
  const NumberTriviaEvent();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  @override
  List<Object> get props => [numberString];

  GetTriviaForConcreteNumber(this.numberString);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}

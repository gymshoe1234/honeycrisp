import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  @override
  List<Object> get props => [text, number];

  // TIP: hit Ctrl+. to create this constructor after specifying the fields
  NumberTrivia({
    @required this.text, 
    @required this.number
  });


}
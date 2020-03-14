// NOTE: even though it is not an abstract interfce,
//       we can still mock InputConverter easily in Dart.

// purpose is similar to the Model
//

import 'package:dartz/dartz.dart';
import 'package:honeycrisp/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final val = int.parse(str);
      if (val < 0) throw FormatException();
      return Right(val);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}

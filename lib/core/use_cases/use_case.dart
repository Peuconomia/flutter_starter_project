import 'package:dartz/dartz.dart';

abstract class UseCaseStream<FailureType, Type, Params> {
  Stream<Either<FailureType, Type>> call(Params params);
}

abstract class UseCase<FailureType, Type, Params> {
  Future<Either<FailureType, Type>> call(Params params);
}

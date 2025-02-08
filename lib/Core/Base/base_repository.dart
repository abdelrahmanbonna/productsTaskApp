import 'package:dartz/dartz.dart';
import 'package:task_app/Core/Error/failures.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> handleEither<T>({
    required Future<T> Function() task,
    String? errorMessage,
  }) async {
    try {
      final result = await task();
      return Right(result);
    } catch (e) {
      return Left(
        ServerFailure(
          message: errorMessage ?? e.toString(),
        ),
      );
    }
  }
}

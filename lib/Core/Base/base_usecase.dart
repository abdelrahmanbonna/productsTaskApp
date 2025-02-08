import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/Core/Error/failures.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

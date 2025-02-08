import 'package:equatable/equatable.dart';
import 'package:task_app/Core/Error/failures.dart';

abstract class BaseState extends Equatable {
  final bool isLoading;
  final Failure? failure;

  const BaseState({
    this.isLoading = false,
    this.failure,
  });

  @override
  List<Object?> get props => [isLoading, failure];
}

class InitialState extends BaseState {
  const InitialState() : super();
}

class LoadingState extends BaseState {
  const LoadingState() : super(isLoading: true);
}

class ErrorState extends BaseState {
  const ErrorState({required Failure failure}) : super(failure: failure);
}

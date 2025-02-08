import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

// Server Failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
  });
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
  });
}

// Validation Failures
class ValidationFailure extends Failure {
  final Map<String, String>? errors;

  const ValidationFailure({
    required super.message,
    this.errors,
  });

  @override
  List<Object?> get props => [message, statusCode, errors];
}

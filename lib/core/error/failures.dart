import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}

// Authentication Failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// Validation Failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

// Permission Failures
class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

// Camera/File Failures
class CameraFailure extends Failure {
  const CameraFailure(super.message);
}

class FileFailure extends Failure {
  const FileFailure(super.message);
}

// Generic Failures
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

// Failure Messages
class FailureMessages {
  static const String networkError = 'Unable to connect to the internet';
  static const String serverError = 'Server error occurred';
  static const String timeoutError = 'Connection timeout';
  static const String authenticationError = 'Authentication failed';
  static const String unauthorizedError = 'You do not have access';
  static const String cacheError = 'Failed to access local data';
  static const String validationError = 'Invalid data';
  static const String permissionError = 'Access permission denied';
  static const String cameraError = 'Failed to access camera';
  static const String fileError = 'Failed to process file';
  static const String unknownError = 'An unknown error occurred';
}

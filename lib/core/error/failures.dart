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
  static const String networkError = 'Tidak dapat terhubung ke internet';
  static const String serverError = 'Terjadi kesalahan pada server';
  static const String timeoutError = 'Koneksi timeout';
  static const String authenticationError = 'Gagal melakukan autentikasi';
  static const String unauthorizedError = 'Anda tidak memiliki akses';
  static const String cacheError = 'Gagal mengakses data lokal';
  static const String validationError = 'Data tidak valid';
  static const String permissionError = 'Izin akses ditolak';
  static const String cameraError = 'Gagal mengakses kamera';
  static const String fileError = 'Gagal memproses file';
  static const String unknownError = 'Terjadi kesalahan yang tidak diketahui';
}

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  // Generic GET request
  Future<Either<Failure, T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.statusCode == 200) {
        if (fromJson != null && response.data != null) {
          return Right(fromJson(response.data));
        }
        return Right(response.data as T);
      } else {
        return Left(
          ServerFailure('Request failed with status: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Generic POST request
  Future<Either<Failure, T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (fromJson != null && response.data != null) {
          return Right(fromJson(response.data));
        }
        return Right(response.data as T);
      } else {
        return Left(
          ServerFailure('Request failed with status: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Generic PUT request
  Future<Either<Failure, T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.statusCode == 200) {
        if (fromJson != null && response.data != null) {
          return Right(fromJson(response.data));
        }
        return Right(response.data as T);
      } else {
        return Left(
          ServerFailure('Request failed with status: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Generic DELETE request
  Future<Either<Failure, bool>> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return Right(response.statusCode == 200 || response.statusCode == 204);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Upload file
  Future<Either<Failure, T>> uploadFile<T>(
    String endpoint,
    String filePath, {
    String fieldName = 'file',
    Map<String, dynamic>? data,
    T Function(Map<String, dynamic>)? fromJson,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
        if (data != null) ...data,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (fromJson != null && response.data != null) {
          return Right(fromJson(response.data));
        }
        return Right(response.data as T);
      } else {
        return Left(
          ServerFailure('Upload failed with status: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Add authorization header
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Remove authorization header
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // Handle Dio errors
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure(FailureMessages.timeoutError);

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const UnauthorizedFailure(FailureMessages.unauthorizedError);
        } else if (statusCode == 404) {
          return const ServerFailure('Resource not found');
        } else if (statusCode != null && statusCode >= 500) {
          return const ServerFailure(FailureMessages.serverError);
        }
        return ServerFailure(error.message ?? FailureMessages.serverError);

      case DioExceptionType.cancel:
        return const NetworkFailure('Request was cancelled');

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
      default:
        return const NetworkFailure(FailureMessages.networkError);
    }
  }
}

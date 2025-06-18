import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'api_service.dart';
import 'storage_service.dart';
import 'auth_service.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  // Network client
  serviceLocator.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging and error handling
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

    return dio;
  });

  // Core Services
  serviceLocator.registerLazySingleton<StorageService>(
    () => StorageService(serviceLocator<SharedPreferences>()),
  );

  serviceLocator.registerLazySingleton<ApiService>(
    () => ApiService(serviceLocator<Dio>()),
  );

  serviceLocator.registerLazySingleton<AuthService>(
    () => AuthService(
      apiService: serviceLocator<ApiService>(),
      storageService: serviceLocator<StorageService>(),
    ),
  );
}

Future<void> resetServiceLocator() async {
  await serviceLocator.reset();
  await setupServiceLocator();
}

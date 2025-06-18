import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../error/failures.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService({
    required ApiService apiService,
    required StorageService storageService,
  }) : _apiService = apiService,
       _storageService = storageService;

  // Current user stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  // Sign in with email and password
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Get ID token and save it
        final idToken = await userCredential.user!.getIdToken();
        if (idToken != null) {
          await _storageService.saveUserToken(idToken);
          // Set auth token for API calls
          _apiService.setAuthToken(idToken);
        }

        return Right(userCredential.user!);
      } else {
        return const Left(AuthenticationFailure('Login failed'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure(_getFirebaseErrorMessage(e.code)));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Sign up with email and password
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Update display name
        await userCredential.user!.updateDisplayName(displayName);

        // Get ID token and save it
        final idToken = await userCredential.user!.getIdToken();
        if (idToken != null) {
          await _storageService.saveUserToken(idToken);
          // Set auth token for API calls
          _apiService.setAuthToken(idToken);
        }

        return Right(userCredential.user!);
      } else {
        return const Left(AuthenticationFailure('Registration failed'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure(_getFirebaseErrorMessage(e.code)));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Sign out
  Future<Either<Failure, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _storageService.clearUserData();
      _apiService.clearAuthToken();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Send password reset email
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure(_getFirebaseErrorMessage(e.code)));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Delete user account
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await currentUser?.delete();
      await _storageService.clearUserData();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure(_getFirebaseErrorMessage(e.code)));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Refresh ID token
  Future<Either<Failure, String>> refreshToken() async {
    try {
      if (currentUser != null) {
        final idToken = await currentUser!.getIdToken(true);
        if (idToken != null) {
          await _storageService.saveUserToken(idToken);
          _apiService.setAuthToken(idToken);
          return Right(idToken);
        } else {
          return const Left(AuthenticationFailure('Failed to get token'));
        }
      } else {
        return const Left(UnauthorizedFailure('User not authenticated'));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Initialize auth on app start
  Future<void> initializeAuth() async {
    final token = _storageService.getUserToken();
    if (token != null && isAuthenticated) {
      _apiService.setAuthToken(token);
    }
  }

  // Get Firebase error message
  String _getFirebaseErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'User tidak ditemukan';
      case 'wrong-password':
        return 'Password salah';
      case 'email-already-in-use':
        return 'Email sudah digunakan';
      case 'weak-password':
        return 'Password terlalu lemah';
      case 'invalid-email':
        return 'Format email tidak valid';
      case 'user-disabled':
        return 'Akun pengguna dinonaktifkan';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan login. Coba lagi nanti.';
      case 'operation-not-allowed':
        return 'Operasi tidak diizinkan';
      case 'requires-recent-login':
        return 'Silakan login ulang untuk melanjutkan';
      default:
        return 'Terjadi kesalahan autentikasi';
    }
  }
}

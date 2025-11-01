import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth.dart';
import 'api_service.dart';

const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Secure Storage Provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Auth State Notifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;
  final FlutterSecureStorage _storage;

  AuthStateNotifier(this._apiService, this._storage)
      : super(const AuthState());

  Future<void> initialize() async {
    try {
      state = state.copyWith(isLoading: true);

      final accessToken = await _storage.read(key: _accessTokenKey);
      final refreshToken = await _storage.read(key: _refreshTokenKey);

      if (accessToken != null) {
        _apiService.setAccessToken(accessToken);

        try {
          final user = await _apiService.getCurrentUser();
          state = AuthState(
            isAuthenticated: true,
            isLoading: false,
            user: user,
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
        } catch (e) {
          // Token might be expired, try refresh
          if (refreshToken != null) {
            await _refreshAccessToken(refreshToken);
          } else {
            await logout();
          }
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> login(LoginRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final tokenResponse = await _apiService.login(request);

      // Save tokens
      await _storage.write(
        key: _accessTokenKey,
        value: tokenResponse.accessToken,
      );
      await _storage.write(
        key: _refreshTokenKey,
        value: tokenResponse.refreshToken,
      );

      state = AuthState(
        isAuthenticated: true,
        isLoading: false,
        user: tokenResponse.user,
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signUp(SignUpRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final tokenResponse = await _apiService.signUp(request);

      // Save tokens
      await _storage.write(
        key: _accessTokenKey,
        value: tokenResponse.accessToken,
      );
      await _storage.write(
        key: _refreshTokenKey,
        value: tokenResponse.refreshToken,
      );

      state = AuthState(
        isAuthenticated: true,
        isLoading: false,
        user: tokenResponse.user,
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> _refreshAccessToken(String refreshToken) async {
    try {
      final tokenResponse = await _apiService.refreshToken(refreshToken);

      await _storage.write(
        key: _accessTokenKey,
        value: tokenResponse.accessToken,
      );
      await _storage.write(
        key: _refreshTokenKey,
        value: tokenResponse.refreshToken,
      );

      state = AuthState(
        isAuthenticated: true,
        isLoading: false,
        user: tokenResponse.user,
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken,
      );
    } catch (e) {
      await logout();
    }
  }

  Future<void> logout() async {
    try {
      _apiService.clearAccessToken();

      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);

      state = const AuthState();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final updatedUser = await _apiService.updateProfile(data);

      state = state.copyWith(
        isLoading: false,
        user: updatedUser,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _apiService.changePassword(currentPassword, newPassword);

      state = state.copyWith(
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> deleteAccount() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _apiService.deleteAccount();
      await logout();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void resetPassword(String email) async {
    // TODO: Implement reset password endpoint
    state = state.copyWith(
      error: 'Password reset not yet implemented',
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Auth State Provider
final authStateProvider =
StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthStateNotifier(apiService, storage);
});
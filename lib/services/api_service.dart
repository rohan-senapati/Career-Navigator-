import 'package:dio/dio.dart';
import '../core/constants.dart';
import '../models/auth.dart';

class ApiService {
  late Dio _dio;
  String? _accessToken;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: Duration(milliseconds: AppConstants.apiTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.apiTimeout),
        contentType: 'application/json',
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  void setAccessToken(String token) {
    _accessToken = token;
  }

  void clearAccessToken() {
    _accessToken = null;
  }

  Future<TokenResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      final tokenResponse = TokenResponse.fromJson(response.data);
      _accessToken = tokenResponse.accessToken;
      return tokenResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<TokenResponse> signUp(SignUpRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/signup',
        data: request.toJson(),
      );

      final tokenResponse = TokenResponse.fromJson(response.data);
      _accessToken = tokenResponse.accessToken;
      return tokenResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<TokenResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      final tokenResponse = TokenResponse.fromJson(response.data);
      _accessToken = tokenResponse.accessToken;
      return tokenResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserResponse> getCurrentUser() async {
    try {
      final response = await _dio.get('/users/me');
      return UserResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserResponse> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '/users/me',
        data: data,
      );
      return UserResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _dio.post(
        '/auth/change-password',
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _dio.delete('/users/me');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      if (data is Map && data.containsKey('detail')) {
        return data['detail'].toString();
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.badResponse:
        return 'Server error: ${error.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return AppConstants.networkErrorMessage;
      default:
        return error.message ?? AppConstants.serverErrorMessage;
    }
  }
}
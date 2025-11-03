import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../models/recommendation.dart';

class RecommendationService {
  final Dio _dio;

  RecommendationService(this._dio);

  // Fetch course recommendations from backend
  Future<List<CourseRecommendation>> getCourseRecommendations() async {
    try {
      final response = await _dio.get('/recommend/courses');
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => CourseRecommendation.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch course recommendations');
      }
    } catch (e) {
      // Log or handle error if needed
      rethrow;
    }
  }
}

// Provider for RecommendationService
final recommendationServiceProvider =
Provider<RecommendationService>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      receiveTimeout: Duration(milliseconds: AppConstants.apiTimeout),
    ),
  );
  // Optionally add interceptors for auth tokens here
  return RecommendationService(dio);
});

final courseRecommendationsProvider =
FutureProvider<List<CourseRecommendation>>((ref) async {
  final service = ref.watch(recommendationServiceProvider);
  return service.getCourseRecommendations();
});

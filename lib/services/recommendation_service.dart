import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recommendation.dart';

// Setup Dio with baseUrl pointing to your backend URL
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: "http://10.0.2.2:8000",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      "Content-Type": "application/json",
    },
  ));
});

class RecommendationService {
  final Dio dio;
  RecommendationService(this.dio);

  Future<List<CareerRecommendation>> getCareerRecommendations() async {
    try {
      final response = await dio.post('/search/jobs');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => CareerRecommendation.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch career recommendations');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CourseRecommendation>> getCourseRecommendations(String coursename) async {
    try {
      final response = await dio.post(
        '/recommend/courses',
        data: {"course_name": coursename}, // The key must match FastAPI's expected field
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => CourseRecommendation.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch course recommendations');
      }
    } catch (e) {
      rethrow;
    }
  }
}

final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService(ref.watch(dioProvider));
});

final careerRecommendationsProvider = FutureProvider.autoDispose<List<CareerRecommendation>>((ref) async {
  final service = ref.read(recommendationServiceProvider);
  return service.getCareerRecommendations();
});

final courseRecommendationsProvider = FutureProvider.autoDispose.family<List<CourseRecommendation>, String>((ref, coursename) async {
  final service = ref.read(recommendationServiceProvider);
  return service.getCourseRecommendations(coursename);
});

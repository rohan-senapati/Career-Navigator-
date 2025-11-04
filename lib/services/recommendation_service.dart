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

  // Job search - matches backend /search/jobs endpoint
  Future<List<JobRecommendation>> getJobRecommendations({
    required String term,
    required String location,
  }) async {
    try {
      final response = await dio.post(
        '/search/jobs',
        data: {
          "term": term,
          "location": location,
        },
      );

      if (response.statusCode == 200) {
        final jobs = response.data['jobs'] as List;
        return jobs
            .map((json) => JobRecommendation.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch job recommendations');
      }
    } catch (e) {
      print('Job search error: $e');
      rethrow;
    }
  }

  // Course recommendations - matches backend /recommend/courses endpoint
  Future<List<CourseRecommendation>> getCourseRecommendations(String courseName) async {
    try {
      // Backend expects "course_name" field
      final response = await dio.post(
        '/recommend/courses',
        data: {"course_name": courseName},
      );

      if (response.statusCode == 200) {
        // Backend returns a list directly
        final courses = response.data as List;
        return courses
            .map((json) => CourseRecommendation.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch course recommendations');
      }
    } catch (e) {
      print('Course recommendation error: $e');
      rethrow;
    }
  }

  // Get all available course names from CSV (for autocomplete/suggestions)
  Future<List<String>> getAvailableCourseNames() async {
    // This endpoint doesn't exist in backend yet, but could be added
    // For now, return empty list or hardcoded popular courses
    return [
      'Python Programming Essentials',
      'Business Strategy: Business Model Canvas Analysis',
      'Finance for Managers',
      'Programming Languages, Part A',
      'Creating Dashboards and Storytelling with Tableau',
    ];
  }
}

final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService(ref.watch(dioProvider));
});

// Job recommendations provider with search parameters
final jobRecommendationsProvider = FutureProvider.autoDispose
    .family<List<JobRecommendation>, Map<String, String>>((ref, params) async {
  final service = ref.read(recommendationServiceProvider);
  return service.getJobRecommendations(
    term: params['term'] ?? '',
    location: params['location'] ?? '',
  );
});

// Course recommendations provider with course name
final courseRecommendationsProvider = FutureProvider.autoDispose
    .family<List<CourseRecommendation>, String>((ref, courseName) async {
  if (courseName.isEmpty) {
    return [];
  }
  final service = ref.read(recommendationServiceProvider);
  return service.getCourseRecommendations(courseName);
});

// Available course names provider
final availableCourseNamesProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final service = ref.read(recommendationServiceProvider);
  return service.getAvailableCourseNames();
});
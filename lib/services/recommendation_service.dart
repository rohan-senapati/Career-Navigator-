
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recommendation.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
      BaseOptions(
        baseUrl: "http://10.0.2.2:8000",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {"Content-Type": "application/json"},
      ),
    )
    ..interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
});

class RecommendationService {
  final Dio dio;
  RecommendationService(this.dio);

  Future<List<JobRecommendation>> getJobRecommendations({
    required String term,
    required String location,
  }) async {
    try {
      print('🔍 Searching jobs: term="$term", location="$location"');

      final response = await dio.post(
        '/search/jobs',
        data: {"term": term, "location": location},
      );

      print('✅ Job search response status: ${response.statusCode}');
      print('📦 Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        // Handle the response structure
        if (response.data is Map<String, dynamic>) {
          final jobsData = response.data['jobs'];

          if (jobsData == null) {
            print('⚠️ No jobs key in response');
            return [];
          }

          if (jobsData is List) {
            print('✅ Found ${jobsData.length} jobs');
            return jobsData
                .map((json) {
                  try {
                    return JobRecommendation.fromJson(
                      json as Map<String, dynamic>,
                    );
                  } catch (e) {
                    print('⚠️ Error parsing job: $e');
                    print('Job data: $json');
                    return null;
                  }
                })
                .where((job) => job != null)
                .cast<JobRecommendation>()
                .toList();
          } else if (jobsData is String) {
            // If jobs is returned as error string
            print('⚠️ Jobs data is string (likely error): $jobsData');
            throw Exception(jobsData);
          } else {
            print('⚠️ Unexpected jobs data type: ${jobsData.runtimeType}');
            return [];
          }
        } else {
          print('⚠️ Response is not a Map: ${response.data.runtimeType}');
          return [];
        }
      } else {
        throw Exception(
          'Failed to fetch job recommendations: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');
      print('❌ Error message: ${e.message}');
      print('❌ Response: ${e.response?.data}');

      if (e.response?.data is Map && e.response?.data['error'] != null) {
        throw Exception(e.response?.data['error']);
      }

      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('❌ Unexpected error: $e');
      rethrow;
    }
  }

  Future<List<CourseRecommendation>> getCourseRecommendations(
    String courseName,
  ) async {
    try {
      print('🔍 Searching courses for: "$courseName"');

      final response = await dio.post(
        '/recommend/courses',
        data: {"course_name": courseName},
      );

      print('✅ Course search response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          final courses = response.data as List;

          if (courses.isEmpty) {
            print('⚠️ No courses found for: "$courseName"');
            return [];
          }

          print('✅ Found ${courses.length} courses');
          return courses
              .map((json) {
                try {
                  return CourseRecommendation.fromJson(
                    json as Map<String, dynamic>,
                  );
                } catch (e) {
                  print('⚠️ Error parsing course: $e');
                  print('Course data: $json');
                  return null;
                }
              })
              .where((course) => course != null)
              .cast<CourseRecommendation>()
              .toList();
        } else {
          print('⚠️ Response is not a List: ${response.data.runtimeType}');
          return [];
        }
      } else {
        throw Exception(
          'Failed to fetch course recommendations: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');
      print('❌ Error message: ${e.message}');
      print('❌ Response: ${e.response?.data}');

      if (e.response?.statusCode == 500) {
        // Course not found in dataset
        throw Exception(
          'Course not found. Please try:\n'
          '• Check the spelling\n'
          '• Use a different course name\n'
          '• Try popular courses like "Python Programming" or "Machine Learning"',
        );
      }

      if (e.response?.data is Map && e.response?.data['detail'] != null) {
        throw Exception(e.response?.data['detail']);
      }

      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('❌ Unexpected error: $e');
      rethrow;
    }
  }

  Future<List<String>> getAvailableCourseNames() async {
    // Return some popular course suggestions
    return [
      'Python Programming Essentials',
      'Machine Learning',
      'Data Science',
      'Web Development',
      'Business Strategy',
      'Finance for Managers',
      'Digital Marketing',
      'Cloud Computing',
      'Artificial Intelligence',
      'Project Management',
    ];
  }
}

final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService(ref.watch(dioProvider));
});

final jobRecommendationsProvider = FutureProvider.autoDispose
    .family<List<JobRecommendation>, Map<String, String>>((ref, params) async {
      final service = ref.read(recommendationServiceProvider);
      return service.getJobRecommendations(
        term: params['term'] ?? '',
        location: params['location'] ?? '',
      );
    });

final courseRecommendationsProvider = FutureProvider.autoDispose
    .family<List<CourseRecommendation>, String>((ref, courseName) async {
      if (courseName.isEmpty) {
        return [];
      }
      final service = ref.read(recommendationServiceProvider);
      return service.getCourseRecommendations(courseName);
    });
final availableCourseNamesProvider = FutureProvider.autoDispose<List<String>>((
  ref,
) async {
  final service = ref.read(recommendationServiceProvider);
  return service.getAvailableCourseNames();
});

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

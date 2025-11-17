import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recommendation.dart';

// Single Dio provider - used by both job and course services
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {"Content-Type": "application/json"},
    ),
  )..interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true, error: true),
  );
});

// ============================================================================
// JOB RECOMMENDATION SERVICE
// ============================================================================
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

      if (response.statusCode == 200) {
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
                return null;
              }
            })
                .where((job) => job != null)
                .cast<JobRecommendation>()
                .toList();
          } else if (jobsData is String) {
            print('⚠️ Jobs data is string (likely error): $jobsData');
            throw Exception(jobsData);
          }
        }
        return [];
      } else {
        throw Exception('Failed to fetch job recommendations: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');
      print('❌ Error message: ${e.message}');
      if (e.response?.data is Map && e.response?.data['error'] != null) {
        throw Exception(e.response?.data['error']);
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('❌ Unexpected error: $e');
      rethrow;
    }
  }
}

// ============================================================================
// COURSE RECOMMENDATION SERVICE
// ============================================================================
class CourseService {
  final Dio dio;

  CourseService(this.dio);

  /// Get all available course names from the backend
  Future<List<String>> getAvailableCourses({
    int limit = 1000,
    String? difficulty,
    String? university,
    double? minRating,
  }) async {
    try {
      print('🔍 Fetching available courses from backend...');

      final queryParams = <String, dynamic>{'limit': limit};

      if (difficulty != null) queryParams['difficulty'] = difficulty;
      if (university != null) queryParams['university'] = university;
      if (minRating != null) queryParams['min_rating'] = minRating;

      final response = await dio.get(
        '/courses/available',
        queryParameters: queryParams,
      );

      print('✅ Courses response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final courses = List<String>.from(data['courses'] ?? []);
        final totalCount = data['total_count'] ?? 0;

        print('✅ Found $totalCount courses, returning ${courses.length}');
        return courses;
      } else {
        throw Exception('Failed to fetch courses: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Search courses by query
  Future<List<String>> searchCourses(String query, {int limit = 20}) async {
    try {
      print('🔍 Searching courses with query: "$query"');

      final response = await dio.get(
        '/courses/search',
        queryParameters: {
          'query': query,
          'limit': limit,
        },
      );

      print('✅ Search response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final courses = List<String>.from(response.data ?? []);
        print('✅ Found ${courses.length} matching courses');
        return courses;
      } else {
        throw Exception('Failed to search courses: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get course details
  Future<CourseDetails> getCourseDetails(String courseName) async {
    try {
      print('🔍 Fetching details for course: "$courseName"');

      final response = await dio.get(
        '/courses/details/${Uri.encodeComponent(courseName)}',
      );

      print('✅ Course details response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return CourseDetails.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch course details: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get course statistics
  Future<CourseStatistics> getCourseStatistics() async {
    try {
      print('🔍 Fetching course statistics...');

      final response = await dio.get('/courses/statistics');

      print('✅ Statistics response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return CourseStatistics.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch statistics: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get course recommendations based on a course name
  Future<List<CourseRecommendation>> getCourseRecommendations(
      String courseName,
      ) async {
    try {
      print('🔍 Getting recommendations for: "$courseName"');

      final response = await dio.post(
        '/recommend/courses',
        data: {"course_name": courseName},
      );

      print('✅ Recommendations response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          final courses = response.data as List;

          if (courses.isEmpty) {
            print('⚠️ No recommendations found for: "$courseName"');
            return [];
          }

          print('✅ Found ${courses.length} recommendations');
          return courses
              .map((json) {
            try {
              return CourseRecommendation.fromJson(
                json as Map<String, dynamic>,
              );
            } catch (e) {
              print('⚠️ Error parsing course: $e');
              return null;
            }
          })
              .where((course) => course != null)
              .cast<CourseRecommendation>()
              .toList();
        }
        return [];
      } else {
        throw Exception('Failed to fetch recommendations: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');

      if (e.response?.statusCode == 404) {
        throw Exception('Course not found. Please check the course name.');
      }

      if (e.response?.data is Map && e.response?.data['detail'] != null) {
        throw Exception(e.response?.data['detail']);
      }

      throw Exception('Network error: ${e.message}');
    }
  }
}

// ============================================================================
// MODELS
// ============================================================================

/// Course Details Model
class CourseDetails {
  final String name;
  final String url;
  final double rating;
  final String difficulty;
  final String university;

  CourseDetails({
    required this.name,
    required this.url,
    required this.rating,
    required this.difficulty,
    required this.university,
  });

  factory CourseDetails.fromJson(Map<String, dynamic> json) {
    return CourseDetails(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      difficulty: json['difficulty'] ?? 'Not Specified',
      university: json['university'] ?? 'Unknown',
    );
  }
}

/// Course Statistics Model
class CourseStatistics {
  final int totalCourses;
  final int universities;
  final Map<String, int> difficultyDistribution;
  final double averageRating;
  final Map<String, int> topUniversities;

  CourseStatistics({
    required this.totalCourses,
    required this.universities,
    required this.difficultyDistribution,
    required this.averageRating,
    required this.topUniversities,
  });

  factory CourseStatistics.fromJson(Map<String, dynamic> json) {
    return CourseStatistics(
      totalCourses: json['total_courses'] ?? 0,
      universities: json['universities'] ?? 0,
      difficultyDistribution: Map<String, int>.from(
        json['difficulty_distribution'] ?? {},
      ),
      averageRating: (json['average_rating'] ?? 0.0).toDouble(),
      topUniversities: Map<String, int>.from(
        json['top_universities'] ?? {},
      ),
    );
  }
}

// ============================================================================
// PROVIDERS
// ============================================================================

// Service Providers
final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService(ref.watch(dioProvider));
});

final courseServiceProvider = Provider<CourseService>((ref) {
  return CourseService(ref.watch(dioProvider));
});

// Job Recommendations Provider
final jobRecommendationsProvider = FutureProvider.autoDispose
    .family<List<JobRecommendation>, Map<String, String>>((ref, params) async {
  final service = ref.read(recommendationServiceProvider);
  return service.getJobRecommendations(
    term: params['term'] ?? '',
    location: params['location'] ?? '',
  );
});

// Course Recommendations Provider
final courseRecommendationsProvider = FutureProvider.autoDispose
    .family<List<CourseRecommendation>, String>((ref, courseName) async {
  if (courseName.isEmpty) return [];
  final service = ref.read(courseServiceProvider);
  return service.getCourseRecommendations(courseName);
});

// Available Courses Provider
final availableCoursesProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final service = ref.read(courseServiceProvider);
  return service.getAvailableCourses(limit: 1000);
});

// Search Courses Provider
final searchCoursesProvider = FutureProvider.autoDispose
    .family<List<String>, String>((ref, query) async {
  if (query.isEmpty || query.length < 2) return [];
  final service = ref.read(courseServiceProvider);
  return service.searchCourses(query, limit: 20);
});

// Course Details Provider
final courseDetailsProvider = FutureProvider.autoDispose
    .family<CourseDetails, String>((ref, courseName) async {
  final service = ref.read(courseServiceProvider);
  return service.getCourseDetails(courseName);
});

// Course Statistics Provider
final courseStatisticsProvider = FutureProvider.autoDispose<CourseStatistics>((ref) async {
  final service = ref.read(courseServiceProvider);
  return service.getCourseStatistics();
});
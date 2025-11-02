import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../models/recommendation.dart';

class RecommendationService {
  final Dio _dio;

  RecommendationService(this._dio);

  Future<List<CareerRecommendation>> getCareerRecommendations() async {
    try {
      final response = await _dio.get('/recommendations/careers');

      if (response.data is List) {
        return (response.data as List)
            .map((json) => CareerRecommendation.fromJson(json))
            .toList();
      }

      return _getMockCareerRecommendations();
    } catch (e) {
      // Return mock data if API fails
      return _getMockCareerRecommendations();
    }
  }

  Future<List<SkillRecommendation>> getSkillRecommendations() async {
    try {
      final response = await _dio.get('/recommendations/skills');

      if (response.data is List) {
        return (response.data as List)
            .map((json) => SkillRecommendation.fromJson(json))
            .toList();
      }

      return _getMockSkillRecommendations();
    } catch (e) {
      return _getMockSkillRecommendations();
    }
  }

  Future<List<CourseRecommendation>> getCourseRecommendations() async {
    try {
      final response = await _dio.get('/recommendations/courses');

      if (response.data is List) {
        return (response.data as List)
            .map((json) => CourseRecommendation.fromJson(json))
            .toList();
      }

      return _getMockCourseRecommendations();
    } catch (e) {
      return _getMockCourseRecommendations();
    }
  }

  // Mock data for demonstration
  List<CareerRecommendation> _getMockCareerRecommendations() {
    return [
      CareerRecommendation(
        id: '1',
        title: 'Software Engineer',
        description: 'Design, develop, and maintain software applications using various programming languages and frameworks.',
        type: 'career',
        category: 'Technology',
        confidence: 0.92,
        tags: ['Technology', 'Programming', 'Problem Solving'],
        imageUrl: null,
        url: 'https://www.example.com/careers/software-engineer',
        metadata: {'demand': 'High', 'growth': 'Excellent'},
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        careerPath: 'Software Engineering',
        salaryRange: 95000,
        growthRate: 22,
        requiredSkills: ['Programming', 'Problem Solving', 'Algorithms'],
        recommendedSkills: ['Cloud Computing', 'DevOps', 'Machine Learning'],
        difficulty: 'Medium',
        estimatedTimeToTransition: 6,
      ),
      CareerRecommendation(
        id: '2',
        title: 'Data Scientist',
        description: 'Analyze complex data sets to help organizations make better business decisions using statistical and machine learning techniques.',
        type: 'career',
        category: 'Data Science',
        confidence: 0.88,
        tags: ['Data', 'Analytics', 'Machine Learning'],
        imageUrl: null,
        url: 'https://www.example.com/careers/data-scientist',
        metadata: {'demand': 'Very High', 'growth': 'Excellent'},
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        careerPath: 'Data Science',
        salaryRange: 115000,
        growthRate: 36,
        requiredSkills: ['Statistics', 'Python', 'SQL', 'Machine Learning'],
        recommendedSkills: ['Deep Learning', 'Big Data', 'Data Visualization'],
        difficulty: 'Hard',
        estimatedTimeToTransition: 12,
      ),
      CareerRecommendation(
        id: '3',
        title: 'UX/UI Designer',
        description: 'Create intuitive and visually appealing user interfaces and experiences for digital products.',
        type: 'career',
        category: 'Design',
        confidence: 0.85,
        tags: ['Design', 'User Experience', 'Creative'],
        imageUrl: null,
        url: 'https://www.example.com/careers/ux-designer',
        metadata: {'demand': 'High', 'growth': 'Good'},
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        careerPath: 'UX/UI Design',
        salaryRange: 85000,
        growthRate: 18,
        requiredSkills: ['Design Thinking', 'Prototyping', 'User Research'],
        recommendedSkills: ['Figma', 'Adobe XD', 'HTML/CSS'],
        difficulty: 'Medium',
        estimatedTimeToTransition: 8,
      ),
      CareerRecommendation(
        id: '4',
        title: 'Product Manager',
        description: 'Lead product development from conception to launch, working with cross-functional teams.',
        type: 'career',
        category: 'Management',
        confidence: 0.82,
        tags: ['Leadership', 'Strategy', 'Communication'],
        imageUrl: null,
        url: 'https://www.example.com/careers/product-manager',
        metadata: {'demand': 'High', 'growth': 'Very Good'},
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        careerPath: 'Product Management',
        salaryRange: 120000,
        growthRate: 25,
        requiredSkills: ['Product Strategy', 'Agile', 'Communication'],
        recommendedSkills: ['Data Analysis', 'UX Design', 'Technical Knowledge'],
        difficulty: 'Medium',
        estimatedTimeToTransition: 10,
      ),
    ];
  }

  List<SkillRecommendation> _getMockSkillRecommendations() {
    return [
      SkillRecommendation(
        id: '1',
        title: 'Python Programming',
        description: 'Master Python for data science, web development, and automation.',
        type: 'skill',
        category: 'Programming',
        confidence: 0.90,
        tags: ['Python', 'Programming', 'Versatile'],
        imageUrl: null,
        url: 'https://www.python.org',
        metadata: {'popularity': 'Very High'},
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        skillName: 'Python',
        level: 'intermediate',
        learningResources: ['Codecademy', 'Real Python', 'Python.org'],
        estimatedHoursToLearn: 120,
        certificationName: 'Python Institute PCAP',
        certificationUrl: 'https://pythoninstitute.org',
      ),
      SkillRecommendation(
        id: '2',
        title: 'Machine Learning',
        description: 'Learn to build intelligent systems that learn from data.',
        type: 'skill',
        category: 'AI/ML',
        confidence: 0.87,
        tags: ['ML', 'AI', 'Data Science'],
        imageUrl: null,
        url: null,
        metadata: {'demand': 'Very High'},
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        skillName: 'Machine Learning',
        level: 'advanced',
        learningResources: ['Coursera', 'Fast.ai', 'Google ML Crash Course'],
        estimatedHoursToLearn: 200,
        certificationName: 'Google ML Certification',
        certificationUrl: 'https://developers.google.com/certification',
      ),
    ];
  }

  List<CourseRecommendation> _getMockCourseRecommendations() {
    return [
      CourseRecommendation(
        id: '1',
        title: 'Complete Web Development Bootcamp',
        description: 'Become a full-stack web developer with this comprehensive course.',
        type: 'course',
        category: 'Web Development',
        confidence: 0.91,
        tags: ['Web Dev', 'Full Stack', 'JavaScript'],
        imageUrl: null,
        url: 'https://www.udemy.com',
        metadata: {'students': '500000+'},
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        courseName: 'Web Development Bootcamp',
        provider: 'Udemy',
        rating: 4.7,
        numberOfStudents: 500000,
        price: 84.99,
        currency: 'USD',
        duration: 65,
        level: 'Beginner',
        instructors: ['Dr. Angela Yu'],
        certificateIncluded: 'Yes',
      ),
      CourseRecommendation(
        id: '2',
        title: 'Machine Learning Specialization',
        description: 'Learn ML fundamentals from Andrew Ng.',
        type: 'course',
        category: 'Machine Learning',
        confidence: 0.89,
        tags: ['ML', 'AI', 'Python'],
        imageUrl: null,
        url: 'https://www.coursera.org',
        metadata: {'institution': 'Stanford'},
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        courseName: 'Machine Learning',
        provider: 'Coursera',
        rating: 4.9,
        numberOfStudents: 4500000,
        price: 49.00,
        currency: 'USD',
        duration: 120,
        level: 'Intermediate',
        instructors: ['Andrew Ng'],
        certificateIncluded: 'Yes',
      ),
    ];
  }
}

// Provider for RecommendationService
final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      receiveTimeout: Duration(milliseconds: AppConstants.apiTimeout),
    ),
  );
  return RecommendationService(dio);
});

// State providers for different recommendation types
final careerRecommendationsProvider = FutureProvider<List<CareerRecommendation>>((ref) async {
  final service = ref.watch(recommendationServiceProvider);
  return service.getCareerRecommendations();
});

final skillRecommendationsProvider = FutureProvider<List<SkillRecommendation>>((ref) async {
  final service = ref.watch(recommendationServiceProvider);
  return service.getSkillRecommendations();
});

final courseRecommendationsProvider = FutureProvider<List<CourseRecommendation>>((ref) async {
  final service = ref.watch(recommendationServiceProvider);
  return service.getCourseRecommendations();
});
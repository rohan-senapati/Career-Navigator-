// lib/models/recommendation.dart
class CareerRecommendation {
  final String title;
  final String category;
  final String description;
  final double salaryRange;
  final double growthRate;
  final int estimatedTimeToTransition;
  final List<String> requiredSkills;
  final List<String> recommendedSkills;
  final double confidence;

  CareerRecommendation({
    required this.title,
    required this.category,
    required this.description,
    required this.salaryRange,
    required this.growthRate,
    required this.estimatedTimeToTransition,
    required this.requiredSkills,
    required this.recommendedSkills,
    required this.confidence,
  });

  factory CareerRecommendation.fromJson(Map<String, dynamic> json) {
    return CareerRecommendation(
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      salaryRange: (json['salary_range'] ?? 0).toDouble(),
      growthRate: (json['growth_rate'] ?? 0).toDouble(),
      estimatedTimeToTransition: json['estimated_time_to_transition'] ?? 0,
      requiredSkills: List<String>.from(json['required_skills'] ?? []),
      recommendedSkills: List<String>.from(json['recommended_skills'] ?? []),
      confidence: (json['confidence'] ?? 0).toDouble(),
    );
  }
}

class CourseRecommendation {
  final String name;
  final String url;
  final double rating;
  final String difficulty;

  CourseRecommendation({
    required this.name,
    required this.url,
    required this.rating,
    required this.difficulty,
  });

  String get title => name;
  String get level => difficulty;
  String get provider => 'Coursera';
  List<String> get instructors => [];
  int get duration => 0;
  double get price => 0.0;
  int get numberOfStudents => 0;
  String get description => 'Learn $name on Coursera';

  factory CourseRecommendation.fromJson(Map<String, dynamic> json) {
    return CourseRecommendation(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      difficulty: json['difficulty'] ?? 'Beginner',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'rating': rating,
      'difficulty': difficulty,
    };
  }
}

class JobRecommendation {
  final String title;
  final String company;
  final String location;
  final String description;
  final String? jobUrl;
  final String? employmentType;
  final String? experienceLevel;
  final List<String> skills;
  final String? salaryRange;
  final String? postedDate;
  final String? site;

  JobRecommendation({
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    this.jobUrl,
    this.employmentType,
    this.experienceLevel,
    this.skills = const [],
    this.salaryRange,
    this.postedDate,
    this.site,
  });

  factory JobRecommendation.fromJson(Map<String, dynamic> json) {
    // Handle different possible field names from the API
    String extractString(Map<String, dynamic> json, List<String> keys, {String defaultValue = ''}) {
      for (var key in keys) {
        if (json.containsKey(key) && json[key] != null) {
          return json[key].toString();
        }
      }
      return defaultValue;
    }


    return JobRecommendation(
      title: extractString(json, ['title', 'job_title', 'position']),
      company: extractString(json, ['company', 'company_name', 'employer']),
      location: extractString(json, ['location', 'job_location']),
      description: extractString(json, ['description', 'job_description', 'summary']),
      jobUrl: extractString(json, ['job_url', 'url', 'link'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'description': description,
      'job_url': jobUrl,
      'employment_type': employmentType,
      'experience_level': experienceLevel,
      'skills': skills,
      'salary_range': salaryRange,
      'posted_date': postedDate,
      'site': site,
    };
  }
}
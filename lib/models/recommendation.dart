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

// Updated CourseRecommendation to match backend response
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

  // Compatibility getters for frontend that expects different field names
  String get title => name;
  String get level => difficulty;
  String get provider => 'Coursera'; // Default since backend doesn't provide this
  List<String> get instructors => []; // Empty list since backend doesn't provide this
  int get duration => 0; // Default since backend doesn't provide this
  double get price => 0.0; // Default since backend doesn't provide this
  int get numberOfStudents => 0; // Default since backend doesn't provide this
  String get description => 'Learn $name on Coursera'; // Generated description

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

// New Job model to match backend job search response
class JobRecommendation {
  final String title;
  final String company;
  final String location;
  final String description;
  final String? jobUrl;
  final String? employmentType;
  final String? experienceLevel;
  final List<String> skills;

  JobRecommendation({
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    this.jobUrl,
    this.employmentType,
    this.experienceLevel,
    this.skills = const [],
  });

  factory JobRecommendation.fromJson(Map<String, dynamic> json) {
    return JobRecommendation(
      title: json['title'] ?? json['job_title'] ?? '',
      company: json['company'] ?? json['company_name'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? json['job_description'] ?? '',
      jobUrl: json['job_url'] ?? json['url'],
      employmentType: json['employment_type'] ?? json['job_type'],
      experienceLevel: json['experience_level'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : [],
    );
  }
}
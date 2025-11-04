
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
  final String title;
  final String description;
  final String provider;
  final List<String> instructors;
  final int duration;
  final String level;
  final double price;
  final double rating;
  final int numberOfStudents;

  CourseRecommendation({
    required this.title,
    required this.description,
    required this.provider,
    required this.instructors,
    required this.duration,
    required this.level,
    required this.price,
    required this.rating,
    required this.numberOfStudents,
  });

  factory CourseRecommendation.fromJson(Map<String, dynamic> json) {
    return CourseRecommendation(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      provider: json['provider'] ?? '',
      instructors: List<String>.from(json['instructors'] ?? []),
      duration: json['duration'] ?? 0,
      level: json['level'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      numberOfStudents: json['num_students'] ?? 0,
    );
  }
}

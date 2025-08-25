import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation.g.dart';

@JsonSerializable()
class Recommendation extends Equatable {
  final String id;
  final String title;
  final String description;
  final String type;
  final String category;
  final double confidence;
  final List<String> tags;
  final String? imageUrl;
  final String? url;
  final Map<String, dynamic> metadata;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Recommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.confidence,
    required this.tags,
    this.imageUrl,
    this.url,
    required this.metadata,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Computed properties
  String get confidencePercentage => '${(confidence * 100).toStringAsFixed(0)}%';
  bool get isHighConfidence => confidence >= 0.8;
  bool get isMediumConfidence => confidence >= 0.6 && confidence < 0.8;
  bool get isLowConfidence => confidence < 0.6;

  factory Recommendation.fromJson(Map<String, dynamic> json) => _$RecommendationFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationToJson(this);

  Recommendation copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? category,
    double? confidence,
    List<String>? tags,
    String? imageUrl,
    String? url,
    Map<String, dynamic>? metadata,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Recommendation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      confidence: confidence ?? this.confidence,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      url: url ?? this.url,
      metadata: metadata ?? this.metadata,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    type,
    category,
    confidence,
    tags,
    imageUrl,
    url,
    metadata,
    isActive,
    createdAt,
    updatedAt,
  ];
}

@JsonSerializable()
class CareerRecommendation extends Recommendation {
  final String careerPath;
  final double salaryRange;
  final int growthRate;
  final List<String> requiredSkills;
  final List<String> recommendedSkills;
  final String difficulty;
  final int estimatedTimeToTransition; // in months

  const CareerRecommendation({
    required super.id,
    required super.title,
    required super.description,
    required super.type,
    required super.category,
    required super.confidence,
    required super.tags,
    super.imageUrl,
    super.url,
    required super.metadata,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    required this.careerPath,
    required this.salaryRange,
    required this.growthRate,
    required this.requiredSkills,
    required this.recommendedSkills,
    required this.difficulty,
    required this.estimatedTimeToTransition,
  });

  factory CareerRecommendation.fromJson(Map<String, dynamic> json) => _$CareerRecommendationFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CareerRecommendationToJson(this);

  @override
  CareerRecommendation copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? category,
    double? confidence,
    List<String>? tags,
    String? imageUrl,
    String? url,
    Map<String, dynamic>? metadata,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? careerPath,
    double? salaryRange,
    int? growthRate,
    List<String>? requiredSkills,
    List<String>? recommendedSkills,
    String? difficulty,
    int? estimatedTimeToTransition,
  }) {
    return CareerRecommendation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      confidence: confidence ?? this.confidence,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      url: url ?? this.url,
      metadata: metadata ?? this.metadata,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      careerPath: careerPath ?? this.careerPath,
      salaryRange: salaryRange ?? this.salaryRange,
      growthRate: growthRate ?? this.growthRate,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      recommendedSkills: recommendedSkills ?? this.recommendedSkills,
      difficulty: difficulty ?? this.difficulty,
      estimatedTimeToTransition: estimatedTimeToTransition ?? this.estimatedTimeToTransition,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    careerPath,
    salaryRange,
    growthRate,
    requiredSkills,
    recommendedSkills,
    difficulty,
    estimatedTimeToTransition,
  ];
}

@JsonSerializable()
class SkillRecommendation extends Recommendation {
  final String skillName;
  final String level; // 'beginner', 'intermediate', 'advanced', 'expert'
  final List<String> learningResources;
  final int estimatedHoursToLearn;
  final String? certificationName;
  final String? certificationUrl;

  const SkillRecommendation({
    required super.id,
    required super.title,
    required super.description,
    required super.type,
    required super.category,
    required super.confidence,
    required super.tags,
    super.imageUrl,
    super.url,
    required super.metadata,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    required this.skillName,
    required this.level,
    required this.learningResources,
    required this.estimatedHoursToLearn,
    this.certificationName,
    this.certificationUrl,
  });

  factory SkillRecommendation.fromJson(Map<String, dynamic> json) => _$SkillRecommendationFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SkillRecommendationToJson(this);

  @override
  SkillRecommendation copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? category,
    double? confidence,
    List<String>? tags,
    String? imageUrl,
    String? url,
    Map<String, dynamic>? metadata,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? skillName,
    String? level,
    List<String>? learningResources,
    int? estimatedHoursToLearn,
    String? certificationName,
    String? certificationUrl,
  }) {
    return SkillRecommendation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      confidence: confidence ?? this.confidence,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      url: url ?? this.url,
      metadata: metadata ?? this.metadata,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      skillName: skillName ?? this.skillName,
      level: level ?? this.level,
      learningResources: learningResources ?? this.learningResources,
      estimatedHoursToLearn: estimatedHoursToLearn ?? this.estimatedHoursToLearn,
      certificationName: certificationName ?? this.certificationName,
      certificationUrl: certificationUrl ?? this.certificationUrl,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    skillName,
    level,
    learningResources,
    estimatedHoursToLearn,
    certificationName,
    certificationUrl,
  ];
}

@JsonSerializable()
class CourseRecommendation extends Recommendation {
  final String courseName;
  final String provider; // 'coursera', 'udemy', 'edx', etc.
  final double rating;
  final int numberOfStudents;
  final double price;
  final String currency;
  final int duration; // in hours
  final String level;
  final List<String> instructors;
  final String? certificateIncluded;

  const CourseRecommendation({
    required super.id,
    required super.title,
    required super.description,
    required super.type,
    required super.category,
    required super.confidence,
    required super.tags,
    super.imageUrl,
    super.url,
    required super.metadata,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    required this.courseName,
    required this.provider,
    required this.rating,
    required this.numberOfStudents,
    required this.price,
    required this.currency,
    required this.duration,
    required this.level,
    required this.instructors,
    this.certificateIncluded,
  });

  factory CourseRecommendation.fromJson(Map<String, dynamic> json) => _$CourseRecommendationFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CourseRecommendationToJson(this);

  @override
  CourseRecommendation copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? category,
    double? confidence,
    List<String>? tags,
    String? imageUrl,
    String? url,
    Map<String, dynamic>? metadata,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? courseName,
    String? provider,
    double? rating,
    int? numberOfStudents,
    double? price,
    String? currency,
    int? duration,
    String? level,
    List<String>? instructors,
    String? certificateIncluded,
  }) {
    return CourseRecommendation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      confidence: confidence ?? this.confidence,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      url: url ?? this.url,
      metadata: metadata ?? this.metadata,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      courseName: courseName ?? this.courseName,
      provider: provider ?? this.provider,
      rating: rating ?? this.rating,
      numberOfStudents: numberOfStudents ?? this.numberOfStudents,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      duration: duration ?? this.duration,
      level: level ?? this.level,
      instructors: instructors ?? this.instructors,
      certificateIncluded: certificateIncluded ?? this.certificateIncluded,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    courseName,
    provider,
    rating,
    numberOfStudents,
    price,
    currency,
    duration,
    level,
    instructors,
    certificateIncluded,
  ];
}

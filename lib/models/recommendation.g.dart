// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String?,
      url: json['url'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'category': instance.category,
      'confidence': instance.confidence,
      'tags': instance.tags,
      'imageUrl': instance.imageUrl,
      'url': instance.url,
      'metadata': instance.metadata,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

CareerRecommendation _$CareerRecommendationFromJson(
  Map<String, dynamic> json,
) => CareerRecommendation(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: json['type'] as String,
  category: json['category'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  imageUrl: json['imageUrl'] as String?,
  url: json['url'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>,
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  careerPath: json['careerPath'] as String,
  salaryRange: (json['salaryRange'] as num).toDouble(),
  growthRate: (json['growthRate'] as num).toInt(),
  requiredSkills: (json['requiredSkills'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  recommendedSkills: (json['recommendedSkills'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  difficulty: json['difficulty'] as String,
  estimatedTimeToTransition: (json['estimatedTimeToTransition'] as num).toInt(),
);

Map<String, dynamic> _$CareerRecommendationToJson(
  CareerRecommendation instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'category': instance.category,
  'confidence': instance.confidence,
  'tags': instance.tags,
  'imageUrl': instance.imageUrl,
  'url': instance.url,
  'metadata': instance.metadata,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'careerPath': instance.careerPath,
  'salaryRange': instance.salaryRange,
  'growthRate': instance.growthRate,
  'requiredSkills': instance.requiredSkills,
  'recommendedSkills': instance.recommendedSkills,
  'difficulty': instance.difficulty,
  'estimatedTimeToTransition': instance.estimatedTimeToTransition,
};

SkillRecommendation _$SkillRecommendationFromJson(Map<String, dynamic> json) =>
    SkillRecommendation(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String?,
      url: json['url'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      skillName: json['skillName'] as String,
      level: json['level'] as String,
      learningResources: (json['learningResources'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      estimatedHoursToLearn: (json['estimatedHoursToLearn'] as num).toInt(),
      certificationName: json['certificationName'] as String?,
      certificationUrl: json['certificationUrl'] as String?,
    );

Map<String, dynamic> _$SkillRecommendationToJson(
  SkillRecommendation instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'category': instance.category,
  'confidence': instance.confidence,
  'tags': instance.tags,
  'imageUrl': instance.imageUrl,
  'url': instance.url,
  'metadata': instance.metadata,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'skillName': instance.skillName,
  'level': instance.level,
  'learningResources': instance.learningResources,
  'estimatedHoursToLearn': instance.estimatedHoursToLearn,
  'certificationName': instance.certificationName,
  'certificationUrl': instance.certificationUrl,
};

CourseRecommendation _$CourseRecommendationFromJson(
  Map<String, dynamic> json,
) => CourseRecommendation(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: json['type'] as String,
  category: json['category'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  imageUrl: json['imageUrl'] as String?,
  url: json['url'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>,
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  courseName: json['courseName'] as String,
  provider: json['provider'] as String,
  rating: (json['rating'] as num).toDouble(),
  numberOfStudents: (json['numberOfStudents'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  currency: json['currency'] as String,
  duration: (json['duration'] as num).toInt(),
  level: json['level'] as String,
  instructors: (json['instructors'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  certificateIncluded: json['certificateIncluded'] as String?,
);

Map<String, dynamic> _$CourseRecommendationToJson(
  CourseRecommendation instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'category': instance.category,
  'confidence': instance.confidence,
  'tags': instance.tags,
  'imageUrl': instance.imageUrl,
  'url': instance.url,
  'metadata': instance.metadata,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'courseName': instance.courseName,
  'provider': instance.provider,
  'rating': instance.rating,
  'numberOfStudents': instance.numberOfStudents,
  'price': instance.price,
  'currency': instance.currency,
  'duration': instance.duration,
  'level': instance.level,
  'instructors': instance.instructors,
  'certificateIncluded': instance.certificateIncluded,
};

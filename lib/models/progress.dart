import 'package:equatable/equatable.dart';

class Progress extends Equatable {
  final String id;
  final String userId;
  final String type; // 'skill', 'course', 'quiz', 'goal'
  final String title;
  final String description;
  final int currentValue;
  final int targetValue;
  final String unit; // 'points', 'percentage', 'hours', 'lessons'
  final DateTime startDate;
  final DateTime? completedDate;
  final String status; // 'not_started', 'in_progress', 'completed', 'paused'
  final double percentage;
  final Map<String, dynamic> metadata;

  const Progress({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.description,
    required this.currentValue,
    required this.targetValue,
    required this.unit,
    required this.startDate,
    this.completedDate,
    required this.status,
    required this.percentage,
    required this.metadata,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      currentValue: json['current_value'] as int? ?? 0,
      targetValue: json['target_value'] as int? ?? 100,
      unit: json['unit'] as String? ?? 'percentage',
      startDate: DateTime.parse(json['start_date'] as String),
      completedDate: json['completed_date'] != null 
          ? DateTime.parse(json['completed_date'] as String)
          : null,
      status: json['status'] as String? ?? 'not_started',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'title': title,
      'description': description,
      'current_value': currentValue,
      'target_value': targetValue,
      'unit': unit,
      'start_date': startDate.toIso8601String(),
      'completed_date': completedDate?.toIso8601String(),
      'status': status,
      'percentage': percentage,
      'metadata': metadata,
    };
  }

  Progress copyWith({
    String? id,
    String? userId,
    String? type,
    String? title,
    String? description,
    int? currentValue,
    int? targetValue,
    String? unit,
    DateTime? startDate,
    DateTime? completedDate,
    String? status,
    double? percentage,
    Map<String, dynamic>? metadata,
  }) {
    return Progress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      currentValue: currentValue ?? this.currentValue,
      targetValue: targetValue ?? this.targetValue,
      unit: unit ?? this.unit,
      startDate: startDate ?? this.startDate,
      completedDate: completedDate ?? this.completedDate,
      status: status ?? this.status,
      percentage: percentage ?? this.percentage,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    type,
    title,
    description,
    currentValue,
    targetValue,
    unit,
    startDate,
    completedDate,
    status,
    percentage,
    metadata,
  ];
}

class SkillProgress extends Progress {
  final String skillName;
  final String level; // 'beginner', 'intermediate', 'advanced', 'expert'
  final List<String> completedCourses;
  final List<String> completedQuizzes;
  final int totalHoursSpent;
  final DateTime? lastPracticed;

  const SkillProgress({
    required super.id,
    required super.userId,
    required super.title,
    required super.description,
    required super.currentValue,
    required super.targetValue,
    required super.unit,
    required super.startDate,
    super.completedDate,
    required super.status,
    required super.percentage,
    required super.metadata,
    required this.skillName,
    required this.level,
    required this.completedCourses,
    required this.completedQuizzes,
    required this.totalHoursSpent,
    this.lastPracticed,
  }) : super(type: 'skill');

  factory SkillProgress.fromJson(Map<String, dynamic> json) {
    return SkillProgress(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      currentValue: json['current_value'] as int? ?? 0,
      targetValue: json['target_value'] as int? ?? 100,
      unit: json['unit'] as String? ?? 'percentage',
      startDate: DateTime.parse(json['start_date'] as String),
      completedDate: json['completed_date'] != null 
          ? DateTime.parse(json['completed_date'] as String)
          : null,
      status: json['status'] as String? ?? 'not_started',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
      skillName: json['skill_name'] as String,
      level: json['level'] as String,
      completedCourses: List<String>.from(json['completed_courses'] ?? []),
      completedQuizzes: List<String>.from(json['completed_quizzes'] ?? []),
      totalHoursSpent: json['total_hours_spent'] as int? ?? 0,
      lastPracticed: json['last_practiced'] != null 
          ? DateTime.parse(json['last_practiced'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'skill_name': skillName,
      'level': level,
      'completed_courses': completedCourses,
      'completed_quizzes': completedQuizzes,
      'total_hours_spent': totalHoursSpent,
      'last_practiced': lastPracticed?.toIso8601String(),
    };
  }

  @override
  SkillProgress copyWith({
    String? id,
    String? userId,
    String? title,
    String? type,
    String? description,
    int? currentValue,
    int? targetValue,
    String? unit,
    DateTime? startDate,
    DateTime? completedDate,
    String? status,
    double? percentage,
    Map<String, dynamic>? metadata,
    String? skillName,
    String? level,
    List<String>? completedCourses,
    List<String>? completedQuizzes,
    int? totalHoursSpent,
    DateTime? lastPracticed,
  }) {
    return SkillProgress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      currentValue: currentValue ?? this.currentValue,
      targetValue: targetValue ?? this.targetValue,
      unit: unit ?? this.unit,
      startDate: startDate ?? this.startDate,
      completedDate: completedDate ?? this.completedDate,
      status: status ?? this.status,
      percentage: percentage ?? this.percentage,
      metadata: metadata ?? this.metadata,
      skillName: skillName ?? this.skillName,
      level: level ?? this.level,
      completedCourses: completedCourses ?? this.completedCourses,
      completedQuizzes: completedQuizzes ?? this.completedQuizzes,
      totalHoursSpent: totalHoursSpent ?? this.totalHoursSpent,
      lastPracticed: lastPracticed ?? this.lastPracticed,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    skillName,
    level,
    completedCourses,
    completedQuizzes,
    totalHoursSpent,
    lastPracticed,
  ];
}

class CourseProgress extends Progress {
  final String courseId;
  final String courseTitle;
  final String provider;
  final int totalLessons;
  final int completedLessons;
  final int totalQuizzes;
  final int completedQuizzes;
  final double averageScore;
  final DateTime? lastAccessed;

  const CourseProgress({
    required super.id,
    required super.userId,
    required super.title,
    required super.description,
    required super.currentValue,
    required super.targetValue,
    required super.unit,
    required super.startDate,
    super.completedDate,
    required super.status,
    required super.percentage,
    required super.metadata,
    required this.courseId,
    required this.courseTitle,
    required this.provider,
    required this.totalLessons,
    required this.completedLessons,
    required this.totalQuizzes,
    required this.completedQuizzes,
    required this.averageScore,
    this.lastAccessed,
  }) : super(type: 'course');

  factory CourseProgress.fromJson(Map<String, dynamic> json) {
    return CourseProgress(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      currentValue: json['current_value'] as int? ?? 0,
      targetValue: json['target_value'] as int? ?? 100,
      unit: json['unit'] as String? ?? 'percentage',
      startDate: DateTime.parse(json['start_date'] as String),
      completedDate: json['completed_date'] != null 
          ? DateTime.parse(json['completed_date'] as String)
          : null,
      status: json['status'] as String? ?? 'not_started',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
      courseId: json['course_id'] as String,
      courseTitle: json['course_title'] as String,
      provider: json['provider'] as String,
      totalLessons: json['total_lessons'] as int? ?? 0,
      completedLessons: json['completed_lessons'] as int? ?? 0,
      totalQuizzes: json['total_quizzes'] as int? ?? 0,
      completedQuizzes: json['completed_quizzes'] as int? ?? 0,
      averageScore: (json['average_score'] as num?)?.toDouble() ?? 0.0,
      lastAccessed: json['last_accessed'] != null 
          ? DateTime.parse(json['last_accessed'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'course_id': courseId,
      'course_title': courseTitle,
      'provider': provider,
      'total_lessons': totalLessons,
      'completed_lessons': completedLessons,
      'total_quizzes': totalQuizzes,
      'completed_quizzes': completedQuizzes,
      'average_score': averageScore,
      'last_accessed': lastAccessed?.toIso8601String(),
    };
  }

  @override
  CourseProgress copyWith({
    String? id,
    String? userId,
    String? title,
    String? type,
    String? description,
    int? currentValue,
    int? targetValue,
    String? unit,
    DateTime? startDate,
    DateTime? completedDate,
    String? status,
    double? percentage,
    Map<String, dynamic>? metadata,
    String? courseId,
    String? courseTitle,
    String? provider,
    int? totalLessons,
    int? completedLessons,
    int? totalQuizzes,
    int? completedQuizzes,
    double? averageScore,
    DateTime? lastAccessed,
  }) {
    return CourseProgress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      currentValue: currentValue ?? this.currentValue,
      targetValue: targetValue ?? this.targetValue,
      unit: unit ?? this.unit,
      startDate: startDate ?? this.startDate,
      completedDate: completedDate ?? this.completedDate,
      status: status ?? this.status,
      percentage: percentage ?? this.percentage,
      metadata: metadata ?? this.metadata,
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      provider: provider ?? this.provider,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      completedQuizzes: completedQuizzes ?? this.completedQuizzes,
      averageScore: averageScore ?? this.averageScore,
      lastAccessed: lastAccessed ?? this.lastAccessed,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    courseId,
    courseTitle,
    provider,
    totalLessons,
    completedLessons,
    totalQuizzes,
    completedQuizzes,
    averageScore,
    lastAccessed,
  ];
}



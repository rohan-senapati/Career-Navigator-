import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final int timeLimit; // in minutes
  final int totalQuestions;
  final List<QuizQuestion> questions;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final List<String> tags;
  final String? instructions;
  final int passingScore; // percentage

  const Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.timeLimit,
    required this.totalQuestions,
    required this.questions,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.tags,
    this.instructions,
    required this.passingScore,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      timeLimit: json['time_limit'] as int? ?? 30,
      totalQuestions: json['total_questions'] as int? ?? 0,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((q) => QuizQuestion.fromJson(q as Map<String, dynamic>))
          .toList() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isActive: json['is_active'] as bool? ?? true,
      tags: List<String>.from(json['tags'] ?? []),
      instructions: json['instructions'] as String?,
      passingScore: json['passing_score'] as int? ?? 70,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'time_limit': timeLimit,
      'total_questions': totalQuestions,
      'questions': questions.map((q) => q.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
      'tags': tags,
      'instructions': instructions,
      'passing_score': passingScore,
    };
  }

  Quiz copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? difficulty,
    int? timeLimit,
    int? totalQuestions,
    List<QuizQuestion>? questions,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    List<String>? tags,
    String? instructions,
    int? passingScore,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      timeLimit: timeLimit ?? this.timeLimit,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      questions: questions ?? this.questions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      tags: tags ?? this.tags,
      instructions: instructions ?? this.instructions,
      passingScore: passingScore ?? this.passingScore,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    difficulty,
    timeLimit,
    totalQuestions,
    questions,
    createdAt,
    updatedAt,
    isActive,
    tags,
    instructions,
    passingScore,
  ];
}

class QuizQuestion extends Equatable {
  final String id;
  final String question;
  final String type; // 'multiple_choice', 'single_choice', 'text'
  final List<QuizOption> options;
  final String? correctAnswer;
  final int points;
  final String? explanation;
  final String? category;
  final int order;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.type,
    required this.options,
    this.correctAnswer,
    required this.points,
    this.explanation,
    this.category,
    required this.order,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
      type: json['type'] as String,
      options: (json['options'] as List<dynamic>?)
          ?.map((o) => QuizOption.fromJson(o as Map<String, dynamic>))
          .toList() ?? [],
      correctAnswer: json['correct_answer'] as String?,
      points: json['points'] as int? ?? 1,
      explanation: json['explanation'] as String?,
      category: json['category'] as String?,
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'type': type,
      'options': options.map((o) => o.toJson()).toList(),
      'correct_answer': correctAnswer,
      'points': points,
      'explanation': explanation,
      'category': category,
      'order': order,
    };
  }

  QuizQuestion copyWith({
    String? id,
    String? question,
    String? type,
    List<QuizOption>? options,
    String? correctAnswer,
    int? points,
    String? explanation,
    String? category,
    int? order,
  }) {
    return QuizQuestion(
      id: id ?? this.id,
      question: question ?? this.question,
      type: type ?? this.type,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      points: points ?? this.points,
      explanation: explanation ?? this.explanation,
      category: category ?? this.category,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [
    id,
    question,
    type,
    options,
    correctAnswer,
    points,
    explanation,
    category,
    order,
  ];
}

class QuizOption extends Equatable {
  final String id;
  final String text;
  final bool isCorrect;
  final String? explanation;

  const QuizOption({
    required this.id,
    required this.text,
    required this.isCorrect,
    this.explanation,
  });

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      id: json['id'] as String,
      text: json['text'] as String,
      isCorrect: json['is_correct'] as bool? ?? false,
      explanation: json['explanation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'is_correct': isCorrect,
      'explanation': explanation,
    };
  }

  QuizOption copyWith({
    String? id,
    String? text,
    bool? isCorrect,
    String? explanation,
  }) {
    return QuizOption(
      id: id ?? this.id,
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
      explanation: explanation ?? this.explanation,
    );
  }

  @override
  List<Object?> get props => [id, text, isCorrect, explanation];
}

class QuizAttempt extends Equatable {
  final String id;
  final String quizId;
  final String userId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int score;
  final int totalScore;
  final String status; // 'in_progress', 'completed', 'abandoned'
  final List<QuizAnswer> answers;
  final int timeSpent; // in seconds

  const QuizAttempt({
    required this.id,
    required this.quizId,
    required this.userId,
    required this.startedAt,
    this.completedAt,
    required this.score,
    required this.totalScore,
    required this.status,
    required this.answers,
    required this.timeSpent,
  });

  double get percentage => totalScore > 0 ? (score / totalScore) * 100 : 0;
  
  bool get isPassed => percentage >= 70; // Assuming 70% is passing

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      id: json['id'] as String,
      quizId: json['quiz_id'] as String,
      userId: json['user_id'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] != null 
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      score: json['score'] as int? ?? 0,
      totalScore: json['total_score'] as int? ?? 0,
      status: json['status'] as String,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((a) => QuizAnswer.fromJson(a as Map<String, dynamic>))
          .toList() ?? [],
      timeSpent: json['time_spent'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_id': quizId,
      'user_id': userId,
      'started_at': startedAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'score': score,
      'total_score': totalScore,
      'status': status,
      'answers': answers.map((a) => a.toJson()).toList(),
      'time_spent': timeSpent,
    };
  }

  QuizAttempt copyWith({
    String? id,
    String? quizId,
    String? userId,
    DateTime? startedAt,
    DateTime? completedAt,
    int? score,
    int? totalScore,
    String? status,
    List<QuizAnswer>? answers,
    int? timeSpent,
  }) {
    return QuizAttempt(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      score: score ?? this.score,
      totalScore: totalScore ?? this.totalScore,
      status: status ?? this.status,
      answers: answers ?? this.answers,
      timeSpent: timeSpent ?? this.timeSpent,
    );
  }

  @override
  List<Object?> get props => [
    id,
    quizId,
    userId,
    startedAt,
    completedAt,
    score,
    totalScore,
    status,
    answers,
    timeSpent,
  ];
}

class QuizAnswer extends Equatable {
  final String questionId;
  final List<String> selectedOptions;
  final String? textAnswer;
  final bool isCorrect;
  final int pointsEarned;
  final DateTime answeredAt;

  const QuizAnswer({
    required this.questionId,
    required this.selectedOptions,
    this.textAnswer,
    required this.isCorrect,
    required this.pointsEarned,
    required this.answeredAt,
  });

  factory QuizAnswer.fromJson(Map<String, dynamic> json) {
    return QuizAnswer(
      questionId: json['question_id'] as String,
      selectedOptions: List<String>.from(json['selected_options'] ?? []),
      textAnswer: json['text_answer'] as String?,
      isCorrect: json['is_correct'] as bool? ?? false,
      pointsEarned: json['points_earned'] as int? ?? 0,
      answeredAt: DateTime.parse(json['answered_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'selected_options': selectedOptions,
      'text_answer': textAnswer,
      'is_correct': isCorrect,
      'points_earned': pointsEarned,
      'answered_at': answeredAt.toIso8601String(),
    };
  }

  QuizAnswer copyWith({
    String? questionId,
    List<String>? selectedOptions,
    String? textAnswer,
    bool? isCorrect,
    int? pointsEarned,
    DateTime? answeredAt,
  }) {
    return QuizAnswer(
      questionId: questionId ?? this.questionId,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      textAnswer: textAnswer ?? this.textAnswer,
      isCorrect: isCorrect ?? this.isCorrect,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  @override
  List<Object?> get props => [
    questionId,
    selectedOptions,
    textAnswer,
    isCorrect,
    pointsEarned,
    answeredAt,
  ];
}

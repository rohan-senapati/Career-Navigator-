import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final String? bio;
  final String? phoneNumber;
  final DateTime dateOfBirth;
  final String? location;
  final List<String> skills;
  final List<String> interests;
  final String? currentRole;
  final String? company;
  final int experienceYears;
  final String educationLevel;
  final List<String> certifications;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isEmailVerified;
  final bool isProfileComplete;
  final UserPreferences preferences;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    this.bio,
    this.phoneNumber,
    required this.dateOfBirth,
    this.location,
    required this.skills,
    required this.interests,
    this.currentRole,
    this.company,
    required this.experienceYears,
    required this.educationLevel,
    required this.certifications,
    required this.createdAt,
    required this.updatedAt,
    required this.isEmailVerified,
    required this.isProfileComplete,
    required this.preferences,
  });

  String get fullName => '$firstName $lastName';
  
  String get displayName => '$firstName $lastName';
  
  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      profilePicture: json['profile_picture'] as String?,
      bio: json['bio'] as String?,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      location: json['location'] as String?,
      skills: List<String>.from(json['skills'] ?? []),
      interests: List<String>.from(json['interests'] ?? []),
      currentRole: json['current_role'] as String?,
      company: json['company'] as String?,
      experienceYears: json['experience_years'] as int? ?? 0,
      educationLevel: json['education_level'] as String? ?? 'Not Specified',
      certifications: List<String>.from(json['certifications'] ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isEmailVerified: json['is_email_verified'] as bool? ?? false,
      isProfileComplete: json['is_profile_complete'] as bool? ?? false,
      preferences: UserPreferences.fromJson(json['preferences'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'profile_picture': profilePicture,
      'bio': bio,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'location': location,
      'skills': skills,
      'interests': interests,
      'current_role': currentRole,
      'company': company,
      'experience_years': experienceYears,
      'education_level': educationLevel,
      'certifications': certifications,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_email_verified': isEmailVerified,
      'is_profile_complete': isProfileComplete,
      'preferences': preferences.toJson(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? profilePicture,
    String? bio,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? location,
    List<String>? skills,
    List<String>? interests,
    String? currentRole,
    String? company,
    int? experienceYears,
    String? educationLevel,
    List<String>? certifications,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isEmailVerified,
    bool? isProfileComplete,
    UserPreferences? preferences,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      currentRole: currentRole ?? this.currentRole,
      company: company ?? this.company,
      experienceYears: experienceYears ?? this.experienceYears,
      educationLevel: educationLevel ?? this.educationLevel,
      certifications: certifications ?? this.certifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    profilePicture,
    bio,
    phoneNumber,
    dateOfBirth,
    location,
    skills,
    interests,
    currentRole,
    company,
    experienceYears,
    educationLevel,
    certifications,
    createdAt,
    updatedAt,
    isEmailVerified,
    isProfileComplete,
    preferences,
  ];
}

class UserPreferences extends Equatable {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool weeklyReports;
  final String language;
  final String theme;
  final List<String> careerGoals;
  final String preferredJobType;
  final String preferredLocation;
  final int salaryExpectation;
  final bool shareProfile;

  const UserPreferences({
    required this.emailNotifications,
    required this.pushNotifications,
    required this.weeklyReports,
    required this.language,
    required this.theme,
    required this.careerGoals,
    required this.preferredJobType,
    required this.preferredLocation,
    required this.salaryExpectation,
    required this.shareProfile,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      emailNotifications: json['email_notifications'] as bool? ?? true,
      pushNotifications: json['push_notifications'] as bool? ?? true,
      weeklyReports: json['weekly_reports'] as bool? ?? true,
      language: json['language'] as String? ?? 'en',
      theme: json['theme'] as String? ?? 'system',
      careerGoals: List<String>.from(json['career_goals'] ?? []),
      preferredJobType: json['preferred_job_type'] as String? ?? 'Full-time',
      preferredLocation: json['preferred_location'] as String? ?? 'Remote',
      salaryExpectation: json['salary_expectation'] as int? ?? 0,
      shareProfile: json['share_profile'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email_notifications': emailNotifications,
      'push_notifications': pushNotifications,
      'weekly_reports': weeklyReports,
      'language': language,
      'theme': theme,
      'career_goals': careerGoals,
      'preferred_job_type': preferredJobType,
      'preferred_location': preferredLocation,
      'salary_expectation': salaryExpectation,
      'share_profile': shareProfile,
    };
  }

  UserPreferences copyWith({
    bool? emailNotifications,
    bool? pushNotifications,
    bool? weeklyReports,
    String? language,
    String? theme,
    List<String>? careerGoals,
    String? preferredJobType,
    String? preferredLocation,
    int? salaryExpectation,
    bool? shareProfile,
  }) {
    return UserPreferences(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      weeklyReports: weeklyReports ?? this.weeklyReports,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      careerGoals: careerGoals ?? this.careerGoals,
      preferredJobType: preferredJobType ?? this.preferredJobType,
      preferredLocation: preferredLocation ?? this.preferredLocation,
      salaryExpectation: salaryExpectation ?? this.salaryExpectation,
      shareProfile: shareProfile ?? this.shareProfile,
    );
  }

  @override
  List<Object?> get props => [
    emailNotifications,
    pushNotifications,
    weeklyReports,
    language,
    theme,
    careerGoals,
    preferredJobType,
    preferredLocation,
    salaryExpectation,
    shareProfile,
  ];
}

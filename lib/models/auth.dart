import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [email, password];
}

class SignUpRequest extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String? phoneNumber;

  const SignUpRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'phone_number': phoneNumber,
    };
  }

  @override
  List<Object?> get props => [
    email,
    password,
    firstName,
    lastName,
    dateOfBirth,
    phoneNumber,
  ];
}

class TokenResponse extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final UserResponse user;
  final int expiresIn;

  const TokenResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.user,
    required this.expiresIn,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
      user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      expiresIn: json['expires_in'] as int? ?? 1800,
    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    tokenType,
    user,
    expiresIn,
  ];
}

class UserResponse extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final DateTime dateOfBirth;
  final String? profilePicture;
  final String? bio;
  final String? location;
  final String? currentRole;
  final String? company;
  final String experienceYears;
  final String? educationLevel;
  final bool isEmailVerified;
  final bool isProfileComplete;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.dateOfBirth,
    this.profilePicture,
    this.bio,
    this.location,
    this.currentRole,
    this.company,
    required this.experienceYears,
    this.educationLevel,
    required this.isEmailVerified,
    required this.isProfileComplete,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      profilePicture: json['profile_picture'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      currentRole: json['current_role'] as String?,
      company: json['company'] as String?,
      experienceYears: json['experience_years'] as String? ?? '0',
      educationLevel: json['education_level'] as String?,
      isEmailVerified: json['is_email_verified'] as bool? ?? false,
      isProfileComplete: json['is_profile_complete'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'profile_picture': profilePicture,
      'bio': bio,
      'location': location,
      'current_role': currentRole,
      'company': company,
      'experience_years': experienceYears,
      'education_level': educationLevel,
      'is_email_verified': isEmailVerified,
      'is_profile_complete': isProfileComplete,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserResponse copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? profilePicture,
    String? bio,
    String? location,
    String? currentRole,
    String? company,
    String? experienceYears,
    String? educationLevel,
    bool? isEmailVerified,
    bool? isProfileComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserResponse(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      currentRole: currentRole ?? this.currentRole,
      company: company ?? this.company,
      experienceYears: experienceYears ?? this.experienceYears,
      educationLevel: educationLevel ?? this.educationLevel,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    phoneNumber,
    dateOfBirth,
    profilePicture,
    bio,
    location,
    currentRole,
    company,
    experienceYears,
    educationLevel,
    isEmailVerified,
    isProfileComplete,
    createdAt,
    updatedAt,
  ];
}

class AuthState extends Equatable {
  final bool isAuthenticated;
  final bool isLoading;
  final UserResponse? user;
  final String? accessToken;
  final String? refreshToken;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.user,
    this.accessToken,
    this.refreshToken,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    UserResponse? user,
    String? accessToken,
    String? refreshToken,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    isAuthenticated,
    isLoading,
    user,
    accessToken,
    refreshToken,
    error,
  ];
}
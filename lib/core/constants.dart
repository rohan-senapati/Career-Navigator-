class AppConstants {
  // App Information
  static const String appName = 'Career Navigator';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.careernavigator.com';
  static const int apiTimeout = 30000; // milliseconds
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultElevation = 4.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userProfileKey = 'user_profile';
  static const String quizProgressKey = 'quiz_progress';
  static const String chatHistoryKey = 'chat_history';
  
  // Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int maxNameLength = 50;
  static const int maxBioLength = 500;
  
  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;
  
  // File Upload
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx'];
  
  // Error Messages
  static const String networkErrorMessage = 'Please check your internet connection';
  static const String serverErrorMessage = 'Something went wrong. Please try again later';
  static const String validationErrorMessage = 'Please check your input and try again';
  
  // Success Messages
  static const String profileUpdatedMessage = 'Profile updated successfully';
  static const String passwordChangedMessage = 'Password changed successfully';
  static const String quizCompletedMessage = 'Quiz completed successfully';
}


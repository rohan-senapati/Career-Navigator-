import 'package:career_navigator/core/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constants.dart';

class AppHelpers {
  // Validation Helpers
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  static bool isValidPassword(String password) {
    return password.length >= AppConstants.minPasswordLength &&
           password.length <= AppConstants.maxPasswordLength;
  }
  
  static bool isValidName(String name) {
    return name.isNotEmpty && name.length <= AppConstants.maxNameLength;
  }
  
  static bool isValidBio(String bio) {
    return bio.length <= AppConstants.maxBioLength;
  }
  
  // Date Formatting
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
  
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
  }
  
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
  
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
  
  // File Size Formatting
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
  
  // Percentage Calculation
  static double calculatePercentage(int current, int total) {
    if (total == 0) return 0.0;
    return (current / total) * 100;
  }
  
  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }
  
  // Color Helpers
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
      case 'completed':
        return AppColors.success;
      case 'warning':
      case 'pending':
        return AppColors.warning;
      case 'error':
      case 'failed':
        return AppColors.error;
      case 'info':
      case 'in_progress':
        return AppColors.info;
      default:
        return AppColors.grey;
    }
  }
  
  // Text Helpers
  static String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
  
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
  
  // Navigation Helpers
  static void showSnackBar(BuildContext context, String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
      ),
    );
  }
  
  static void showErrorSnackBar(BuildContext context, String message) {
    showSnackBar(context, message, backgroundColor: AppColors.error);
  }
  
  static void showSuccessSnackBar(BuildContext context, String message) {
    showSnackBar(context, message, backgroundColor: AppColors.success);
  }
  
  // Loading Helpers
  static Widget buildLoadingIndicator({Color? color}) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
      ),
    );
  }
  
  static Widget buildShimmerLoading() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
      ),
      child: const SizedBox(
        height: 20,
        width: double.infinity,
      ),
    );
  }
  
  // Network Helpers
  static bool isNetworkError(dynamic error) {
    return error.toString().toLowerCase().contains('network') ||
           error.toString().toLowerCase().contains('connection') ||
           error.toString().toLowerCase().contains('timeout');
  }
  
  // Storage Helpers
  static String getFileExtension(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }
  
  static bool isValidFileType(String fileName, List<String> allowedTypes) {
    final extension = getFileExtension(fileName);
    return allowedTypes.contains(extension);
  }
  
  static bool isValidFileSize(int fileSize) {
    return fileSize <= AppConstants.maxFileSize;
  }
  
  // Quiz Helpers
  static String getQuizDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppColors.success.toString();
      case 'medium':
        return AppColors.warning.toString();
      case 'hard':
        return AppColors.error.toString();
      default:
        return AppColors.grey.toString();
    }
  }
  
  static String getQuizStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'not_started':
        return 'Not Started';
      case 'in_progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  }
  
  // Progress Helpers
  static String getProgressText(int current, int total) {
    return '$current of $total';
  }
  
  static double getProgressPercentage(int current, int total) {
    if (total == 0) return 0.0;
    return current / total;
  }
  
  // Chat Helpers
  static String getChatTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    
    if (messageDate == today) {
      return formatTime(timestamp);
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return formatDate(timestamp);
    }
  }
}


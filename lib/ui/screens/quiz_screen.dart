import 'package:flutter/material.dart';

import '../../core/themes.dart';
import '../widgets/navbar.dart';

class QuizScreen extends StatelessWidget {
  final String? quizId;

  const QuizScreen({super.key, this.quizId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quizId != null ? 'Quiz $quizId' : 'Career Quiz'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          quizId != null 
              ? 'Quiz Detail Screen for ID: $quizId - Coming Soon'
              : 'Career Quiz Screen - Coming Soon',
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }
}


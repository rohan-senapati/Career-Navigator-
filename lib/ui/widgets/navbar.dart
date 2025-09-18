import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/themes.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surfaceLight,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      elevation: 8,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.push('/quiz');
            break;
          case 2:
            context.push('/recommendations');
            break;
          case 3:
            context.push('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz_outlined),
          activeIcon: Icon(Icons.quiz),
          label: 'Quiz',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
          activeIcon: Icon(Icons.lightbulb),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ai_chatbot/flutter_ai_chatbot.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants.dart';
import '../../core/themes.dart';
import '../../models/auth.dart';
import '../../services/auth_service.dart';
import '../widgets/navbar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    if (authState.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.appName),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final isAuthenticated = authState.isAuthenticated;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: isAuthenticated
            ? [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                authState.user?.firstName ?? 'User',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ]
            : null,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.backgroundLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: isAuthenticated
                ? _buildAuthenticatedHome(context, authState, ref)
                : _buildUnauthenticatedHome(context),
          ),
        ),
      ),
      floatingActionButton: isAuthenticated
          ? ChatBotWidget(
        apiKey: "AIzaSyBujTjUSghUJly25yAfuZ2kLjznmFTgf8I",
        aiService: AIService.gemini,
        chatIcon: Icons.psychology,
      ):null,
      bottomNavigationBar: isAuthenticated
          ? const CustomNavBar(currentIndex: 0)
          : null,
    );
  }

  Widget _buildUnauthenticatedHome(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Career Navigator!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your AI-powered career development companion',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.push('/login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.go('/register'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Features Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildFeatureCard(
                context,
                'Career Quiz',
                'Assess your skills and interests',
                Icons.quiz_outlined,
                AppColors.secondary,
                    () => context.push('/login'),
              ),
              _buildFeatureCard(
                context,
                'Progress Tracking',
                'Monitor your career development',
                Icons.trending_up_outlined,
                AppColors.info,
                    () => context.push('/login'),
              ),
              _buildFeatureCard(
                context,
                'Recommendations',
                'Discover new opportunities',
                Icons.lightbulb_outline,
                AppColors.warning,
                    () => context.push('/login'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuthenticatedHome(
      BuildContext context,
      AuthState authState,
      WidgetRef ref,
      ) {
    final user = authState.user;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section with User Info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, ${user?.firstName}!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Continue your career development journey',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (user != null) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          user.initials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              user.email,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Quick Stats
          if (user != null && user.isProfileComplete)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Summary',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (user.currentRole != null)
                    _buildInfoRow('Current Role', user.currentRole!),
                  if (user.company != null)
                    _buildInfoRow('Company', user.company!),
                  if (user.location != null)
                    _buildInfoRow('Location', user.location!),
                ],
              ),
            ),
          const SizedBox(height: 24),

          // Features Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildFeatureCard(
                context,
                'Career Quiz',
                'Assess your skills and interests',
                Icons.quiz_outlined,
                AppColors.secondary,
                    () => context.go('/quiz'),
              ),
              _buildFeatureCard(
                context,
                'Progress Tracking',
                'Monitor your career development',
                Icons.trending_up_outlined,
                AppColors.info,
                    () => context.go('/analytics'),
              ),
              _buildFeatureCard(
                context,
                'Recommendations',
                'Discover new opportunities',
                Icons.lightbulb_outline,
                AppColors.warning,
                    () => context.go('/recommendations'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context,
      String title,
      String description,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
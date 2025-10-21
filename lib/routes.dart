import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'services/auth_service.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/sign_up.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/chatbot_screen.dart';
import 'ui/screens/quiz_screen.dart';
import 'ui/screens/recommendations_screen.dart';
import 'ui/screens/analytics_screen.dart';
import 'ui/screens/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String chatbot = '/chatbot';
  static const String quiz = '/quiz';
  static const String recommendations = '/recommendations';
  static const String analytics = '/analytics';
  static const String quizDetail = '/quiz/:id';
  static const String courseDetail = '/course/:id';
  static const String jobDetail = '/job/:id';

  static GoRouter getRouter(WidgetRef ref) {
    return GoRouter(
      initialLocation: home,
      redirect: (context, state) {
        final authState = ref.watch(authStateProvider);
        final isAuthenticated = authState.isAuthenticated;

        // If not authenticated and trying to access protected routes
        if (!isAuthenticated &&
            (state.matchedLocation == profile ||
                state.matchedLocation == chatbot ||
                state.matchedLocation == quiz ||
                state.matchedLocation == recommendations ||
                state.matchedLocation == analytics)) {
          return login;
        }

        // If authenticated and trying to access auth routes, allow it
        return null;
      },
      routes: [
        GoRoute(
          path: home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: register,
          name: 'register',
          builder: (context, state) => const SignUp(),
        ),
        GoRoute(
          path: profile,
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: chatbot,
          name: 'chatbot',
          builder: (context, state) => const ChatbotScreen(),
        ),
        GoRoute(
          path: quiz,
          name: 'quiz',
          builder: (context, state) => const QuizScreen(),
        ),
        GoRoute(
          path: quizDetail,
          name: 'quizDetail',
          builder: (context, state) {
            final quizId = state.pathParameters['id']!;
            return QuizScreen(quizId: quizId);
          },
        ),
        GoRoute(
          path: recommendations,
          name: 'recommendations',
          builder: (context, state) => const RecommendationScreen(),
        ),
        GoRoute(
          path: analytics,
          name: 'analytics',
          builder: (context, state) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: courseDetail,
          name: 'courseDetail',
          builder: (context, state) {
            final courseId = state.pathParameters['id']!;
            return CourseDetailScreen(courseId: courseId);
          },
        ),
        GoRoute(
          path: jobDetail,
          name: 'jobDetail',
          builder: (context, state) {
            final jobId = state.pathParameters['id']!;
            return JobDetailScreen(jobId: jobId);
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Page Not Found'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'The page you are looking for does not exist.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: chatbot,
        name: 'chatbot',
        builder: (context, state) => const ChatbotScreen(),
      ),
      GoRoute(
        path: quiz,
        name: 'quiz',
        builder: (context, state) => const QuizScreen(),
      ),
      GoRoute(
        path: quizDetail,
        name: 'quizDetail',
        builder: (context, state) {
          final quizId = state.pathParameters['id']!;
          return QuizScreen(quizId: quizId);
        },
      ),
      GoRoute(
        path: recommendations,
        name: 'recommendations',
        builder: (context, state) => const RecommendationScreen(),
      ),
      GoRoute(
        path: analytics,
        name: 'analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: courseDetail,
        name: 'courseDetail',
        builder: (context, state) {
          final courseId = state.pathParameters['id']!;
          return CourseDetailScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: jobDetail,
        name: 'jobDetail',
        builder: (context, state) {
          final jobId = state.pathParameters['id']!;
          return JobDetailScreen(jobId: jobId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

// Placeholder screens for course and job details
class CourseDetailScreen extends StatelessWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course $courseId'),
      ),
      body: Center(
        child: Text('Course Detail Screen for ID: $courseId'),
      ),
    );
  }
}

class JobDetailScreen extends StatelessWidget {
  final String jobId;

  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job $jobId'),
      ),
      body: Center(
        child: Text('Job Detail Screen for ID: $jobId'),
      ),
    );
  }
}
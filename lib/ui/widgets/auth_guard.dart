import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../routes.dart';

class AuthGuard extends ConsumerWidget {
  final Widget child;
  final bool requireAuth;

  const AuthGuard({
    super.key,
    required this.child,
    this.requireAuth = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    // If authentication is required but user is not authenticated
    if (requireAuth && !authState.isAuthenticated) {
      // Redirect to login page
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRoutes.login);
      });
      
      // Show loading screen while redirecting
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // If user is authenticated but trying to access auth pages
    if (!requireAuth && authState.isAuthenticated) {
      // Redirect to home page
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRoutes.home);
      });
      
      // Show loading screen while redirecting
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return child;
  }
}

// Helper function to wrap routes with auth guard
Widget authRequired(Widget child) {
  return AuthGuard(
    requireAuth: true,
    child: child,
  );
}

Widget authNotRequired(Widget child) {
  return AuthGuard(
    requireAuth: false,
    child: child,
  );
}

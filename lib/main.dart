import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/themes.dart';
import 'core/constants.dart';
import 'routes.dart';
import 'services/auth_service.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CareerNavigatorApp(),
    ),
  );
}

class CareerNavigatorApp extends ConsumerWidget {
  const CareerNavigatorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize auth on app startup
    ref.listen(authStateProvider, (previous, next) {
      // Auth state changes will be handled by the router
    });

    // Trigger auth initialization
    ref.watch(authStateProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRoutes.router,
    );
  }
}
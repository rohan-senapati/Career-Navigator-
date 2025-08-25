import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/themes.dart';
import 'core/constants.dart';
import 'routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CareerNavigatorApp(),
    ),
  );
}

class CareerNavigatorApp extends StatelessWidget {
  const CareerNavigatorApp({super.key});

  @override
  Widget build(BuildContext context) {
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

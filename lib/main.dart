import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'SignupScreen.dart';
import 'destinations_screen.dart';
import 'start_screen.dart';
import 'welcome_screen.dart';

// Top-level GoRouter configuration
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StartScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/welcome/:name',
      builder: (context, state) {
        final name = Uri.decodeComponent(state.pathParameters['name'] ?? '');
        return WelcomeScreen(name: name);
      },
    ),
    GoRoute(
      path: '/destinations',
      builder: (context, state) => const DestinationsScreen(),
    ),
  ],
);

void main() {
  runApp(const WanderlyApp());
}

class WanderlyApp extends StatefulWidget {
  const WanderlyApp({super.key});

  static _WanderlyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_WanderlyAppState>();

  @override
  State<WanderlyApp> createState() => _WanderlyAppState();
}

class _WanderlyAppState extends State<WanderlyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pink theme seed color for Dora the Explorer theme
    const seedColor = Color(0xFFE91E63);

    return MaterialApp.router(
      title: 'Dora the Explorer',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}

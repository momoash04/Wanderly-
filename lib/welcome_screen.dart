import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  final String name;

  const WelcomeScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.explore, size: 80, color: colors.onPrimary),
            const SizedBox(height: 16),
            Text(
              'Welcome, $name!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colors.onPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your journey begins here!',
              style: TextStyle(
                fontSize: 18,
                color: colors.onPrimary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push('/destinations');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: colors.primary,
                backgroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Browse Destinations'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback? onToggleTheme;

  const StartScreen({
    super.key,
    this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('soret dora2.jpeg'),
            ),
            const SizedBox(height: 24),
            Text(
              'Dora the Explorer',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: colors.onPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Let’s go on an adventure!',
              style: TextStyle(
                fontSize: 20,
                color: colors.onPrimary,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.push('/signup');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: colors.primary,
                backgroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Ebda2 AL-Ekteshaf'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (onToggleTheme != null) {
                  onToggleTheme!();
                } else {
                  WanderlyApp.of(context)?.toggleTheme();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: colors.primary,
                backgroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Toggle Theme'),
            ),
          ],
        ),
      ),
    );
  }
}

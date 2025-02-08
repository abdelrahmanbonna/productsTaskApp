import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:task_app/Core/Widgets/animated_bounceable.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation with bounce effect
            AnimatedBounceable(
              onTap: () {},
              animationType: AnimationType.fadeInDown,
              child: const Icon(
                Icons.shopping_cart,
                size: 100,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            // Title animation with bounce effect
            AnimatedBounceable(
              onTap: () {},
              animationType: AnimationType.fadeInUp,
              delay: const Duration(milliseconds: 500),
              child: const Text(
                'Sales App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Loading indicator animation
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 1000),
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

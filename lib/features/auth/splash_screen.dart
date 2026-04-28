import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/auth_service.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFD297B), Color(0xFFFF655B)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Center(
          child: authState.when(
            data: (user) {
              // Delay routing slightly to avoid build phase issues and show off splash
              Future.delayed(const Duration(milliseconds: 500), () {
                if (context.mounted) {
                  if (user != null) {
                    context.go('/home');
                  } else {
                    context.go('/login');
                  }
                }
              });
              
              // Logo animation could go here, for now use a sleek icon
              return const Icon(Icons.favorite, size: 100, color: Colors.white);
            },
            loading: () => const CircularProgressIndicator(color: Colors.white),
            error: (e, st) => Text('Error: $e', style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

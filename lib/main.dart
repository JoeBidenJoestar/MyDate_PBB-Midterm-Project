import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'core/services/isar_service.dart';
import 'core/widgets/connectivity_banner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Pre-warm Isar Service to ensure it opens before UI needs it
  final container = ProviderContainer();
  await container.read(isarServiceProvider).db;
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyDateApp(),
    ),
  );
}

class MyDateApp extends StatelessWidget {
  const MyDateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyDateApp',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Forced Dark Mode
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ConnectivityBanner(child: child!);
      },
    );
  }
}

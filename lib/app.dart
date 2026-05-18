import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/behavior_observer.dart';
import 'core/theme.dart';
import 'models/adaptive_ui_settings.dart';
import 'providers/adaptive_ui_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';
import 'services/behavior_log_service.dart';

class YakssokApp extends ConsumerStatefulWidget {
  const YakssokApp({super.key});

  @override
  ConsumerState<YakssokApp> createState() => _YakssokAppState();
}

class _YakssokAppState extends ConsumerState<YakssokApp> {
  late final BehaviorNavigatorObserver _behaviorObserver;

  @override
  void initState() {
    super.initState();
    _behaviorObserver = BehaviorNavigatorObserver(
      onEvent: (event) =>
          ref.read(behaviorLogServiceProvider.notifier).logEvent(event),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref
        .watch(adaptiveUIControllerProvider)
        .valueOrNull
        ?? const AdaptiveUISettings();

    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: settings.highContrast ? AppTheme.highContrast : AppTheme.light,
      navigatorObservers: [_behaviorObserver],
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(settings.textScale),
        ),
        child: child!,
      ),
      home: const _AuthGate(),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final session = snapshot.data?.session ??
            Supabase.instance.client.auth.currentSession;
        if (session != null) return const MainScreen();
        return const LoginScreen();
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'screens/main_screen.dart';

/// MaterialApp + 테마 + 라우팅.
/// 추후 GoRouter 도입 시 [home]을 [routerConfig]로 교체.
class YakssokApp extends StatelessWidget {
  const YakssokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainScreen(),
    );
  }
}

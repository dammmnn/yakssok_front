import 'package:flutter/material.dart';
import 'package:yakssok_front/core/theme/app_theme.dart';
import 'package:yakssok_front/shared/widgets/main_scaffold.dart';

void main() {
  runApp(const YakssokApp());
}

class YakssokApp extends StatelessWidget {
  const YakssokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yak-sok',
      theme: AppTheme.lightTheme,
      home: const MainScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  try {
    await FlutterNaverMap().init(
      clientId: 'j6tn20kmdo',
      onAuthFailed: (ex) => debugPrint('네이버 지도 인증 실패: $ex'),
    );
  } catch (e) {
    debugPrint('네이버 지도 초기화 실패: $e');
  }

  runApp(
    const ProviderScope(
      child: YakssokApp(),
    ),
  );
}

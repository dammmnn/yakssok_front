import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yakssok_front/main.dart';

void main() {
  testWidgets('앱이 정상적으로 실행된다', (WidgetTester tester) async {
    await tester.pumpWidget(const YakssokApp());
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

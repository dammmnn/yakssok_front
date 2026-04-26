import 'package:flutter/material.dart';
import 'package:yakssok_front/shared/widgets/app_header.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            AppHeader(
              title: 'Calendar',
              leadingIcon: Icons.calendar_month_rounded,
              leadingBackgroundColor: Color(0xFF2E66E8),
            ),
            SizedBox(height: 28),
            Text(
              'Calendar Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          '달력 화면',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

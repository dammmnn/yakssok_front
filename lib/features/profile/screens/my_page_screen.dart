import 'package:flutter/material.dart';
import 'package:yakssok_front/shared/widgets/app_header.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(
              title: 'My Page',
              leadingIcon: Icons.person_rounded,
              leadingBackgroundColor: Color(0xFF6C4CCF),
            ),
            SizedBox(height: 28),
            Text(
              'My Page Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          '더보기 화면',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

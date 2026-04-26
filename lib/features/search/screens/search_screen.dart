import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          '검색 화면',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

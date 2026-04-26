import 'package:flutter/material.dart';
import 'package:yakssok_front/shared/widgets/app_header.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(
              title: 'Search',
              leadingIcon: Icons.search_rounded,
              leadingBackgroundColor: Color(0xFFF08A24),
            ),
            SizedBox(height: 28),
            Text(
              'Search Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

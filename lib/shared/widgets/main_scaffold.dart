import 'package:flutter/material.dart';
import 'package:yakssok_front/features/calendar/screens/calendar_screen.dart';
import 'package:yakssok_front/features/home/screens/home_screen.dart';
import 'package:yakssok_front/features/profile/screens/my_page_screen.dart';
import 'package:yakssok_front/features/search/screens/search_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  static const List<_TabItem> _tabs = [
    _TabItem(
      label: '홈',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    _TabItem(
      label: '검색',
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
    ),
    _TabItem(
      label: '달력',
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month,
    ),
    _TabItem(
      label: '더보기',
      icon: Icons.more_horiz,
      activeIcon: Icons.more_horiz,
    ),
  ];

  static const List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    CalendarScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _tabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                activeIcon: Icon(tab.activeIcon),
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TabItem {
  const _TabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

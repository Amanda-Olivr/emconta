import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'home/groups_list_screen.dart';
import 'activity/activity_screen.dart';
import 'profile/profile_screen.dart';
import 'widgets/bottom_nav_bar.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 1; // Start on Groups tab as per the Stitch design

  final List<Widget> _screens = const [
    HomeScreen(),
    GroupsListScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

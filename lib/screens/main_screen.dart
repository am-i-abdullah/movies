import 'package:flutter/material.dart';
import 'package:movies/screens/dashboard_screen.dart';
import 'package:movies/screens/media_library_screen.dart';
import 'package:movies/screens/more_screen.dart';
import 'package:movies/screens/watch_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _screenIndex = 0;

  final _screens = [
    const DashboardScreen(),
    const WatchScreen(),
    const MediaLibraryScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_screenIndex],
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(246, 246, 250, 1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(27),
          child: Container(
            color: const Color.fromRGBO(46, 39, 47, 1),
            padding: const EdgeInsets.all(10),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              currentIndex: _screenIndex,
              onTap: (index) {
                setState(() {
                  _screenIndex = index;
                });
              },

              elevation: 0,
              // items style
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color.fromRGBO(130, 125, 136, 1),

              // labels styling
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: 'Watch',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: 'Media Library',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.more_vert_sharp),
                  label: 'More',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

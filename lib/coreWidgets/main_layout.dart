import 'package:app/screens/home.dart';
import 'package:app/screens/profile.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const ProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: _getBottomNavigationBar(),
      body: pages[currentPage],
    );
  }

  Widget _getBottomNavigationBar() {
    const selectedColor = Colors.purple;
    return BottomNavigationBar(
      selectedItemColor: selectedColor,
      selectedLabelStyle: const TextStyle(color: selectedColor),
      currentIndex: currentPage,
      onTap: (value) {
        setState(() {
          currentPage = value;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
        // Diğer sayfaları ekleyebilirsiniz.
      ],
    );
  }
}

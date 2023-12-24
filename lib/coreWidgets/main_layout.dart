import 'package:app/core/app/controllers/app_controller.dart';
import 'package:app/screens/accounts/accounts_page.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool userFetched = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<AppController>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const AccountsPage(),
      const ProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: _getBottomNavigationBar(),
      body: Builder(builder: (context) {
        if (context.watch<AppController>().user != null) {
          return pages[currentPage];
        } else {
          return const Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            ),
          );
        }
      }),
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
          icon: Icon(Icons.wallet),
          label: 'Hesaplar',
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

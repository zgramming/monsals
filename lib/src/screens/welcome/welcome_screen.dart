import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../provider/my_provider.dart';
import '../activity/activity_screen.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';
import '../product/product_screen.dart';
import './appbar_monsals.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeNamed = '/welcome-screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 1;

  List<Widget> screens = [
    ActivityScreen(),
    const HomeScreen(),
    ProductScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMonsals(
        actions: [
          IconButton(
            onPressed: () async {
              await context.read(userProvider.notifier).logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeNamed);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      // body: screens.elementAt(_selectedIndex),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _selectedIndex = index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: colorPallete.primaryColor,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Text(
              'Kegiatan',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'Produk',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

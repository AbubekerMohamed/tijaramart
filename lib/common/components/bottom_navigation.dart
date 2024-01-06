import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tijaramart/features/account/screens/account_screen.dart';
import 'package:tijaramart/features/home/screens/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const Center(
      child: Text("Cart Page"),
    ),
    const Center(
      child: AccountScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[_page]),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.purple[200],
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: GNav(
              iconSize: 28,
              backgroundColor: Colors.purple[200]!,
              color: Colors.black87,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.all(16),
              gap: 5,
              onTabChange: (index) {
                updatePageNumber(index);
              },
              tabs: [
                const GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.shopping_cart,
                  text: "Cart",
                  leading: Badge(
                    label: const Text("1"),
                    offset: const Offset(12, -12),
                    child: Icon(
                      Icons.shopping_cart,
                      color: _page == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const GButton(
                  icon: Icons.person,
                  text: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updatePageNumber(int page) {
    setState(() {
      _page = page;
    });
  }
}

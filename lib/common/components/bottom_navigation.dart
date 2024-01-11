import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:tijaramart/features/account/screens/account_screen.dart';
import 'package:tijaramart/features/cart/screens/cart_screen.dart';
import 'package:tijaramart/features/home/screens/home_screen.dart';
import 'package:tijaramart/providers/user_provider.dart';

class BottomNavigation extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _page = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const Center(
      child: AccountScreen(),
    ),
  ];

  void updatePageNumber(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartCount = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: Stack(
        children: [
          pages[_page],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Container(
                  color: Colors.purple.shade200.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    child: GNav(
                      iconSize: 28,
                      backgroundColor: Colors.transparent,
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
                            label: Text(userCartCount.toString()),
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
            ),
          ),
        ],
      ),
    );
  }
}

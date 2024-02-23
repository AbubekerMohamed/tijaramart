import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/admin/components/orders_page.dart';
import 'package:tijaramart/features/admin/components/products_page.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;

  List<Widget> pages = [
    const ProductsPage(),
    const Center(
      child: Text("Analytics Page"),
    ),
    const OrdersPage(),
    const Center(
      child: Text("Settings Page"),
    ),
  ];

  void updatePageNumber(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const CircleAvatar(
                foregroundImage: AssetImage("assets/images/img3.png"),
              ),
            ],
          ),
        ),
      ),
      body: pages[_page],
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
              tabs: const [
                GButton(
                  icon: Icons.shopify,
                  text: "Products",
                ),
                GButton(
                  icon: Icons.analytics_outlined,
                  text: "Analytics",
                ),
                GButton(
                  icon: Icons.inbox_outlined,
                  text: "Orders",
                ),
                GButton(
                  icon: Icons.settings_outlined,
                  text: "Settings",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

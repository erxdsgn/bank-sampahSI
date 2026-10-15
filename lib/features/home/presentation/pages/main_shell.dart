import 'package:flutter/material.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../orders/presentation/pages/orders_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../../shared/models/nav_item_model.dart';
import '../../../../shared/widgets/custom_bottom_navbar.dart';
import 'home_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<NavItem> _navItems = const [
    NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    NavItem(icon: Icons.shopping_cart_outlined, activeIcon: Icons.shopping_cart, label: 'Cart'),
    NavItem(icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long, label: 'Orders'),
    NavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  final List<Widget> _pages = const [
    HomePage(),
    CartPage(),
    OrdersPage(),
    ProfilePage(),
  ];

  void _onTabChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scan ditekan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _currentIndex,
        onTabChanged: _onTabChanged,
        onFabPressed: _onFabPressed,
        items: _navItems,
      ),
    );
  }
}
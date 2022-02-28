import 'package:flutter/material.dart';
import 'package:pill_pal/screens/cart/cart_screen.dart';
import 'package:pill_pal/screens/feeds_screen.dart';
import 'package:pill_pal/screens/home_screen.dart';
import 'package:pill_pal/screens/search_screen.dart';
import 'package:pill_pal/screens/user_scren.dart';

class BottomNavScreen extends StatefulWidget {
  static const routeName = '/Bottom-nav-screen';
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _pages = [
    const HomeScreenNew(),
    FeedsScreen(),
    const SearchScreen(),
    const CartScreen(),
    const UserScreen(),
  ];

  int _currentIndex = 0;

  _onTap(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home', tooltip: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed), label: 'Product', tooltip: 'Product'),
          BottomNavigationBarItem(icon: Icon(null), label: '', tooltip: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Cart', tooltip: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'User', tooltip: 'User'),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        tooltip: 'Search',
        onPressed: () {
          _onTap(2);
        },
      ),
    );
  }
}

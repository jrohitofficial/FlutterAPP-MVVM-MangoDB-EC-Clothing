import 'package:flutter/material.dart';
import 'package:flutter_library_managent/features/Home/presentation/screen/cart_screen.dart';
import 'package:flutter_library_managent/features/Home/presentation/screen/home_screen.dart';

import '../../../profile/presentation/profile_screen.dart';

class NavigationDrawers extends StatefulWidget {
  const NavigationDrawers({super.key});

  @override
  State<NavigationDrawers> createState() => _NavigationDrawersState();
}

class _NavigationDrawersState extends State<NavigationDrawers> {
  int _selectedIndex = 0;
  List<Widget> lstWidget = [HomeScreen(), CartScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(247, 0, 0, 0),
        currentIndex: _selectedIndex,
        unselectedItemColor: Color.fromARGB(255, 215, 215, 215),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 10,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Cart Items',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
      body: lstWidget[_selectedIndex],
    );
  }
}

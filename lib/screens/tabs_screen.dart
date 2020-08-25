import 'package:flutter/material.dart';

import '../localization/demo_localization.dart';
import '../screens/products_overview_screen.dart';
import '../screens/profile_screen.dart';
import './cart_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _screens = [
    ProductOverviewScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: SizedBox(
        height: (MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.11,
        child: BottomNavigationBar(
          onTap: _selectScreen,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedScreenIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                getTranslated(context, 'home').toString(),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text(
                getTranslated(context, 'favorites').toString(),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(
                getTranslated(context, 'cart').toString(),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                getTranslated(context, 'profile').toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';
import '../localization/demo_localization.dart';
import '../models/product.dart';
import '../screens/products_overview_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _screens = [
    StreamProvider<List<Product>>.value(
        value: Database().products, child: ProductOverviewScreen()),
    StreamProvider<List<Product>>.value(
        value: Database().products, child: FavoritesScreen()),
    StreamProvider<List<Product>>.value(
        value: Database().products, child: CartScreen()),
    StreamProvider<List<Product>>.value(
        value: Database().products, child: ProfileScreen()),
  ];

  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height =
        mq.size.height - AppBar().preferredSize.height - mq.padding.top;

    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: SizedBox(
        height: height * 0.11,
        child: BottomNavigationBar(
          onTap: _selectScreen,
          elevation: 20,
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

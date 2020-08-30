import 'package:flutter/material.dart';
import 'package:vegefruit/localization/demo_localization.dart';

import '../screens/orders_screen.dart';
import '../screens/select_products_screen.dart';
import '../screens/stock_screen.dart';

class AdminTabsScreen extends StatefulWidget {
  @override
  _AdminTabsScreenState createState() => _AdminTabsScreenState();
}

class _AdminTabsScreenState extends State<AdminTabsScreen> {
  final List<Widget> _screens = [
    SelectProductsScreen(),
    StockScreen(),
    OrdersScreen(),
    // AddProductScreen(),
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
              icon: Icon(Icons.storage),
              title: Text(
                getTranslated(context, 'stock').toString(),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(
                getTranslated(context, 'orders').toString(),
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.add),
            //   title: Text(
            //     getTranslated(context, 'newProduct').toString(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';
import '../localization/demo_localization.dart';
import '../models/product.dart';
import '../screens/orders_screen.dart';
import '../screens/select_products_screen.dart';
import '../screens/stock_screen.dart';

class AdminTabsScreen extends StatefulWidget {
  @override
  _AdminTabsScreenState createState() => _AdminTabsScreenState();
}

class _AdminTabsScreenState extends State<AdminTabsScreen> {
  final List<Widget> _screens = [
    StreamProvider<List<Product>>.value(
        value: Database().products, child: SelectProductsScreen()),

    StreamProvider<List<Product>>.value(
        value: Database().products, child: StockScreen()),
    OrdersScreen(),
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
          ],
        ),
      ),
    );
  }
}

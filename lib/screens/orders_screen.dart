import 'package:flutter/material.dart';

import '../widgets/header_without_back.dart';
import '../localization/demo_localization.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: (MediaQuery.of(context).size.width) * 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWithoutBack('orders'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/demo_localization.dart';
import '../widgets/empty_status.dart';
import '../widgets/header_without_back.dart';
import '../models/is_arabic.dart';
import '../models/product.dart';
import '../widgets/list_item.dart';

class StockScreen extends StatefulWidget {
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Product> allProductList = Provider.of<List<Product>>(context);

    return Scaffold(
      key: _key,
      body: (allProductList != null)
          ? Container(
              width: (MediaQuery.of(context).size.width) * 1.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderWithoutBack('currentStock'),
                    (allProductList
                                .where((p) => (p.isSelected == true))
                                .toList()
                                .length !=
                            0)
                        ? Container(
                            child: Expanded(
                                child: ListView.builder(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                left: 20.0,
                                right: 20.0,
                                bottom: 20.0,
                              ),
                              itemCount: allProductList
                                  .where((p) => (p.isSelected == true))
                                  .toList()
                                  .length,
                              itemBuilder: (ctx, i) {
                                return ListItem(
                                    scaffoldKey: _key,
                                    id: allProductList
                                        .where((p) => (p.isSelected == true))
                                        .toList()
                                        .reversed
                                        .toList()[i]
                                        .id,
                                    title: isArabic(context)
                                        ? allProductList
                                            .where(
                                                (p) => (p.isSelected == true))
                                            .toList()
                                            .reversed
                                            .toList()[i]
                                            .titleAr
                                        : allProductList
                                            .where(
                                                (p) => (p.isSelected == true))
                                            .toList()
                                            .reversed
                                            .toList()[i]
                                            .titleEn,
                                    price: allProductList
                                        .where((p) => (p.isSelected == true))
                                        .toList()
                                        .reversed
                                        .toList()[i]
                                        .price,
                                    quantity: allProductList
                                        .where((p) => (p.isSelected == true))
                                        .toList()
                                        .reversed
                                        .toList()[i]
                                        .quantity,
                                    color: allProductList
                                        .where((p) => (p.isSelected == true))
                                        .toList()
                                        .reversed
                                        .toList()[i]
                                        .color,
                                    imageUrl: allProductList
                                        .where((p) => (p.isSelected == true))
                                        .toList()
                                        .reversed
                                        .toList()[i]
                                        .image);
                              },
                            )),
                          )
                        : EmptyStatus(
                            message: getTranslated(context, 'emptyStock')),
                  ]),
            )
          : Center(
              child: Text(getTranslated(context, 'loading')),
            ),
    );
  }
}
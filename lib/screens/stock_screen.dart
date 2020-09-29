import 'package:flutter/material.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../models/is_arabic.dart';
import '../models/product.dart';
import '../widgets/hedear.dart';
import '../widgets/list_item.dart';

class StockScreen extends StatefulWidget {
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> allProductList = Provider.of<List<Product>>(context);
    List<Product> selestedProductList =
        allProductList.where((p) => (p.isSelected == true)).toList();

    return Scaffold(
      body: Container(
        width: (MediaQuery.of(context).size.width) * 1.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Header('currentStock'),
              Container(
                child: Expanded(
                  child: (selestedProductList != null)
                      ? ListView.builder(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 20.0,
                            right: 20.0,
                            bottom: 20.0,
                          ),
                          itemCount: selestedProductList.length,
                          itemBuilder: (ctx, i) {
                            return ListItem(
                                title: isArabic(context)
                                    ? selestedProductList[i].titleAr
                                    : selestedProductList[i].titleEn,
                                price: selestedProductList[i].price,
                                color: selestedProductList[i].color,
                                imageUrl: selestedProductList[i].image);
                          },
                        )
                      : Center(
                          child: Text('Loading...'),
                        ),

                  // : setState(() {
                  //     _showSpinner = true;
                  //   }),
                ),
              ),
            ]),
      ),
    );
  }
}

// mixin _SelectProductsScreenState {}

import 'package:flutter/material.dart';

import '../widgets/hedear.dart';
import '../widgets/list_item.dart';

class StockScreen extends StatelessWidget {
  final title = 'Mango';
  final price = 1.02;
  final priceDescription = 'largebox';
  final imageUrl = 'assets/images/mango.png';
  final color = Color(0xFFFF8D22);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: (MediaQuery.of(context).size.width) * 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header('currentStock'),
            Container(
              child: Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  itemCount: 8,
                  itemBuilder: (ctx, i) {
                    return ListItem(
                        title: title,
                        price: price,
                        color: color,
                        imageUrl: imageUrl);
                  },
                ),
              ),
            ),
            // Container(
            //     width: (MediaQuery.of(context).size.width) * 1,
            //     height: (MediaQuery.of(context).size.height -
            //             MediaQuery.of(context).padding.top) *
            //         0.15,
            //     decoration: BoxDecoration(
            //       color: Theme.of(context).primaryColor,
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(30),
            //         topRight: Radius.circular(30),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: <Widget>[
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Container(
            //               //width: (MediaQuery.of(context).size.width) * 0.3,
            //               height: (MediaQuery.of(context).size.height -
            //                       MediaQuery.of(context).padding.top) *
            //                   0.03,
            //               child: FittedBox(
            //                 child: Text(
            //                   getTranslated(context, 'total') + ':',
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 10,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               height: (MediaQuery.of(context).size.width) * 0.02,
            //             ),
            //             Container(
            //               //width: (MediaQuery.of(context).size.width) * 0.1,
            //               height: (MediaQuery.of(context).size.height -
            //                       MediaQuery.of(context).padding.top) *
            //                   0.04,
            //               child: Text(
            //                 isArabic(context)
            //                     ? price.toString() + ' ريال'
            //                     : price.toString() + ' SR',
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 20,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //         Container(
            //           width: (MediaQuery.of(context).size.width) * 0.5,
            //           height: (MediaQuery.of(context).size.height -
            //                   MediaQuery.of(context).padding.top) *
            //               0.1,
            //           decoration: BoxDecoration(
            //             color: Theme.of(context).primaryColor,
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(20),
            //             ),
            //             border: Border.all(
            //               color: Theme.of(context).canvasColor,
            //               width: 2,
            //             ),
            //           ),
            //           child: Center(
            //             child: Text(
            //               getTranslated(context, 'orderNow'),
            //               style: TextStyle(
            //                 color: Theme.of(context).canvasColor,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 20,
            //               ),
            //             ),
            //           ),
            //         )
            //       ],
            //     )),
          ],
        ),
      ),
    );
  }
}
